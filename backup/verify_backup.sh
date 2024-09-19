#!/bin/bash
# Verify MySQL backup by restoring it to a test server

BACKUP_FILE="/path/to/backup.sql"
TEST_DB="test_restore"
MYSQL_USER="root"
MYSQL_PASSWORD="password"

# Drop the test database if it exists
mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "DROP DATABASE IF EXISTS $TEST_DB;"

# Create a new test database
mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "CREATE DATABASE $TEST_DB;"

# Restore the backup to the test database
mysql -u $MYSQL_USER -p$MYSQL_PASSWORD $TEST_DB < $BACKUP_FILE

if [ $? -eq 0 ]; then
    echo "Backup verification successful!"
else
    echo "Backup verification failed!"
fi
