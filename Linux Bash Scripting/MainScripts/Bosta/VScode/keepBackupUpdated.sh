#!/bin/bash
source "${HELPERS_DIRECTORY}Notifications.sh"
source "${HELPERS_DIRECTORY}Functions.sh"

inputDirectory="$1"

directory=$(checkEmptyAssignDefault "$inputDirectory" "$inputDirectory" "${BOSTA_DIRECTORY}Code Original/Backend/")

cd "$directory"

for dir in ./*;
do
	fullPath="$(realpath "$dir")"
	"${BOSTA_DIRECTORY}My_Scripts/VScode/updateEnviroments.sh" "$fullPath"
	sleep 10
done

sendMobileNotification "Code backup updated Done on $(date)"
