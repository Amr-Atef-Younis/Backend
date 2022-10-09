#!/bin/bash

x=$(xdotool get_desktop)
for window_id in $(xdotool search --onlyvisible --desktop $x ".*")
do
    if [ $window_id != "" ]
    then
        	xdotool windowminimize $window_id
    fi
done
