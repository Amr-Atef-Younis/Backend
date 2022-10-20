#!/bin/bash

ch=$(zenity --entry --text="1:HDMI  2:USB  3:Headphone")

python3 /mnt/F/Scripts/DefaultOutputDevice/All/all.py $ch
