#!/bin/bash

G_drive_dir="/mnt/F/Career/CV/GoogleDrive/"

google-drive-ocamlfuse "$G_drive_dir"


timeout --foreground 1 gxmessage -center -ontop -borderless -fg "red" -fn "serif italic 100" "Sync On" 

if [ -z "$1" ];
then
item="$(zenity --entry --entry-text="$(xclip -o)" --text="File location")"
else
item="$1"
fi

if [ -z "$item" ];
then
fusermount -u "$G_drive_dir"
exit
fi
# sleep $x"m"

destination="$(echo "$item" | cut -d '/' -f4-)"

# echo "destination=$destination"
# echo "item=$item"
# echo "final path=$G_drive_dir$destination"

sleep 1

finalPath="$G_drive_dir$destination"
mkdir -vp "$finalPath"
sleep 1

if [ -d "$item" ]; 
then
# 	finalItem="$(echo ${item%?})"
# 	cp -ru "$finalItem" "$finalPath"
	cp -ru "$item"* "$finalPath"
else
	cp -ru "$item" "$finalPath"
fi

fusermount -u "$G_drive_dir"

timeout --foreground 1 gxmessage -center -ontop -borderless -fg "red" -fn "serif italic 100" "Sync Off" 
