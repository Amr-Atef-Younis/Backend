#!/bin/bash

in=""
in=$(zenity --entry)

if [[ $in == "" ]];
then
shutdown -h now
else
sleep $in
shutdown -h now
fi
