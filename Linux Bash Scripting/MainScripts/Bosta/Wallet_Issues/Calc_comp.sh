#!/bin/bash

path="$BOSTA_DIRECTORY/Routine/"

x=$(zenity --entry --text="Enter Business ID")

if [ -z "$x" ];
then
exit
else

dir="$(find $path -name "$x" -type d | tail -n 1)/"

if [ "$dir" = "/" ];
then 
exit
else

. /mnt/D/Anaconda/bin/activate

python3 $BOSTA_DIRECTORY/My_Scripts/Wallet_Issues/compensation.py "$dir"


# kate -n "$dir""compensation.log" & > /dev/null 2>&1
fi
fi
