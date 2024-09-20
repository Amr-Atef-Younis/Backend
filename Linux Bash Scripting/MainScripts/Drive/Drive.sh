#!/bin/bash

x=$(zenity --entry --entry-text="2" --text="On time")

google-drive-ocamlfuse "/mnt/F/Machine Learning/CV/GoogleDrive/"
dolphin "/mnt/F/Machine Learning/CV/GoogleDrive/"



sleep $x"m"

gxmessage -noescape -center -sticky -ontop -borderless -fg "red" -fn "serif italic 100" "Sync Off"


fusermount -u "/mnt/F/Machine Learning/CV/GoogleDrive/"
