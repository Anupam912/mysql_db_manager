import os
import subprocess

# Check disk space usage
def check_disk_usage(threshold):
    disk_usage = subprocess.check_output("df / --output=pcent", shell=True).decode().splitlines()[1]
    usage_percentage = int(disk_usage.replace('%', '').strip())

    if usage_percentage > threshold:
        return True
    return False

# Scale the database
def scale_database():
    print("Scaling the database...")
    # Add your scaling logic here (e.g., adding replicas)
    # Example: Increase innodb_buffer_pool_size or add a new replica

if check_disk_usage(80):
    scale_database()
else:
    print("Disk usage is under control.")
