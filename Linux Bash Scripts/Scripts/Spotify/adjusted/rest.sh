#!/bin/bash

pkill spotify

sleep 0.5

env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify &

sleep 2

dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play
xdotool key alt+s
