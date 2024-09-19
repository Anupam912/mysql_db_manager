#!/bin/bash
# Perform MySQL backup and upload to AWS S3

BACKUP_DIR="/path/to/backup"
TIMESTAMP=$(date +"%F")
MYSQL_USER="root"
MYSQL_PASSWORD="password"
DATABASE="your_database"

# Create backup
mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $DATABASE > $BACKUP_DIR/$DATABASE-$TIMESTAMP.sql

if [ $? -eq 0 ]; then
    echo "Backup created successfully."
else
    echo "Backup failed."
    exit 1
fi

# Upload to AWS S3 (Ensure AWS CLI is installed and configured)
aws s3 cp $BACKUP_DIR/$DATABASE-$TIMESTAMP.sql s3://your-bucket-name/$DATABASE-$TIMESTAMP.sql

if [ $? -eq 0 ]; then
    echo "Backup uploaded to S3 successfully."
else
    echo "Failed to upload backup to S3."
fi
