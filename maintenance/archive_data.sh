#!/bin/bash
# Archive old data from the main table to an archive table

MYSQL_USER="root"
MYSQL_PASSWORD="password"
DATABASE="your_database"

# Define the query to archive data older than 1 year
ARCHIVE_QUERY="INSERT INTO archive_table SELECT * FROM main_table WHERE created_at < NOW() - INTERVAL 1 YEAR;
DELETE FROM main_table WHERE created_at < NOW() - INTERVAL 1 YEAR;"

mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "$ARCHIVE_QUERY" $DATABASE

if [ $? -eq 0 ]; then
    echo "Data archiving completed successfully."
else
    echo "Data archiving failed."
fi
