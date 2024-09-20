#!/bin/bash

for i in $(pactl list sink-inputs | grep "application.process.binary" | grep -n $1| cut -c1);
do
# echo i=$i
check=$(pactl list sink-inputs | grep "Corked" | sed -n $i"p" | grep no)
# echo check=$check
if [ "$check" != "" ];
then
app=$i
break
fi
done
# echo app=$app
# app=$(pactl list sink-inputs | grep "application.process.binary" | grep -n $1 |cut -d ':' -f1)
app_info=$(pactl list short sink-inputs | grep -v combine | sed -n $app"p")
app_sink_idx=$(echo $app_info  | awk '{ print $2}')
app_idx=$(echo $app_info  | awk '{ print $1}')

# sink_idx=$(pactl list short sinks | awk '{ print $1}')
hd=$(pactl list short sinks | grep -i hdmi | cut -f1)
usb=$(pactl list short sinks | grep -i usb | cut -f1)
builtin=$(pactl list short sinks | grep -i "1f.3.analog" | cut -f1)


# if [ $app_sink_idx == $hd ]
# then
# new_idx=$usb
# else
# new_idx=$hd
# fi


if [ "$2" == "hd" ];
then
# echo "converting to HD"
new_idx=$hd
pactl set-sink-input-volume $app_idx -12%
elif [ "$2" == "usb" ];
then
# echo "converting to usb"
new_idx=$usb
elif [ "$2" == "builtin" ];
then
# echo "converting to Extra"
new_idx=$builtin
fi



if [ "$app_sink_idx" == "$hd" ];
then
pactl set-sink-input-volume $app_idx +12%
fi

# echo $app_idx $new_idx
# echo $app_info

pactl move-sink-input $app_idx $new_idx
