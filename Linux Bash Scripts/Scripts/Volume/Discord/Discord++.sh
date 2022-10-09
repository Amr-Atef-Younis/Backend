#!/bin/bash

process_id=$(pidof spotify)

#echo $process_id

temp=$(mktemp)

pacmd list-sink-inputs > $temp

#gedit $temp

inputs_found=0;
index="";
number=0;
while read line; do
	if [ $inputs_found -eq 0 ]; then
	inputs="$line"
	if [ "${inputs:0:5}" == "index" ]; then
	index=${line:7:7}
	fi
	if [ "$inputs" == 'application.name = "WEBRTC VoiceEngine"' ]; then
	inputs_found=1
	break;
	else
	continue;
	fi
      fi
done < $temp


pactl set-sink-input-volume $index +20% ;
