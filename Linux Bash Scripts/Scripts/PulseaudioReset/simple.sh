#!/bin/bash

pulseaudio -k

sleep 1

killall -I spotify
killall -I discord
killall -I clementine
killall -I caprine

sleep 1

env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify &
clementine &
sleep 4
wmctrl -c clementine 


sleep 1
xdotool key alt+s

caprine &
/usr/share/discord/Discord &
sleep 4
# xdotool key alt+m

sleep 2
wmctrl -c discord




