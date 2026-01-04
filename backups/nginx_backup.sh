#!/bin/bash
DATE=$(date +%F)
BACKUP_FILE="/backups/nginx_backup_$DATE.tar.gz"

sudo tar -czf "$BACKUP_FILE" /etc/nginx /usr/share/nginx/html
sudo tar -tzf "$BACKUP_FILE" > "/backups/nginx_verify_$DATE.log"
