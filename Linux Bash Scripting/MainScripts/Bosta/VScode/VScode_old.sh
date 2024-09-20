#!/bin/bash

inp=$(zenity --entry --text="1:Backend\t2:Frontend")

if [ -z "$inp" ];
then
x="$(ls /home/amr/Videos/ | head -n 1)"
cd "/home/amr/Videos/$x/Exercises/" && code -n . &
exit
elif [ "$inp" = "2" ];
then
path="$BOSTA_DIRECTORY/Code/engineering"
elif [ "$inp" = "1" ];
then
path="$BOSTA_DIRECTORY/Code/BackEnd/app/"
else
path="$inp"
fi

code -n "$path" &
