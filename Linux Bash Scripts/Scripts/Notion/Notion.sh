#!/bin/bash

check=""
check=$(xdotool search --onlyvisible --classname notion-snap)

xdotool search --role browser-window > /mnt/F/Scripts/Notion/file2.txt
tr ' ' '\n' < /mnt/F/Scripts/Notion/file2.txt

xdotool search --classname notion-snap > /mnt/F/Scripts/Notion/file.txt
tr ' ' '\n' < /mnt/F/Scripts/Notion/file.txt

ch=""

while read line2;
do

while read line;
do

if [[ $line == $line2 ]];
then
ch=$line
break
fi

done < /mnt/F/Scripts/Notion/file.txt

if [[ $ch != "" ]];
then
break
fi

done < /mnt/F/Scripts/Notion/file2.txt



if [[ $ch != "" ]];
then

if [[ $check == "" ]];
then
xdotool windowmap $ch
xdotool windowactivate $ch
else
xdotool windowunmap $ch
fi

else
notion-snap &

fi
