# MySQL Database Management and Optimization

## Overview

This project is designed to automate and optimize the management of MySQL databases. It provides various scripts for routine tasks such as backups, performance monitoring, query optimization, dynamic tuning, and much more. The project is divided into different modules that each focus on a specific area of database management.

## Key Features

- **Automated Backups**: Local and cloud-based backups (e.g., AWS S3).
- **Index and Query Optimization**: Automated maintenance and optimization of database indexes and slow queries.
- **Performance Tuning**: Dynamic adjustment of MySQL configurations based on real-time metrics.
- **Monitoring and Alerts**: CPU, memory, query response time, replication status, and disk space monitoring with alerting capabilities.
- **Data Archiving**: Automated archiving of old or unused data for better performance.
- **User Access Auditing**: Log and monitor database user access and critical SQL operations.
- **Anomaly Detection**: Detects and alerts for performance spikes and slow queries.

## Setup and Installation

**1. Clone the Repository**

    ```bash
    git clone https://github.com/Anupam912/mysql_db_manager.git
    cd mysql_db_manager
    ```

**2. Install Prerequisites**

- MySQL: Make sure MySQL is installed and running.
- Python 3.x: Install Python if it's not already installed.
- AWS CLI (optional for cloud backups): If you're uploading backups to AWS S3, install and configure AWS CLI.
- Cron: Use cron for scheduling the scripts.

## Configuration

###Temporary Changes (using SET GLOBAL in MySQL)**

Log into MySQL using the command line

```bash
mysql -u root -p
```

**1. Enable Query Cache**

```sql
SET GLOBAL query_cache_size = 64M;
SET GLOBAL query_cache_type = 1;
```

**2. Max Connections**

```sql
SET GLOBAL max_connections = 500;
```

**3. InnoDB Buffer Pool Size**

```sql
SET GLOBAL innodb_buffer_pool_size = 1G;
```

###Permanent Changes (Edit my.cnf)
**1. Locate the MySQL configuration file:**
    - On most systems, it's located at /etc/mysql/mysql.conf.d/mysqld.cnf.
**2. Edit the file:**

    ```bash
    sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
    ```
**3. Add the following lines under the [mysqld] section:**

    ```ini
    [mysqld]
    query_cache_size = 64M
    query_cache_type = 1
    max_connections = 500
    innodb_buffer_pool_size = 1G
    ```
**4. Restart MySQL to apply the changes:**

    ```bash
    sudo systemctl restart mysql
    ```

## Usage Instructions

1. Add cron jobs to your crontab:

    ```bash 
    crontab -e
    ```

2. Add the following cron jobs:

    ```bash
    0 2 * * * /path/to/mysql_db_manager/backup/backup_to_cloud.sh
    0 0 * * 0 /usr/bin/python3 /path/to/mysql_db_manager/reports/health_check.py
    0 0 1 * * /usr/bin/python3 /path/to/mysql_db_manager/maintenance/index_maintenance.py
    */5 * * * * /path/to/mysql_db_manager/monitoring/query_response_monitor.sh
    0 3 * * * /path/to/mysql_db_manager/monitoring/analyze_slow_queries.sh
    ```

4. Enable and Monitor Slow Queries

    1. Edit your MySQL configuration file (my.cnf or mysqld.cnf):

        ```bash
        sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
        ```

    2. Add the following lines under the [mysqld] section:

        ```ini
        [mysqld]
        slow_query_log = 1
        slow_query_log_file = /var/log/mysql/slow-queries.log
        long_query_time = 2   
        ```
    3. Restart MySQL to apply the changes:

        ```bash
        sudo systemctl restart mysql
        ```
    4. Making Scripts Executable

        ```bash
        chmod +x /path/to/mysql_db_manager/backup/backup_to_cloud.sh
        chmod +x /path/to/mysql_db_manager/monitoring/db_monitor.sh
        chmod +x /path/to/mysql_db_manager/maintenance/index_maintenance.py
        chmod +x /path/to/mysql_db_manager/monitoring/query_response_monitor.sh
        ```

### Additional Setup (Optional)

AWS S3 Setup for Backups

```bash
sudo apt install awscli
aws configure
```
