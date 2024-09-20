#!/bin/bash

source "${HELPERS_DIRECTORY}Functions"

# source=$(pacmd stat | grep "Default source name" | cut -d ':' -f2 | cut -c2-)
# source="$(pactl info | grep -A2 'Default Source')"
source=$(pactl info | grep "Default Source" | cut -d':' -f2)

in="$1"
if [ -z "$in" ];
then
in=$(zenity --entry --entry-text="95" --text="Enter % MicVolume")
fi


# echo "in=$in"
if [ "$in" = "" ];
then
pkill MicVolume.sh
exit
else
num=$(( $in*40000 / 61 ))
echo "num=$num"
while sleep 0.1;
do
pactl set-source-volume$source $num;
done
fi



