#!/bin/bash

COUNTS=5
LOGFILE="logfile.txt"
IP_FIELD=1
PATH_FIELD=7
STATUS_CODE_PATTERN=' [1-5][0-9]{2} '
USER_AGENT_FIELD=6

echo -e "\nTop ${COUNTS} IP addresses with the most requests:"
awk -v ip_field=$IP_FIELD '{print $ip_field}' $LOGFILE | sort | uniq -c | sort -nr | awk '{print $2 " - " $1 " requests"}' | head -n ${COUNTS}

echo -e "\nTop ${COUNTS} most requested paths:"
awk -v path_field=$PATH_FIELD '{print $path_field}' $LOGFILE | sort | uniq -c | sort -nr | awk '{print $2 " - " $1 " requests"}' | head -n ${COUNTS}

echo -e "\nTop ${COUNTS} response status codes:"
grep -oE "$STATUS_CODE_PATTERN" $LOGFILE | sort | uniq -c | sort -rn | awk '{print $2 " - " $1 " requests"}' | head -n ${COUNTS}

echo -e "\nTop ${COUNTS} user agents:"
awk -F'"' -v user_agent_field=$USER_AGENT_FIELD '{print $user_agent_field}' $LOGFILE | sort | uniq -c | sort -nr | awk '{for(i=2;i<=NF;i++) printf "%s ", $i; print "-",$1,"requests"}' | head -n ${COUNTS}
