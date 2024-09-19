#!/bin/bash
# Monitor MySQL query cache usage

MYSQL_USER="root"
MYSQL_PASSWORD="password"
MYSQL_DATABASE="your_database"

# Query to get cache status
CACHE_STATUS=$(mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW STATUS LIKE 'Qcache%';" $MYSQL_DATABASE)

# Extract relevant cache metrics
QCACHE_HITS=$(echo "$CACHE_STATUS" | grep "Qcache_hits" | awk '{print $2}')
QCACHE_INSERTS=$(echo "$CACHE_STATUS" | grep "Qcache_inserts" | awk '{print $2}')
QCACHE_PRUNES=$(echo "$CACHE_STATUS" | grep "Qcache_lowmem_prunes" | awk '{print $2}')

# Output cache stats
echo "Query Cache Hits: $QCACHE_HITS"
echo "Query Cache Inserts: $QCACHE_INSERTS"
echo "Query Cache Prunes (low memory): $QCACHE_PRUNES"

# Set threshold for low memory prunes
CACHE_PRUNE_THRESHOLD=100

# Send alert if too many low memory prunes
if [ "$QCACHE_PRUNES" -gt "$CACHE_PRUNE_THRESHOLD" ]; then
    echo "Warning: Query cache pruned frequently due to low memory!" | mail -s "Query Cache Alert" admin@example.com
fi
