#!/usr/bin/env bash
#pactl unload-module module-echo-cancel
pactl load-module module-echo-cancel aec_method=webrtc source_name=ModifiedMic 

sleep 0.3

pacmd set-default-source ModifiedMic 

sleep 0.2
#pacmd update-source-proplist alsa_input.pci-0000_00_1f.3.analog-stereo device.description=FrontMicrophone


pacmd update-source-proplist ModifiedMic device.description=ModifiedMic 

#sleep 0.2

#pacmd set-source-volume "ModifiedMic" 78642
