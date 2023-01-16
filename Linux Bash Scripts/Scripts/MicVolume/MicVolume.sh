#!/bin/bash
#include <math.h>



ch=$(pacmd stat | grep "Default source name")

source=${ch: 21}


if [ "$1" = "" ];
then

in=$(zenity --entry --entry-text="65" --text="Enter % MicVolume")

if [ "$in" = "" ];
then

pkill MicVolume.sh
exit

fi

else

in=95

fi

num=$(( $in*40000 / 61 ))

while sleep 0.1;
do
pacmd set-source-volume $source $num;
done
