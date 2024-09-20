#!/bin/bash

commands_file="${SCRIPTS_DIRECTORY}CloseOpen/commands"

source "${HELPERS_DIRECTORY}Functions.sh"

app="$1"

if [ "$app" = "Google Tasks" ];
then
	result="$(wmctrl -pxl | grep -i "${app}")"
	launchCommand="/opt/vivaldi/vivaldi --profile-directory=Main --app-id=leelebojpeanofdkdobgooogpfglgjpe"
else
	result="$(wmctrl -pxl | grep -i "\.${app}")"
	launchCommand="$(cat "${commands_file}" | grep -i "${app}")"
fi

echo "result = $result"
idx="$(echo "${result}" | cut -d' ' -f1)"

launch="$(checkEmptyAssignDefault "$result" false true)"

echo "launch = $launch"
command="$(assignIfTrueElse "$launch" "${launchCommand} &" "wmctrl -ic ${idx}")"

echo "command = $command"

eval "${command}"
