#!/bin/bash

path="/home/amr/Bosta/Code/"
script_path="$BOSTA_DIRECTORY/My_Scripts/VScode/"

temp_file="$BOSTA_DIRECTORY/My_Scripts/VScode/directory_temp.txt"
file="$BOSTA_DIRECTORY/My_Scripts/VScode/directory.txt"


backEnd=$path"Backend"

find "$backEnd" -maxdepth 1 -not -iname "BackEnd" -type d | rev | cut -d"/" -f1 | rev | sort > "$temp_file"
echo "Mine" >> "$temp_file"


rm "$file"

while read LINE; do
	echo "FALSE $LINE" >> "$file"
done < "$temp_file"

rm "$temp_file"
