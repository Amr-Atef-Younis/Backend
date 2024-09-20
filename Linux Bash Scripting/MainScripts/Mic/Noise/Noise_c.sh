#!/usr/bin/env bash

check=""
check=$(pactl list sources | grep "ModifiedMic")

in=""
in=$(zenity --entry --entry-text="Activate Noise Removal" --text="Activate Noise Removal")

if [ "$in" = "Activate Noise Removal" ];
then
ww=$(pactl unload-module module-echo-cancel)

#pacmd set-default-source alsa_input.pci-0000_00_1f.3.analog-stereo
pactl load-module module-echo-cancel aec_method=webrtc source_name=ModifiedMic
sleep 0.1
pacmd set-default-source ModifiedMic
sleep 0.1
pacmd update-source-proplist ModifiedMic device.description=ModifiedMic
# pacmd set-source-volume ModifiedMic 57000

# "$SCRIPTS_DIRECTORY"MicVolume/MicVolume.sh 0 &
bash "$SCRIPTS_DIRECTORY"Mic/MicVolume/MicVolume.sh &
else
pkill MicVolume.sh &
pactl unload-module module-echo-cancel
fi
