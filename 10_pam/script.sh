#!/bin/bash

CURRENT_WEEK_DAY=$(date +%u)
GROUP=$(id -g "$PAM_USER")
DATES=('2018-01-01' '2018-02-23' '2018-03-08')

containDates() {
  currentDate=$(date +%Y-%m-%d)
  dates=$1
  for i in "${dates[@]}" ; do
    echo $currentDate, $i
    if [ "$currentDate" == "$i" ]; then
       return 1
    fi
  done
  return 0
}

if ( [ "$CURRENT_WEEK_DAY" == 6 ] || [ "$CURRENT_WEEK_DAY" == 7 ] ) && containDates $DATES
then
  if [ $GROUP == 'admin' ]
  then
    echo "success logged in" >> /bin/script.log
    exit 0
  else
    echo "User's $PAM_USER primary group is not 'admin'" >> /bin/script.log
    exit 1
  fi
fi
