import mysql.connector

# Connect to the MySQL database
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="your_database"
)

cursor = db.cursor()

# Query to find unused indexes
unused_indexes_query = """
SELECT
    t.table_name,
    i.index_name,
    i.non_unique
FROM
    information_schema.tables t
JOIN information_schema.statistics i
    ON t.table_schema = i.table_schema
    AND t.table_name = i.table_name
LEFT JOIN sys.schema_unused_indexes ui
    ON ui.table_name = t.table_name
    AND ui.index_name = i.index_name
WHERE
    ui.index_name IS NOT NULL;
"""

cursor.execute(unused_indexes_query)
unused_indexes = cursor.fetchall()

for index in unused_indexes:
    table_name, index_name = index[0], index[1]
    drop_index_query = f"ALTER TABLE {table_name} DROP INDEX {index_name};"
    cursor.execute(drop_index_query)
    print(f"Dropped unused index {index_name} from table {table_name}")

db.close()
