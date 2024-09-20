#!/bin/bash

wmpath="$BOSTA_DIRECTORY/My_Scripts/Logs/wmctrl.txt"
xdopath="$BOSTA_DIRECTORY/My_Scripts/Logs/xdotool.txt"


wm_pid=$(wmctrl -xlp | grep -i "\.Brave-browser"| cut -d' ' -f4)

if [ -z "$wm_pid" ];
then
### showing
wm_pid="$(cat "$wmpath" | head -n1)"
xdo_pid="$(cat "$xdopath" | head -n1)"
xdotool windowmap $xdo_pid && xdotool windowactivate $xdo_pid
kill -CONT "$wm_pid"
else
### hiding
xdo_pid=$(xdotool search --onlyvisible --pid $wm_pid)
xdotool windowunmap $xdo_pid
kill -STOP $wm_pid
echo $wm_pid > "$wmpath"
echo $xdo_pid > "$xdopath"
fi



