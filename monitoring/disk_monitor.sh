#!/bin/bash
# Monitor disk usage for MySQL data directory

DATA_DIR="/var/lib/mysql"
THRESHOLD=80

DISK_USAGE=$(df $DATA_DIR | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
    echo "Warning: Disk usage is at $DISK_USAGE% for MySQL data directory!" | mail -s "Disk Usage Alert" admin@example.com
else
    echo "Disk usage is under control."
fi
