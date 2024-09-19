#!/bin/bash
# Monitor MySQL CPU, Memory, and Disk usage

# Get the MySQL process ID
MYSQL_PID=$(pgrep mysqld)

if [ -z "$MYSQL_PID" ]; then
    echo "MySQL process not found!"
    exit 1
fi

# Get CPU and memory usage for MySQL
CPU_USAGE=$(ps -p $MYSQL_PID -o %cpu | tail -n 1)
MEM_USAGE=$(ps -p $MYSQL_PID -o %mem | tail -n 1)

# Output CPU and memory usage
echo "MySQL CPU Usage: $CPU_USAGE%"
echo "MySQL Memory Usage: $MEM_USAGE%"

# Set thresholds for high usage alerts
CPU_THRESHOLD=80
MEM_THRESHOLD=80

# Send alert if CPU usage is above threshold
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    echo "Warning: High CPU usage ($CPU_USAGE%) for MySQL!" | mail -s "High CPU Usage Alert" admin@example.com
fi

# Send alert if memory usage is above threshold
if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
    echo "Warning: High memory usage ($MEM_USAGE%) for MySQL!" | mail -s "High Memory Usage Alert" admin@example.com
fi

# Monitor disk space usage (Assuming MySQL data is in /var/lib/mysql)
DISK_USAGE=$(df -h /var/lib/mysql | awk 'NR==2 {print $5}' | sed 's/%//')
DISK_THRESHOLD=80

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "Warning: High disk usage ($DISK_USAGE%) for MySQL data!" | mail -s "High Disk Usage Alert" admin@example.com
fi
