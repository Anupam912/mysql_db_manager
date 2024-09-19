#!/bin/bash
# Log user activity in MySQL

LOG_FILE="/var/log/mysql/mysql_access.log"
MYSQL_USER="root"
MYSQL_PASSWORD="password"

# Monitor all login events and queries run by users
mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "SELECT * FROM mysql.general_log;" >> $LOG_FILE
