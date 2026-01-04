# Testing-Linux-and-Servers-hero
**Task 1: System Monitoring Setup**
Objective

To monitor CPU, memory, disk usage, and running processes, and log system metrics for performance analysis and capacity planning.

1.1 Install Monitoring Tools
Install htop

sudo apt update
sudo apt install htop -y


Verify:

htop


1.2 Disk Usage Monitoring

Check overall disk usage:

df -h


Check directory-level usage:

du -sh /var/*

1.3 Identify Resource-Intensive Processes

Using htop:

Sort by CPU: F6 → CPU

Sort by Memory: F6 → MEM%

Using CLI:

ps aux --sort=-%cpu | head
ps aux --sort=-%mem | head

1.4 System Metrics Logging

Create a monitoring log directory:

sudo mkdir -p /var/log/system-monitoring


Create a monitoring script:

sudo nano /usr/local/bin/system_monitor.sh

#!/bin/bash
echo "===== $(date) =====" >> /var/log/system-monitoring/metrics.log
df -h >> /var/log/system-monitoring/metrics.log
free -m >> /var/log/system-monitoring/metrics.log
ps aux --sort=-%cpu | head >> /var/log/system-monitoring/metrics.log
echo "" >> /var/log/system-monitoring/metrics.log


Make executable:

sudo chmod +x /usr/local/bin/system_monitor.sh


Schedule logging every hour:

crontab -e

0 * * * * /usr/local/bin/system_monitor.sh

**Task 2: User Management and Access Control**
Objective

Create secure user accounts with isolated directories and enforce password policies.

2.1 Create Users
sudo useradd Sarah
sudo useradd mike


Set passwords:

sudo passwd Sarah
sudo passwd mike

2.2 Create Isolated Workspaces
sudo mkdir -p /home/Sarah/workspace
sudo mkdir -p /home/mike/workspace


Assign ownership:

sudo chown -R Sarah:Sarah /home/Sarah
sudo chown -R mike:mike /home/mike


Set permissions:

sudo chmod 700 /home/Sarah/workspace
sudo chmod 700 /home/mike/workspace


Verify:

ls -ld /home/Sarah/workspace
ls -ld /home/mike/workspace

2.3 Password Policy Enforcement

Edit login definitions:

sudo nano /etc/login.defs


Ensure:

PASS_MAX_DAYS   30
PASS_MIN_DAYS   1
PASS_WARN_AGE   7


Set password expiration:

sudo chage -M 30 Sarah
sudo chage -M 30 mike


Verify:

chage -l Sarah

**Task 3: Backup Configuration for Web Servers**
Objective

Automate weekly backups of Apache and Nginx configurations and document roots.

3.1 Create Backup Directory
sudo mkdir /backups
sudo chmod 755 /backups

3.2 Backup Script for Apache (Sarah)
sudo nano /usr/local/bin/apache_backup.sh

#!/bin/bash
DATE=$(date +%F)
BACKUP_FILE="/backups/apache_backup_$DATE.tar.gz"

tar -czf $BACKUP_FILE /etc/httpd /var/www/html
tar -tzf $BACKUP_FILE > /backups/apache_verify_$DATE.log

sudo chmod +x /usr/local/bin/apache_backup.sh

3.3 Backup Script for Nginx (Mike)
sudo nano /usr/local/bin/nginx_backup.sh

#!/bin/bash
DATE=$(date +%F)
BACKUP_FILE="/backups/nginx_backup_$DATE.tar.gz"

tar -czf $BACKUP_FILE /etc/nginx /usr/share/nginx/html
tar -tzf $BACKUP_FILE > /backups/nginx_verify_$DATE.log

sudo chmod +x /usr/local/bin/nginx_backup.sh

3.4 Cron Job Scheduling (Every Tuesday at 12:00 AM)

Edit root cron:

sudo crontab -e

0 0 * * 2 /usr/local/bin/apache_backup.sh
0 0 * * 2 /usr/local/bin/nginx_backup.sh


📸 Screenshot: Cron job entries.

3.5 Backup Verification

List backups:

ls -lh /backups


Check integrity logs:

cat /backups/apache_verify_YYYY-MM-DD.log
cat /backups/nginx_verify_YYYY-MM-DD.log


📸 Screenshot: Backup files and verification logs.

Challenges Encountered
Challenge	Resolution
Permission issues on backup directory	Fixed using correct ownership and chmod
Cron not executing initially	Verified with crontab -l and script permissions
Disk usage spikes	Identified large directories using du
Final Outcome

✔ System monitoring configured and logged
✔ Secure user access with isolated workspaces
✔ Password expiration and policy enforced
✔ Automated weekly backups with verification
✔ Logs and documentation maintained

Deliverables Checklist

✅ Monitoring logs
✅ User creation and permission screenshots
✅ Cron job configuration
✅ Backup .tar.gz files
✅ Backup verification logs
