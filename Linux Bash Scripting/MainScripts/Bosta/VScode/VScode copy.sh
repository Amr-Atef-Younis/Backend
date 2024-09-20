#!/bin/bash

source "${HELPERS_DIRECTORY}Functions.sh"

path=$(checkEmptyAssignDefault $2 "${BOSTA_DIRECTORY}Code Original/" "/home/amr/Bosta/Code/" )

script_path="${BOSTA_DIRECTORY}My_Scripts/VScode/"

# echo "path=$path"

if [ -z "$1" ];
then
code -n "$path""Backend/app/"
exit
fi


bash ${script_path}setup_directoryFile.sh

# out=$(zenity --list --text="Directories" --column="Select" --column="Data" --checklist $(awk '{print ""$0""}' $script_path"directory.txt") --width=300 --height=400)
# out=$(yad --list --checklist --text="Directories" \
#     --column="Select" --column="Data" \
#     $(awk '{print $0}' "$script_path/directory.txt") \
#     --center)
    
echo $out

if [ -z "$out" ];
then
exit
elif [ ! -z "$(echo "$out" | cut -d'|' -f2)" ];
then
	IFS='|' read -r -a array <<< "$out"
	echo $array
	for element in "${array[@]}"
	do
		echo $element
		code -n "$(find "$path" -maxdepth 2 -name "$element" -type d )" &
		sleep 0.5
	done
else
code -n "$(find "$path" -maxdepth 2 -name "$out" -type d )" &
fi



# code -n "$path" &
