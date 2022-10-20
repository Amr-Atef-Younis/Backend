#!/bin/bash

in1=$(zenity --entry --entry-text="Series" --text="path")

p="/mnt/E/"

m="Movies"

if [ $in1 == "Series" ]
then
in2=$p$in1"/"
else
in2=$p$m"/"
fi

name=$(zenity --entry --text="Movie/Series Name")

python3 /mnt/F/Scripts/Link/Link.py $in2 $name
