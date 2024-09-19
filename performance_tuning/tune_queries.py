import mysql.connector

# Connect to the MySQL database
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="your_database"
)

cursor = db.cursor()

# Query to get slow queries from the slow query log
slow_queries = """
SELECT sql_text
FROM mysql.slow_log
WHERE query_time > 1;  # Fetch queries that took more than 1 second
"""

cursor.execute(slow_queries)

for query in cursor.fetchall():
    try:
        # Run EXPLAIN to analyze the query
        explain_query = f"EXPLAIN {query[0]}"
        cursor.execute(explain_query)
        result = cursor.fetchall()

        # Print the query and its EXPLAIN output
        print(f"Query: {query[0]}")
        for row in result:
            print(row)

    except mysql.connector.Error as err:
        print(f"Error analyzing query: {err}")

db.close()
