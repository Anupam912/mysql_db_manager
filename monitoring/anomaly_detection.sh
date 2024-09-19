import mysql.connector
import smtplib

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="your_database"
)

cursor = db.cursor()

# Monitor CPU usage, memory, and query times
cursor.execute("SHOW STATUS LIKE 'Threads_running';")
threads_running = cursor.fetchone()

cursor.execute("SHOW STATUS LIKE 'Slow_queries';")
slow_queries = cursor.fetchone()

if int(slow_queries[1]) > 100:
    print("Anomaly detected: Too many slow queries!")

db.close()
