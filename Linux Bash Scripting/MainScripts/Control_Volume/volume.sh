#!/bin/bash

app=$(pactl list sink-inputs | grep "application.process.binary" | grep -ni $1 |cut -d ':' -f1)
app_info=$(pactl list short sink-inputs | grep -vE "combine|module-echo-cancel" | sed -n $app"p")
app_idx=$(echo $app_info  | awk '{ print $1}')

if [[ "$1" == "caprine" || "$1" == "rambox" ]];
then
out=$(pactl list sink-inputs | grep -i volume | grep -i mono | perl -n -e '/(\d+)%/ && print $1')
else
out=$(pactl list sink-inputs | grep -i volume | grep -v "mono" | sed -n $app"p" | perl -n -e '/(\d+)%/ && print $1')
fi

echo $app_idx
# echo "out=$out"

if [ $out -ge 99 -a "$2" = "+" ]; then
	pactl set-sink-input-volume $app_idx 100%
	timeout 0.6 gxmessage -geometry 360x132-800-420 -ontop -borderless -fg "yellow" -fn "serif italic 40" "Max Volume"
else
	pactl set-sink-input-volume $app_idx "$2"2%
fi
