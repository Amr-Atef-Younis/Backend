#!/bin/bash

check=""

while true;
do

sleep 1
check=$(pgrep -u amr restart.sh)

if [ "$check" = "" ];
then

echo "NO"
/mnt/F/Scripts/Spotify/restart.sh &

fi

done
