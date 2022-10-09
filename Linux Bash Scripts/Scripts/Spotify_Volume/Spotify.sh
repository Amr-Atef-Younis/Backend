#!/bin/bash
sleep 60
pactl set-sink-volume @DEFAULT_SINK@ 20%
sleep 1
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
sleep 0.5
python /mnt/F/PycharmProjects/Spotify/main.py
sleep 0.5
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
sleep 1
pactl set-sink-volume @DEFAULT_SINK@ 55%
