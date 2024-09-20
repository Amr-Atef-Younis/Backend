#!/bin/bash

source "${HELPERS_DIRECTORY}Functions.sh"
. ${HOME}/.bash_aliases


path=$(checkEmptyAssignDefault $2 "${BOSTA_DIRECTORY}Code Original/" "/home/amr/Bosta/Code/" )

script_path="${BOSTA_DIRECTORY}My_Scripts/VScode/"


if [ -z "$1" ];
then
webstorm "${path}Backend/app/" &
exit
fi


bash "${script_path}setup_directoryFile.sh"

# out=$(zenity --list --text="Directories" --column="Select" --column="Data" --checklist $(awk '{print ""$0""}' $script_path"directory.txt") --width=300 --height=400)
out=$(yad --list --checklist --text="Directories" \
    --column="Select" --column="Data" \
	$(awk '{print $0}' "$script_path/directory.txt") \
	--grid-lines=hor \
    --width=300 --height=400 --center)


if [ -z "$out" ];
then
exit
elif [ ! -z "$(echo "$out" | cut -d'|' -f2)" ];
then
	for element in $out
	do
		repo="$(echo $element | cut -d'|' -f2)"
		webstorm "$(find "$path" -maxdepth 2 -name "$repo" -type d )" &
		sleep 0.5
	done
else
webstorm "$(find "$path" -maxdepth 2 -name "$out" -type d )" &
fi

