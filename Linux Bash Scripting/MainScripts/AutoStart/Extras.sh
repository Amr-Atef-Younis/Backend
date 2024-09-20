#!/bin/bash

brave-browser "https://chat.openai.com" &

# /opt/vivaldi/vivaldi --profile-directory=Main --app-id=leelebojpeanofdkdobgooogpfglgjpe &

sleep 10

"${SCRIPTS_DIRECTORY}Show Hide Applications/minimize.sh" Brave-browser &

echo "$PASSWORD" | sudo -S ethtool -s eth0 wol g

"${SCRIPTS_DIRECTORY}Mic/MicVolume/MicVolume.sh" 95 &
