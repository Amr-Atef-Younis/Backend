#!/bin/bash

wmpath=$SCRIPTS_DIRECTORY"Notion/wmctrl.txt"
xdopath=$SCRIPTS_DIRECTORY"Notion/xdotool.txt"

wm_pid="$( wmctrl -xlp | grep -i "Notion" | grep -i "\.Notion"| cut -d' ' -f4 )"

if [ -z "$wm_pid" ];
then
wm_pid="$(cat "$wmpath" | head -n1)"
xdo_pid="$(cat "$xdopath" | head -n1)"
kill -CONT "$wm_pid"
xdotool windowmap "$xdo_pid"
xdotool windowactivate "$xdo_pid"
else
xdo_pid=$(xdotool search --onlyvisible --pid $wm_pid)
kill -STOP $wm_pid
xdotool windowunmap $xdo_pid
echo $wm_pid > "$wmpath"
echo $xdo_pid > "$xdopath"
fi
