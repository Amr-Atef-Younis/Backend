#!/bin/bash

source "${HELPERS_DIRECTORY}Functions.sh"

mkdir -p "${SCRIPTS_DIRECTORY}Show Hide Applications/$1/"
wmpath="${SCRIPTS_DIRECTORY}Show Hide Applications/$1/wmctrl.txt"
xdopath="${SCRIPTS_DIRECTORY}Show Hide Applications/$1/xdotool.txt"


wm_pid=$(wmctrl -xlp | grep -i "$1" | grep -i "\.$1"| cut -d' ' -f4)
exists=$(xdotool search --classname $1)

checkOnlyOneAppOpenned=$(echo "$wm_pid" | sed -n '2p')
exitIfNotEmpty $checkOnlyOneAppOpenned

if [ -z "$wm_pid" ];
then
	wm_pid="$(cat "$wmpath" | head -n1)"
	xdo_pid="$(cat "$xdopath" | head -n1)"
	xdotool windowmap "$xdo_pid"
	xdotool windowactivate "$xdo_pid"
else
	xdo_pid=$(xdotool search --onlyvisible --pid $wm_pid)
	xdotool windowunmap $xdo_pid
	echo $wm_pid > "$wmpath"
	echo $xdo_pid > "$xdopath"
fi
