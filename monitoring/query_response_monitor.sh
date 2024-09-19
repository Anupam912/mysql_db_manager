#!/bin/bash
# Monitor MySQL query response times

MYSQL_USER="root"
MYSQL_PASSWORD="password"

# Get slow queries from MySQL
SLOW_QUERIES=$(mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW GLOBAL STATUS LIKE 'Slow_queries';" | awk '{print $2}')

if [ "$SLOW_QUERIES" -gt 10 ]; then
    echo "High number of slow queries detected!" | mail -s "Slow Query Alert" admin@example.com
fi
