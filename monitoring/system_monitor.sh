#!/bin/bash
DATE=$(date +%F)
LOG_DIR="/var/log/system-monitor"
LOG_FILE="$LOG_DIR/metrics.log"
mkdir -p "$LOG_DIR"
echo "====================================" >> "$LOG_FILE"
echo "System Metrics - $DATE" >> "$LOG_FILE"
echo "====================================" >> "$LOG_FILE"

echo "====================================" >> "$LOG_FILE"
echo "System Monitoring Log - $DATE" >> "$LOG_FILE"
echo "====================================" >> "$LOG_FILE"


echo "" >> "$LOG_FILE"
echo "Disk Usage (df -h)" >> "$LOG_FILE"
df -h >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "Directory size (du -sh)" >> "$LOG_FILE"
du -sh /home >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "Top CPU consuming processes" >> "$LOG_FILE"
ps aux --sort=-%cpu | head -3 >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "Memory consuming prcesses" >> "$LOG_FILE"
ps aux --sort=-%mem | head -3 >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "Log completed" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
