#!/bin/bash

source "${HELPERS_DIRECTORY}Functions.sh"

wmpath=$BOSTA_DIRECTORY"My_Scripts/Minimize/$1/wmctrl.txt"
xdopath=$BOSTA_DIRECTORY"My_Scripts/Minimize/$1/xdotool.txt"


wm_pid=$(wmctrl -xlp | grep -i "$1" | grep -i "\.$1"| cut -d' ' -f4)
exists=$(xdotool search --classname $1)

checkOnlyOneAppOpenned=$(echo "$wm_pid" | sed -n '2p')
exitIfNotEmpty $checkOnlyOneAppOpenned

if [ -z "$exists" ];
then
	path="/usr/bin/"
	x="$(find "$path" -iname "$1*" | head -n 1)"
	"$x" &
	sleep 1
	wm_pid=$(wmctrl -xlp | grep -i "$1" | grep -i "\.$1"| cut -d' ' -f4)
	xdo_pid=$(xdotool search --onlyvisible --pid $wm_pid)
	echo $wm_pid > "$wmpath"
	echo $xdo_pid > "$xdopath"
else
	if [ -z "$wm_pid" ];
	then
		echo "showing"
		wm_pid="$(cat "$wmpath" | head -n1)"
		xdo_pid="$(cat "$xdopath" | head -n1)"
		kill -CONT "$wm_pid"
		xdotool windowmap $xdo_pid && xdotool windowactivate $xdo_pid
	else
		echo "hiding"
		xdo_pid=$(xdotool search --onlyvisible --pid $wm_pid)
		kill -STOP $wm_pid
		xdotool windowunmap $xdo_pid
		echo $wm_pid > "$wmpath"
		echo $xdo_pid > "$xdopath"
	fi
fi
