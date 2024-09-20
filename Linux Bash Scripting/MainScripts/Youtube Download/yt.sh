#!/bin/bash

# dest="/mnt/F/For Me/Interesting Content/"

cb="$(xsel -b | tr '' '\n')"

if [ "$cb" == "" ];
then
exit
fi

title="%(title)s.%(ext)s"

log_file=$SCRIPTS_DIRECTORY"Youtube Download/Interesting_videos log.txt"


audio_dest="/mnt/F/For Me/Interesting Content/Audios/"
video_dest="/mnt/F/For Me/Interesting Content/Videos/"
temp_dest="/mnt/F/For Me/Interesting Content/Temp/"

audio_video=$(zenity --list --text="Directories" --radiolist --column="Select" --column="Data" TRUE "Audio" FALSE "Default Video" FALSE "Custom" --width=300 --height=200)

case $audio_video in 
	"Audio")
		format=140
		dest=$audio_dest
		;;
	"Default Video")
		format="$(yt-dlp -S tbr -F "$cb" | grep "video only" | grep "1280x720"  | sed -n '2p' | cut -d' ' -f1)+140"
		dest=$video_dest
		;;
	"Custom")
		fourthbest=$(yt-dlp -S tbr -F "$cb" | grep "video only" | tail -n 4 | head -n 1 | cut -d' ' -f1)
		format="140+$fourthbest"
		dest=$temp_dest
		;;
	*)
		exit
		;;
	esac


echo "yt-dlp -f $format \"$cb\" -o \"$dest\"\"$title\"" >> "$log_file"

# gxmessage -wrap -noescape -timeout 2 -geometry 1000x300-460-440 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "$(cat "$log_file" | tail -n 1)"

echo "" >> "$log_file"
echo "" >> "$log_file"

# gxmessage -noescape -timeout 1 -geometry 440x125-800-420 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "Download Started"
notify-send "Download Started"

yt-dlp -f $format "$cb" -o "$dest""$title"

notify-send "Download Finished"

# gxmessage -noescape -timeout 1 -geometry 440x125-800-420 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "Download Finished"

# if [ "$audio_video" == "2" ];
# then
# gxmessage -noescape -timeout 1 -geometry 600x125-800-420 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "The Merging has begun****"
# cd "$temp_dest"
# audio_file=$(ls . | grep ".m4a")
# video_file=$(ls . | grep -E ".mp4|.webm")
# file_basename=$(echo "$audio_file" | cut -d '.' -f1)
# 
# ffmpeg -i "$video_file" -i "$audio_file" -c:v copy -c:a aac "$video_dest""$file_basename".mp4
# 
# mv "$audio_file" "$audio_dest"
# rm "$video_file"
# gxmessage -noescape -timeout 1 -geometry 600x125-800-420 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "The Merging is Done****"
# notify-send "The Merging is Done****"
# fi
