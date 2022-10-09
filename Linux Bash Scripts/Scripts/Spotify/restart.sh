#!/bin/bash
killall spotify

env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify  &

# sleep 1
# dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause

sleep 1
pidof spotify > /mnt/F/Scripts/Spotify/text2.txt
python3 /mnt/F/Scripts/Spotify/spotify.py &
