#!/bin/sh
check=""
check=$(xdotool search --name htop getwindowpid)
if [ "$check" = "" ]
then
htop &
else
wmctrl -i -c $check
fi
