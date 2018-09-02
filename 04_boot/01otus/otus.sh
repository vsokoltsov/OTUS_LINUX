#!/bin/bash

exec 0<>/dev/console 1<>/dev/console 2<>/dev/console
cat <<'msgend'
OTUS TEST TEXT
msgend
sleep 1
echo " continuing...."
