#!/bin/bash

dest="$COURSES_DIRECTORY"
log_file=$SCRIPTS_DIRECTORY"Youtube Download/Courses log.txt"
formats_file=$SCRIPTS_DIRECTORY"Youtube Download/formats.txt"
filtered_formats=$SCRIPTS_DIRECTORY"Youtube Download/combined.txt"

cb="$(xsel -b | tr '' '\n')"


if [ "$cb" == "" ];
then
exit
fi

timeout 10 yt-dlp -S tbr -F "$cb" | grep --line-buffered -E "1280x720.*video only" > "$formats_file" &

yt_dlp_pid=$!

mainDir=$(zenity --file-selection --directory --filename="$dest")
if [ "$mainDir" = "" ];
then
exit
fi
dir=$(zenity --entry --text="Enter course name")
if [ "$dir" == "" ];
then
final_dest="$mainDir/"
else
final_dest="$mainDir/$dir/"
fi


mkdir -vp "$final_dest"


audio_video=$(zenity --list --text="Directories" --radiolist --column="Select" --column="Data" FALSE "Audio" TRUE "Default Video" FALSE "Custom" --width=300 --height=200)

case $audio_video in 
	"Audio")
		format=140
		dest="$final_dest"
		;;
	"Default Video")
		wait $yt_dlp_pid
		format="$(cat "$formats_file" | sed -n '3p'| cut -d' ' -f1)+140"
		dest="$final_dest"
		;;
	"Custom")
		audio_format=140
		wait $yt_dlp_pid
		cat "$formats_file" | grep -E "720p|1080p"| grep "video only" | tail -n 4 > "$filtered_formats"

		gedit "$filtered_formats"

		video_format=$(zenity --entry --entry-text="$(cat "$formats_file" | grep -E "720p|1080p"| grep "video only" | tail -n 3 |\
		sed -n "1p" | cut -d' ' -f1)" --text="Desired Format")
		
		if [ -z "$video_format" ];
		then
		exit
		fi
		
		format="$video_format+$audio_format"
		dest="$final_dest"
		;;
	*)
		exit
		;;
	esac


title="%(title)s.%(ext)s"

if [ "$1" = "playlist" ];
then
index=$(zenity --entry --entry-text="" --text="start:end")
extraArgument="%(playlist_index)02d-%(title)s.%(ext)s"
if [ "$index" = "" ];
then
final_index="--yes-playlist"
else
final_index="--yes-playlist -I $index"
fi
else
extraArgument="%(title)s.%(ext)s"
fi

echo "yt-dlp -f $format \"$cb\" $final_index -o \"$final_dest$extraArgument\"" >> "$log_file"

gxmessage -wrap -noescape -timeout 2 -geometry 1000x300-460-440 -sticky -ontop -borderless -fg "yellow" -fn "serif\
italic 30" "$(cat "$log_file" | tail -n 1)"

echo "" >> "$log_file"
echo "" >> "$log_file"
echo "" >> "$log_file"

if [ -n "$(pgrep yt-dlp)" ];
then
gxmessage -noescape -timeout 1 -geometry 690x121-600-520 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "Another Download is in progress"

while [ -n "$(pgrep yt-dlp)" ];
do
continue
done
min_range=1
max_range=8
random_within_range=$((min_range + RANDOM % (max_range - min_range + 1)))
sleep $random_within_range
fi

# gxmessage -noescape -timeout 1 -geometry 800x121-600-520 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "Download started for $final_dest"
notify-send "Download started for $final_dest"

yt-dlp -f $format "$cb" $final_index -o "$final_dest $extraArgument"

# gxmessage -noescape -timeout 1 -geometry 800x121-600-520 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "Download finished for $final_dest"
notify-send "Download finished for $final_dest"
