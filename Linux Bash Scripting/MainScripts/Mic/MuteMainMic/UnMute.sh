#!/bin/bash
pactl set-source-mute alsa_input.usb-GeneralPlus_USB_Audio_Device-00.mono-fallback 0
pactl set-source-mute alsa_input.pci-0000_00_1f.3.analog-stereo 0
pactl set-source-mute ModifiedMic 0
pactl set-source-mute alsa_input.usb-GeneralPlus_USB_Audio_Device-00.multichannel-input 0
gxmessage -center -timeout 1 -borderless -geometry 500x200 -fn "serif italic 20" -bg green "Mic is on"  | (sleep 0.7 && pkill gxmessage)
