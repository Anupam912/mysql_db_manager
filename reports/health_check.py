import mysql.connector
import smtplib
from email.mime.text import MIMEText

def send_email(report):
    msg = MIMEText(report)
    msg['Subject'] = 'MySQL Health Check Report'
    msg['From'] = 'you@example.com'
    msg['To'] = 'admin@example.com'
    
    # Send email
    with smtplib.SMTP('smtp.example.com') as server:
        server.login("your_email@example.com", "your_password")
        server.send_message(msg)

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="your_database"
)

cursor = db.cursor()

# Collect database statistics
cursor.execute("SHOW STATUS LIKE 'Uptime';")
uptime = cursor.fetchone()

cursor.execute("SHOW STATUS LIKE 'Threads_connected';")
threads_connected = cursor.fetchone()

cursor.execute("SHOW STATUS LIKE 'Questions';")
total_queries = cursor.fetchone()

# Create the report
report = f"""
MySQL Health Check Report:
Uptime: {uptime[1]} seconds
Threads Connected: {threads_connected[1]}
Total Queries: {total_queries[1]}
"""

# Send the report
send_email(report)

db.close()
