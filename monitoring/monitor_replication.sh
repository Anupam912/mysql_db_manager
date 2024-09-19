#!/bin/bash
# Monitor MySQL Replication Status

MYSQL_USER="root"
MYSQL_PASSWORD="password"

REPLICATION_STATUS=$(mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW SLAVE STATUS\G" | grep "Seconds_Behind_Master:" | awk '{print $2}')

if [ "$REPLICATION_STATUS" == "NULL" ]; then
    echo "Replication is not running!" | mail -s "MySQL Replication Alert" admin@example.com
elif [ "$REPLICATION_STATUS" -gt 100 ]; then
    echo "Replication is delayed by $REPLICATION_STATUS seconds!" | mail -s "MySQL Replication Alert" admin@example.com
else
    echo "Replication is working fine."
fi
