#!/bin/bash

wmpath=$SCRIPTS_DIRECTORY"ChatGPT/wmctrl.txt"
xdopath=$SCRIPTS_DIRECTORY"ChatGPT/xdotool.txt"


wm_pid=$(wmctrl -xlp | grep -i ChatGPT | grep -i "\.firefox"\
| cut -d' ' -f4)


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
echo "$wm_pid" > "$wmpath"
echo "$xdo_pid" > "$xdopath"
fi



