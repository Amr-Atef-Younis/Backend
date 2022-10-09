#!/bin/bash
#include <math.h>

in=$(zenity --entry --entry-text="65" --text="Enter % MicVolume")

if [ $in != "" ]
then
ch=$(pacmd stat | grep "Default source name")

source=${ch: 21}


num=$(( $in*40000 / 61 ))
# echo $num
while sleep 0.1;
do
pacmd set-source-volume $source $num;
done

else

pkill MicVolume.sh

fi
