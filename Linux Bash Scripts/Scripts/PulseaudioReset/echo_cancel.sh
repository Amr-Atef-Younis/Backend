#!/usr/bin/env bash
#pactl unload-module module-echo-cancel
pactl load-module module-echo-cancel aec_method=webrtc source_name=ModifiedMic
pacmd set-default-source ModifiedMic


#pacmd update-source-proplist alsa_input.pci-0000_00_1f.3.analog-stereo device.description=FrontMicrophone


pacmd update-source-proplist ModifiedMic device.description=ModifiedMic
