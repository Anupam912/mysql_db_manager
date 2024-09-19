import mysql.connector

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="your_database"
)

cursor = db.cursor()

# Get slow queries from the slow query log
slow_queries = """
SELECT sql_text FROM mysql.slow_log WHERE query_time > 1;
"""

cursor.execute(slow_queries)

for query in cursor.fetchall():
    print(f"Analyzing Query: {query[0]}")
    explain_query = f"EXPLAIN {query[0]}"
    cursor.execute(explain_query)
    result = cursor.fetchall()
    
    # Print and analyze the EXPLAIN output (suggest indexes, optimizations)
    for row in result:
        print(row)

db.close()
