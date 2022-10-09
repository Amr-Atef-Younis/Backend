#!/bin/bash
check=""
check=$(xdotool search --role 3pane)
ch=""
ch=$(xdotool search --onlyvisible --classname mail)
if [[ $ch == "" ]];
then
xdotool windowmap $check
xdotool windowactivate $check
else
xdotool windowunmap $ch
fi




#!/bin/bash
xdotool search --onlyvisible --classname mail >> /mnt/F/Scripts/Mail/text.txt
check=""
check=$(xdotool search --onlyvisible --classname Spotify)
#python /mnt/F/PycharmProjects/Spotifyonoff/venv/spotify.py
ch=""
ch=$check
tr ' ' '\n' < /mnt/F/Scripts/Mail/text.txt

while read line;
do

if [[ $line != "" ]];
then
ch=$line
fi

done < /mnt/F/Scripts/Mail/text.txt

if [[ $check == "" ]];
then
xdotool windowmap $ch
else
xdotool windowunmap $check
fi
