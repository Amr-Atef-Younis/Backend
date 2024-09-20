#!/bin/bash

# case "$1" in
# 	"reset")
# 		xrandr --output HDMI-1-0 --off && sleep 2 && xrandr --output HDMI-1-0 --mode 1920x1080 --primary --pos 0x0
# 		;;
# 	"laptop")
# 		xrandr --output eDP-1 --off && sleep 2 && xrandr --output eDP-1 --mode 1920x1080 --rotate normal --right-of HDMI-1-0 --scale 0.6 --refresh 60 --noprimary
# 		;;
# 	*)
# 		exit
# 		;;
# esac

xrandr --output eDP-1 --off
xrandr --output HDMI-1-0 --off 
sleep 1
xrandr --output HDMI-1-0 --mode 1920x1080 --primary --pos 0x0
sleep 1
# xrandr --output HDMI-1-0 --mode 1920x1080 --primary --pos 0x0 
xrandr --output eDP-1 --noprimary --mode 1920x1080 --rotate normal  --scale 0.6 --refresh 60 --right-of HDMI-1-0