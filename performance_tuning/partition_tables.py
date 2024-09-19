import mysql.connector

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="your_database"
)

cursor = db.cursor()

# Example of partitioning a table based on year (Range partitioning)
partition_query = """
ALTER TABLE your_table
PARTITION BY RANGE (YEAR(date_column)) (
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023)
);
"""

try:
    cursor.execute(partition_query)
    print("Table partitioned successfully.")
except mysql.connector.Error as err:
    print(f"Error: {err}")

db.close()
