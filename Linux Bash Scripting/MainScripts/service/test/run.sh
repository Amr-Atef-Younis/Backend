#!/bin/sh

# pactl load-module module-combine-sink sink_name=combined sink_properties=device.description=combined slaves="alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo",\
# "alsa_output.pci-0000_00_1f.3.analog-stereo"

while true;
do
app=$(pactl list sink-inputs | grep "application.process.binary" | \
grep -inE 'caprine|rambox' |cut -d ':' -f1)
app_info=$(pactl list short sink-inputs | grep -v "combine" | sed -n $app"p")
app_idx=$(echo $app_info  | awk '{ print $1}')

# app=$(pacmd list sink-inputs | grep "application.process.binary" | \
# grep -inE 'caprine|rambox' )

# app_idx=$(pacmd list sink-inputs | grep "* index"| head -n 1 | rev | cut -d ' ' -f1)

# device=$(pactl list short sinks | grep -i combined | cut -d ' ' -f1)

if [ "$app" != "" ];
then
# pactl move-sink-input $app_idx combined
pactl move-sink-input $app_idx "alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo"
fi
done
