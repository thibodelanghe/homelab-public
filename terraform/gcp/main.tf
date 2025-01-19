terraform {
  backend "gcs" {
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "= 6.2.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
}

locals {
  vps_region       = "us-east1"
  vps_zone         = "us-east1-b"
  vps_machine_type = "e2-micro"

  default_ssh_public_keys = file("${path.module}/../ssh_public_keys")
}

# backup bucket

resource "google_storage_bucket" "backup" {
  name          = var.backup_bucket
  location      = var.backup_region
  storage_class = "STANDARD"

  soft_delete_policy {
    retention_duration_seconds = 2592000 # 30 days
  }
}

# vps

resource "google_compute_network" "vps_network" {
  name                    = "vps-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vps_subnetwork" {
  name          = "vps-subnetwork"
  network       = google_compute_network.vps_network.id
  region        = local.vps_region
  ip_cidr_range = "10.0.0.0/24"
}

resource "google_compute_instance" "vps" {
  name = "vps"

  zone         = local.vps_zone
  machine_type = local.vps_machine_type

  hostname = var.vps_hostname

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network    = google_compute_network.vps_network.self_link
    subnetwork = google_compute_subnetwork.vps_subnetwork.self_link
  }

  metadata = {
    ssh-keys        = "root:${local.default_ssh_public_keys}"
    enable-osconfig = "TRUE"
  }
}

resource "google_compute_router" "vps_router" {
  name    = "vps-router"
  network = google_compute_network.vps_network.id
  region  = google_compute_subnetwork.vps_subnetwork.region
}

resource "google_compute_router_nat" "vps_nat" {
  name                               = "vps-nat"
  router                             = google_compute_router.vps_router.name
  region                             = google_compute_subnetwork.vps_subnetwork.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
