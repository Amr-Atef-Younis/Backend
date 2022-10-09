#!/bin/bash
file=""
while :
do
file=$(pactl list short sources | grep ModifiedMic)
if [[ "$file" != "" ]]
then
 
while sleep 0.1; do pacmd set-source-volume "ModifiedMic" 65536; done

fi
done
