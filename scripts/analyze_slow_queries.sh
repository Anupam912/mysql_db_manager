#!/bin/bash
# Analyze MySQL slow query logs

SLOW_LOG="/var/log/mysql/slow-queries.log"
SLOW_THRESHOLD=2

# Check if the slow query log file exists
if [ ! -f "$SLOW_LOG" ]; then
    echo "Slow query log not found!"
    exit 1
fi

# Extract slow queries
SLOW_QUERIES=$(mysqldumpslow $SLOW_LOG)

if [ -z "$SLOW_QUERIES" ]; then
    echo "No slow queries found."
    exit 0
fi

# Output slow query analysis
echo "Slow queries:"
echo "$SLOW_QUERIES"

# Send email alert if slow queries exist
if [ ! -z "$SLOW_QUERIES" ]; then
    echo "Slow queries found: $SLOW_QUERIES" | mail -s "Slow Query Alert" admin@example.com
fi
