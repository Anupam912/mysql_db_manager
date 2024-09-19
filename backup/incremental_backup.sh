#!/bin/bash
# Incremental backup of MySQL database using binary logs

TIMESTAMP=$(date +"%F")
BACKUP_DIR="/path/to/backup/directory"
MYSQL_USER="root"
MYSQL_PASSWORD="password"
MYSQL_DATABASE="your_database"

mysqladmin -u $MYSQL_USER -p$MYSQL_PASSWORD flush-logs

BINLOG_DIR="/var/lib/mysql"
cp $BINLOG_DIR/mysql-bin.* "$BACKUP_DIR/$TIMESTAMP/"

if [ $? -eq 0 ]; then
    echo "Incremental backup successful!"
else
    echo "Incremental backup failed!"
fi
