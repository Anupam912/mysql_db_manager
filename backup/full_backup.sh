#!/bin/bash
# Full backup of MySQL database

TIMESTAMP=$(date +"%F")
BACKUP_DIR="/path/to/backup/directory"
MYSQL_USER="root"
MYSQL_PASSWORD="password"
MYSQL_DATABASE="your_database"

mkdir -p "$BACKUP_DIR/$TIMESTAMP"

mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > "$BACKUP_DIR/$TIMESTAMP/full_backup.sql"

if [ $? -eq 0 ]; then
    echo "Full backup successful!"
else
    echo "Full backup failed!"
fi
