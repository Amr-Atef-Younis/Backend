#!/bin/bash


check=$(xdotool search --onlyvisible --classname spotify)

if [ "$check" != "" ] 
then
wmctrl -i -c $check
fi
spotify  2>&1 & disown;










