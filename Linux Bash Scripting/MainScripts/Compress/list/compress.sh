#!/bin/bash

source "${HELPERS_DIRECTORY}Functions"
source "${HELPERS_DIRECTORY}Notifications"

dirPath=$SCRIPTS_DIRECTORY"Compress/list/"
file_path=$dirPath"Compressed List.txt"

openFileIntoArray "$file_path"


function compressItems() {
	dir="$(echo "$2" | rev | cut -d'/' -f2- | rev)"
	cd "$dir"
	item="$(basename "$2")"
# 	SIZE=$(du -shBM ./"$item" | cut -d'M' -f1)
	echo "$2" > $dirPath"Size.txt"
	du -shBM ./"$item" | cut -d'M' -f1 > $dirPath"Size.txt" &

	notify-send "Compressing $item"
	
	destination="$(zenity --file-selection --directory --title="Select Destination Directory" --filename="/mnt/F/")/$item.tar.xz"
	destination="$(checkEmptyAssignDefault "$destination" "$destination" "./$item.tar.xz")"

# 	tar c "$item" | pv -s $SIZE | xz -9 > "$destination"
	tar c "$item" | xz -9 > "$destination"
}


exec 3< "$file_path"
readarray -C compressItems -c 1 -u 3 -t myArray
exec 3<&-


sendMobileNotification "Compression DONE !!!!"
