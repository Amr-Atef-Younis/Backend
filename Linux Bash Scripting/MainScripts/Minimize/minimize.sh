#!/bin/bash

desktop=$(xdotool get_desktop)

out=$(xdotool search --desktop $desktop --onlyvisible ".*")


for window_id in $out
do

# echo $window_id
xdotool windowminimize $window_id
#     if [ $window_id != "" ]
#     then
#         	xdotool windowminimize $window_id
#     fi
# echo "window_id= $window_id"
done
