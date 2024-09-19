import mysql.connector

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password"
)

cursor = db.cursor()

# Adjust the innodb_buffer_pool_size based on current load
cursor.execute("SHOW STATUS LIKE 'Innodb_buffer_pool_pages_free';")
free_pages = cursor.fetchone()

if int(free_pages[1]) < 1000:
    cursor.execute("SET GLOBAL innodb_buffer_pool_size = innodb_buffer_pool_size + 100M;")

db.close()