# CCM101 - Cloud Computing

# Laboratory Activity 10
## Mission 10: The Enterprise Cloud Architect

## Project

Secure Multi-Tier Web Application

## Application Stack

- Ubuntu Server
- Docker
- Docker Compose
- WordPress
- MySQL
- Docker Network
- Persistent Docker Volumes
- UFW Firewall
- Bash Automation
- Cron

## Prepared By

Rennald Emperador

## Section

BSIT 4-I

## Subject

CCM101 - Cloud Computing

## Architecture

The system uses a host laptop running an Ubuntu Server virtual
machine through a Type 2 hypervisor.

Ubuntu Server runs UFW, Docker, and Docker Compose.

Docker runs two application tiers:

1. WordPress application tier
2. MySQL database tier

The containers communicate through the cloudapp_network Docker
network.

Persistent Docker volumes are used for WordPress and MySQL data.

## Security

UFW uses a default-deny incoming policy.

Allowed ports:

- 22/tcp - SSH
- 8080/tcp - Web Application

## Automation

The automation-script.sh file creates compressed MySQL database
backups.

Cron schedules the backup to run every day at 2:00 AM.

## Application Access

Find the Ubuntu Server IP:

    hostname -I

Then open:

    http://SERVER-IP:8080

## Deployment

Start:

    docker compose up -d

Stop:

    docker compose down

Check:

    docker compose ps

## Verification

Check containers:

    docker ps

Check volumes:

    docker volume ls

Check firewall:

    sudo ufw status verbose

Check Cron:

    crontab -l

Run backup:

    ./automation-script.sh
