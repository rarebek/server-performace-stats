#!/bin/bash

echo "==================== Server Performance Stats ===================="

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
echo "Total CPU Usage: $CPU_USAGE"

MEMORY_TOTAL=$(free -m | awk '/^Mem:/ {print $2}')
MEMORY_USED=$(free -m | awk '/^Mem:/ {print $3}')
MEMORY_FREE=$(free -m | awk '/^Mem:/ {print $4}')
MEMORY_USAGE_PERCENT=$(awk "BEGIN {print ($MEMORY_USED/$MEMORY_TOTAL)*100}")
echo "Total Memory Usage: $MEMORY_USED MB / $MEMORY_TOTAL MB ($MEMORY_USAGE_PERCENT%)"

DISK_TOTAL=$(df -h --total | grep 'total' | awk '{print $2}')
DISK_USED=$(df -h --total | grep 'total' | awk '{print $3}')
DISK_FREE=$(df -h --total | grep 'total' | awk '{print $4}')
DISK_USAGE_PERCENT=$(df -h --total | grep 'total' | awk '{print $5}')
echo "Total Disk Usage: $DISK_USED / $DISK_TOTAL ($DISK_USAGE_PERCENT)"

echo ""
echo "==================== Top 5 Processes ===================="

echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo ""
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

echo ""
echo "==================== Additional Stats ===================="

OS_VERSION=$(lsb_release -d | awk -F"\t" '{print $2}')
echo "OS Version: $OS_VERSION"

UPTIME=$(uptime -p)
echo "Uptime: $UPTIME"

LOAD_AVERAGE=$(uptime | awk -F'load average:' '{ print $2 }')
echo "Load Average: $LOAD_AVERAGE"

LOGGED_IN_USERS=$(who | wc -l)
echo "Logged-in Users: $LOGGED_IN_USERS"

echo "==================== End of Report ===================="
