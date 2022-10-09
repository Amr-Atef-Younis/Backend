#!/bin/bash

pulseaudio -k

sleep 0.4

check=$(xdotool search --onlyvisible --classname caprine getwindowpid)

check2=$(xdotool search --onlyvisible --classname spotify getwindowpid)

check3=$(xdotool search --onlyvisible --classname vlc getwindowpid)

kill $check

kill $check2

kill $check3

sleep 0.4

caprine 2>&1 &disown

spotify 2>&1 &disown

env BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/vlc_vlc.desktop /snap/bin/vlc %U 2>&1 &disown


pacmd update-source-proplist ModifiedMic device.description=ModifiedMic



