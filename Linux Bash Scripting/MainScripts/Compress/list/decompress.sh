#!/bin/bash

source "$FUNCTIONS"

file_path=$SCRIPTS_DIRECTORY"Compress/list/Decompressed List.txt"

openFileIntoArray "$file_path"


function decompressItems() {
	dir="$(echo "$2" | rev | cut -d'/' -f2- | rev)"
	cd "$dir"
	item="$(basename "$2")"
	

	notify-send "Decompressing $item"

	destination="$(zenity --file-selection --directory --title="Select Destination Directory" --filename="/mnt/F/")"
	destination="$(checkEmptyAssignDefault "$destination" "$destination" "./")"
	
	xz -d -c "$item" | pv -s $(du -b "$item" | cut -f1) | tar -xf - -C "$destination"
}


exec 3< "$file_path"
readarray -C decompressItems -c 1 -u 3 -t myArray
exec 3<&-

notify-send "Decompression DONE !!!!"
