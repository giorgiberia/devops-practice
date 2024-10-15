#!/bin/bash

cpu_usage() {
  echo "= CPU Usage ="
  top -bn1 | grep "Cpu(s)" | \
    sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
    awk '{usage=100-$1} END {print "CPU Usage: " usage "%"}'
}

memory_usage() {
  echo "= Memory Usage ="
  free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
}

disk_usage() {
  echo "= Disk Usage ="
  df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
}

top_processes_cpu() {
  echo "= Top 5 Processes by CPU Usage ="
  ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

top_processes_memory() {
  echo "= Top 5 Processes by Memory Usage ="
  ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}

os_info() {
  echo "= OS Information ="
  cat /etc/os-release | grep -e "^NAME" -e "^VERSION"
}

uptime_info() {
  echo "= Uptime and Load Average ="
  uptime
}

logged_in_users() {
  echo "= Logged in Users ="
  who
}

failed_login_attempts() {
  echo "= Failed Login Attempts ="
  grep "Failed password" /var/log/auth.log | wc -l
}


main() {
  cpu_usage
  memory_usage
  disk_usage
  top_processes_cpu
  top_processes_memory

  echo
  os_info
  uptime_info
  logged_in_users
  failed_login_attempts
}

main
