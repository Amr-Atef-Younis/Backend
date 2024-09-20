#!/bin/bash


in=$(zenity --entry --entry-text="xbindkeys" --text="Name of the app to Kill")

if [ $in == "stacer" ]
then
killall $in
else
pkill $in
fi

if [ $in == "xbindkeys" ]
then
xbindkeys &
else
in=$(zenity --entry --entry-text=$in --text="Name of the app to launch")
path="/usr/bin/"
x="$(find "$path" -iname "$in"*)"
"$x" &
fi
