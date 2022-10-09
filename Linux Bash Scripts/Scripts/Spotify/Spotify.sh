#!/bin/bash
xdotool search --onlyvisible --classname Spotify >> /mnt/F/Scripts/Spotify/text.txt
check=""
check=$(xdotool search --onlyvisible --classname Spotify)
#python /mnt/F/PycharmProjects/Spotifyonoff/venv/spotify.py
ch=""
ch=$check
tr ' ' '\n' < /mnt/F/Scripts/Spotify/text.txt

while read line;
do

if [[ $line != "" ]];
then
ch=$line
fi

done < /mnt/F/Scripts/Spotify/text.txt

if [[ $check == "" ]];
then
xdotool windowmap $ch
else
xdotool windowunmap $check
fi
