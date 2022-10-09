#!/bin/bash


in=$(zenity --entry --entry-text="xbindkeys" --text="Name of the app to Kill")


pkill $in


if [ $in == "xbindkeys" ]
then
xbindkeys &
else
in=$(zenity --entry --entry-text=$in --text="Name of the app to launch")
$in &
fi
