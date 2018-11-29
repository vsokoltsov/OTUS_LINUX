#!/bin/bash

declare -A IP_ADRESSES
declare -A STATUSES
RESPONSES=()
TIMING=()
ERROR_LINES=0
CURRENT_LINE=0

regex="(^[A-Za-z+.]+[A-Za-z]+\:[0-9]+) ([0-9.]{2,}) - - (\[[A-Za-z0-9\/\:[:space:]\+]+\]) \"([A-Z]+) ([A-Za-z0-9\%\/\_\.\-]+) ([A-Z\/\.0-9]+)\" ([0-9]{3}) ([0-9]+) (\"\-\")? \"([A-Za-z\/0-9\.[:space:]\)\(\;\+\:]+)\""

update_ip_counts() {
  if [[ -z ${IP_ADRESSES[$1]} ]]
  then
    IP_ADRESSES[$1]+=1
  else
    IP_ADRESSES[$1]=1
  fi
}

update_statuses_counts() {
  if [[ -z ${STATUSES[$1]} ]]
  then
    STATUSES[$1]+=1
  else
    STATUSES[$1]=1
  fi
}

display_ip_statistics() {
  echo "IP ADRESSES AND NUMBERS OF APPEARENCES "
  for i in "${!IP_ADRESSES[@]}"; do
    echo $i -- ${IP_ADRESSES[$i]}
  done
}

display_statuses_statistics() {
  echo "STATUSES AND NUMBER OF APPEARENCES "
  for i in "${!STATUSES[@]}"; do
    echo $i -- ${STATUSES[$i]}
  done
}

display_timing_statistics() {
  echo "MAX TIMING VALUE:"
  echo "${TIMING[*]}" | sort -n | tail -1
  echo "MIN TIMING VALUE:"
  echo "${TIMING[*]}" | sort -n | head -1
}


parse_string() {
  if [[ $1 =~ $regex ]]
  then
    host="${BASH_REMATCH[1]}"
    ip="${BASH_REMATCH[2]}"
    date="${BASH_REMATCH[3]}"
    http_action="${BASH_REMATCH[4]}"
    url="${BASH_REMATCH[5]}"
    http_protocol="${BASH_REMATCH[6]}"
    http_status="${BASH_REMATCH[7]}"
    http_response_time="${BASH_REMATCH[8]}"
    user_agent="${BASH_REMATCH[10]}"
    declare -A response=( ["host"]=$host ["ip"]=$ip ["date"]=$date
      ["http_action"]=$http_action ["url"]=$url ["protocol"]=$http_protocol
      ["http_status"]=$http_status ["response_time"]=$http_response_time
      ["user_agent"]=$user_agent
    )
    RESPONSES+=${response}
    TIMING+=$http_response_time

    update_ip_counts $ip
    update_statuses_counts $http_status
  else
    ERROR_LINES=$[$ERROR_LINES+1]
  fi
}
NUMBER_OF_LINES=$(cat $1 | wc -l)
echo "NUMBER OF FILES $NUMBER_OF_LINES"

while IFS='' read -r line || [[ -n $line ]]; do
    echo "LINE $CURRENT_LINE of $NUMBER_OF_LINES"
    parse_string $line
    CURRENT_LINE=$[$CURRENT_LINE+1]
done < "$1"

display_ip_statistics
display_statuses_statistics
display_timing_statistics
