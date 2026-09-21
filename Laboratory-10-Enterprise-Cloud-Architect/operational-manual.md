# CCM101 - Cloud Computing

# Enterprise Cloud Architect - Operational Manual

## Project

Secure Multi-Tier Web Application

## Application Stack

WordPress + MySQL + Docker Compose

## Prepared By

Rennald Emperador

## Section

BSIT 4-I

## Subject

CCM101 - Cloud Computing

## Date

September 2026


# 1. System Overview

This project implements a multi-tier web application using Ubuntu
Server, Docker, Docker Compose, WordPress, and MySQL.

The infrastructure consists of:

- Host laptop
- Type 2 hypervisor
- Ubuntu Server virtual machine
- UFW firewall
- Docker Engine
- Docker Compose
- WordPress container
- MySQL container
- Persistent Docker volumes
- Bash backup automation
- Cron scheduling


# 2. Architecture

The host laptop runs the Ubuntu Server virtual machine through a
Type 2 hypervisor.

Ubuntu Server runs UFW and Docker.

Docker provides the WordPress and MySQL containers.

WordPress communicates with MySQL through the Docker network
cloudapp_network.

Persistent volumes store WordPress and MySQL data.


# 3. Docker Installation

Update Ubuntu:

    sudo apt update

Install Docker:

    sudo apt install -y docker.io docker-compose-plugin

Enable Docker:

    sudo systemctl enable docker

Start Docker:

    sudo systemctl start docker

Verify:

    docker --version

    docker compose version


# 4. Application Deployment

Enter the project directory:

    cd ~/Laboratory-10-Enterprise-Cloud-Architect

Validate Compose:

    docker compose config

Download images:

    docker compose pull

Start application:

    docker compose up -d

Check:

    docker compose ps


# 5. Application Access

Find the server IP:

    hostname -I

Open:

    http://SERVER-IP:8080

Replace SERVER-IP with the Ubuntu Server IP address.


# 6. Container Management

List containers:

    docker ps

View WordPress logs:

    docker logs cloudapp_wordpress

View MySQL logs:

    docker logs cloudapp_mysql


# 7. Persistent Storage

List Docker volumes:

    docker volume ls

Inspect MySQL volume:

    docker volume inspect cloudapp_db_data

Inspect WordPress volume:

    docker volume inspect cloudapp_wordpress_data


# 8. Firewall Security

Reset UFW:

    sudo ufw --force reset

Set default deny:

    sudo ufw default deny incoming

Allow outgoing:

    sudo ufw default allow outgoing

Allow SSH:

    sudo ufw allow 22/tcp

Allow web application:

    sudo ufw allow 8080/tcp

Enable:

    sudo ufw --force enable

Check:

    sudo ufw status verbose


# 9. Automated Backup

The backup script is:

    automation-script.sh

Make it executable:

    chmod +x automation-script.sh

Run:

    ./automation-script.sh

View backup files:

    ls -lh backups/

View backup log:

    cat backups/backup.log


# 10. Cron

The backup is scheduled every day at 2:00 AM.

Cron entry:

    0 2 * * * /home/ubuntu/Laboratory-10-Enterprise-Cloud-Architect/automation-script.sh

Check:

    crontab -l


# 11. Monitoring

Check containers:

    docker ps

Check disk:

    df -h

Check memory:

    free -h

Check CPU:

    lscpu

Check Docker service:

    sudo systemctl status docker


# 12. Restart Procedure

Stop the application:

    docker compose down

Start the application:

    docker compose up -d

Verify:

    docker compose ps


# 13. Troubleshooting

## WordPress does not load

Run:

    docker compose ps

Then:

    docker logs cloudapp_wordpress


## MySQL does not start

Run:

    docker logs cloudapp_mysql


## Docker is stopped

Run:

    sudo systemctl status docker

Start Docker:

    sudo systemctl start docker


## Firewall blocks application

Check:

    sudo ufw status verbose

Allow application:

    sudo ufw allow 8080/tcp


## Backup fails

Check:

    docker ps

Then:

    ./automation-script.sh

Read:

    cat backups/backup.log


# 14. Maintenance

Regular maintenance includes:

- Checking Docker containers
- Checking application logs
- Checking database logs
- Checking disk usage
- Checking persistent volumes
- Checking firewall configuration
- Checking backup files
- Testing backup restoration
- Checking Cron configuration


# 15. Recovery

If the containers stop:

    docker compose up -d

If the server restarts:

    sudo systemctl start docker

Then:

    docker compose up -d

Persistent Docker volumes retain application and database data.


# 16. Conclusion

The infrastructure demonstrates a multi-tier application deployed
using Docker Compose on Ubuntu Server.

It includes persistent storage, firewall security, automated database
backup, scheduled operations, and technical documentation.
