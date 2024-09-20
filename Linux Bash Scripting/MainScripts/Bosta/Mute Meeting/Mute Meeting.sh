#!/bin/bash

sourceIdx="$(pactl list source-outputs | grep -B 20 'application.name = "Firefox"' | grep 'Source Output #' | awk '{print $3}' | cut -c2-)"

pactl set-source-output-mute $sourceIdx toggle

sinkIdx="$(pactl list sink-inputs | grep -B 20 'application.name = "Firefox"' | grep 'Sink Input #' | awk '{print $3}' | cut -c2-)"

pactl set-sink-input-mute $sinkIdx toggle

notify-send "Audio Toggled Successfully"
