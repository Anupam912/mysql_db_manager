import mysql.connector

# Connect to the MySQL database
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="your_database"
)

cursor = db.cursor()

# Get the columns used frequently in WHERE, JOIN, and ORDER BY clauses
# This is just an example. You can adapt it to your needs.

query = """
SELECT column_name, COUNT(*)
FROM information_schema.statistics
WHERE table_schema = 'your_database'
GROUP BY column_name
ORDER BY COUNT(*) DESC
LIMIT 10;
"""

cursor.execute(query)

print("Columns that may benefit from indexing:")
for column in cursor.fetchall():
    print(f"Column: {column[0]} - Count: {column[1]}")

# Suggest creating indexes on those columns
print("\nSuggested index creation queries:")
for column in cursor.fetchall():
    print(f"CREATE INDEX idx_{column[0]} ON your_table ({column[0]});")

db.close()
