#!/bin/bash


# hd=$(pactl list short sinks | grep -i hdmi | cut -c1)
# usb=$(pactl list short sinks | grep -i usb | cut -c1)
# builtin=$(pactl list short sinks | grep -i "1f.3.analog" | cut -c1)

# old_device_id=$(pacmd list-sinks | grep -i "state:" | grep -n "RUNNING"| cut -c1)
# echo $old_device_id
old_device_name=$(pactl info | grep "Default Sink" | cut -d':' -f2 | cut -c2-)
new_device_name=$(pacmd list-sinks | grep -i "name:" | grep -i "$1" | cut -d'<' -f2 | cut -d'>' -f1)

new_device_id=$(pacmd list-sinks | grep -i "name:" | grep -n "$1"| cut -c1)

# if [ -z "$(echo "$old_device_name" | grep "$1")" ];
# then
# check=False
# else
# check=True
# fi

if [ -z "$new_device_id" ];
then
exit
fi
echo "old=$old_device_name"
echo "new=$new_device_name"

for app_idx in $(pactl list sink-inputs | grep "Sink Input" | cut -d'#' -f2);
do
if [ "$old_device_name" != "$new_device_name" ];
then
if [ "$1" == "hdmi" ];
then
pactl set-sink-input-volume $app_idx -12%
else
pactl set-sink-input-volume $app_idx +12%
fi
fi

# echo "app_idx=$app_idx"
# echo "new_device_id=$new_device_id"

pactl move-sink-input $app_idx $new_device_name

done

pactl set-default-sink $new_device_name
