import mysql.connector

# Connect to the MySQL server
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password"
)

cursor = db.cursor()

# Tune the innodb_buffer_pool_size (for example, set it to 1GB)
cursor.execute("SET GLOBAL innodb_buffer_pool_size = 1024 * 1024 * 1024;")

# Enable and set the query cache size
cursor.execute("SET GLOBAL query_cache_size = 64 * 1024 * 1024;")
cursor.execute("SET GLOBAL query_cache_type = 1;")

# Set max connections
cursor.execute("SET GLOBAL max_connections = 500;")

print("MySQL configurations updated successfully.")

db.close()
