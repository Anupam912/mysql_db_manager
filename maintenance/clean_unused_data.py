import mysql.connector

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="your_database"
)

cursor = db.cursor()

# Identify and drop unused tables
cleanup_query = """
SELECT table_name
FROM information_schema.tables
WHERE table_rows = 0 AND table_schema = 'your_database';
"""

cursor.execute(cleanup_query)
unused_tables = cursor.fetchall()

for table in unused_tables:
    drop_query = f"DROP TABLE {table[0]};"
    cursor.execute(drop_query)
    print(f"Table {table[0]} dropped.")

db.close()
