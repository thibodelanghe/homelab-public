# Homelab by Marcin

Welcome to my homelab project. This repository contains configurations and documentation for my self-hosted infrastructure. The purpose of this homelab is to experiment with and manage various technologies and services in a controlled environment, emphasizing self-hosting, simplicity, and Infrastructure as Code (IaaC) principles.

Manifesto:

* Self-host services and data
* Keep it simple, stupid (KISS)
* Define Infrastructure as a Code (IaaC)

Primary homelab based on Proxmox cluster and virtualization:

![Wieprz](docs/wieprz.jpg)

My first homelab built on Raspberry Pi years ago:

![Bekasow](docs/bekasow.jpg)

## Infrastructure as a Code

Terraform defines the following resources:

* Linux containers (LXC) on Proxmox
* Virtual private server in Google Cloud Platform (GCP)
* Tailscale access control lists (ACLs)

Ansible playbooks manage all the services and configurations, for example:

* Adguard DNS
* Apt Cacher NG
* Backup Ninja
* Docker
* Frigate
* Grafana
* Grafana Agent
* Gramps
* Hyperion NG
* Immich
* Kodi
* Loki
* Mailrise
* Mosqquitto
* NUT
* Omada Software Controller
* Paperless NGX
* Proxmox Backup Server
* Prometheus
* Raspotify
* RClone
* Samba
* SearXNG
* Shairport
* Stirling PDF
* Tailscale
* Traefik
* Transmission
* Uptime Kuma
* Vaultwarden
* Whoogle
* Zigbee2MQTT
* see [ansible/roles](ansible/roles) for more

## Documentation

If code doesn't tell the whole story, documentation does.
Here are some notes on various topics:

* [Network](docs/network.md): modems, routers, switches, access points
* [Hardware](docs/hardware.md): servers, disks, ups
* [CCTV](docs/cameras.md): cameras, motion detection
* [IoT](docs/iot.md): ZigBee coordinators, sensors, switches
* [Media](docs/media.md): TV box, streaming, audio
* [Proxmox](docs/proxmox.md): VMs and LXCs management
* [SSH](docs/ssh.md): Remote access to servers
* [Home Assistant](docs/ha.md): Automations, dashboards
* [Backup](docs/backup.md): Proxmox backup server

As always, I encourage you to visit my blog for more details [https://mkuthan.github.io/tags/#homelab](https://mkuthan.github.io/tags/#homelab).
