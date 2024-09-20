#!/bin/bash

source "${HELPERS_DIRECTORY}Functions.sh"

function handleBostaJobs() {
	local path="$1"
	cd "$path"
	newPath="${path}/cronjob"
	for dir in "${newPath}"/*;
	do
		fullPath="$(realpath "$dir")"
		"${BOSTA_DIRECTORY}My_Scripts/VScode/updateEnviroments.sh" "$fullPath"
		sleep 7
	done
}

inputDirectory="$1"

dir=$(checkEmptyAssignDefault "$inputDirectory" "$inputDirectory" ".")

cd "$dir"

isJobs="$(basename "$(pwd)")"

if [ "$isJobs" = "bosta-jobs" ];
then
	echo "handling Bosta Jobs"
# 	handleBostaJobs "$(pwd)"
	exit
fi

echo "$(pwd)"

enviroments=(staging master beta)

for env in "${enviroments[@]}"
	do
		git checkout $env
		git pull
	done

	
