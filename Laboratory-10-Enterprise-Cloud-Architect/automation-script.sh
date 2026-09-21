#!/bin/bash

# ==========================================================
# CCM101 - Enterprise Cloud Architect
# Automated MySQL Database Backup
# ==========================================================

# Automatically detect the project directory
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$PROJECT_DIR/backups"

CONTAINER_NAME="cloudapp_mysql"
DATABASE_NAME="wordpress"
DATABASE_USER="root"
DATABASE_PASSWORD="rootpassword123"

DATE=$(date +"%Y%m%d_%H%M%S")

BACKUP_FILE="$BACKUP_DIR/wordpress_database_$DATE.sql"
LOG_FILE="$BACKUP_DIR/backup.log"

# Create backup directory
mkdir -p "$BACKUP_DIR"

echo "==========================================" >> "$LOG_FILE"
echo "Backup started: $(date)" >> "$LOG_FILE"

# Check if MySQL container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "ERROR: MySQL container is not running." >> "$LOG_FILE"
    echo "Backup failed: $(date)" >> "$LOG_FILE"
    exit 1
fi

echo "MySQL container is running." >> "$LOG_FILE"

# Create MySQL database backup
docker exec "$CONTAINER_NAME" \
    mysqldump \
    -u"$DATABASE_USER" \
    -p"$DATABASE_PASSWORD" \
    "$DATABASE_NAME" > "$BACKUP_FILE"

# Check backup result
if [ $? -eq 0 ]; then

    gzip "$BACKUP_FILE"

    echo "Database backup completed successfully." >> "$LOG_FILE"
    echo "Backup file: ${BACKUP_FILE}.gz" >> "$LOG_FILE"

    # Delete backups older than 7 days
    find "$BACKUP_DIR" \
        -type f \
        -name "wordpress_database_*.sql.gz" \
        -mtime +7 \
        -delete

    echo "Old backups removed." >> "$LOG_FILE"

else

    echo "ERROR: Database backup failed." >> "$LOG_FILE"
    exit 1

fi

echo "Backup finished: $(date)" >> "$LOG_FILE"
echo "==========================================" >> "$LOG_FILE"

exit 0
