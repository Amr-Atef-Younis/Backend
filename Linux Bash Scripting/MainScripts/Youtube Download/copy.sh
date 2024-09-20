#!/bin/bash

still_downloading=$(pgrep "yt-dlp")

source="$COURSES_DIRECTORY\Default YT directory/"

dest="$COURSES_DIRECTORY"

dir1=$(echo $1 | cut -d "/" -f1)
dir2=$(echo $1 | cut -d "/" -f2)



while true;
do

if [ -z "${still_downloading}" ];
then

if [ -z "${dir1}" ];
then

dir_exist=$(ls "$dest" | grep -i "$1")


if [ -z "${dir_exist}" ];
then
mkdir -vp "$dest$1"
fi


f_dir="$dest$1"

else
dir_exist=$(ls "$dest" | grep -i "$dir1")


if [ -z "${dir_exist}" ];
then
mkdir -vp "$dest$1"
f_dir="$dest$1"
else
mkdir -vp "$dest$dir_exist/$dir2"
f_dir="$dest$dir_exist/$dir2"
fi


fi
break
fi

sleep 1m
still_downloading=$(pgrep "yt-dlp")

done

gxmessage -noescape -geometry 440x125-800-420 -timeout 1 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "Copying Started" &
cp -u "$source"*".mp4"  "$f_dir"
gxmessage -noescape -geometry 440x125-800-420 -timeout 1 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "Copying Finished" 


# src="$COURSES_DIRECTORYCourses/Default YT directory/"
# 
# cd "$1"
# x=$(ls | xargs -0 -d '\n' stat -c %z | cut -d ' ' -f1 | sort -r)
# y=$(echo $x | cut -d ' ' -f1)
# ch=$(date +%Y-%m-%d)


# if [ "$ch" = "$y" ];
# then
# rm "$src"*".mp4"
# fi


