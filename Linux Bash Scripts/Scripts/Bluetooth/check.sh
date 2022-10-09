#!/bin/bash






while true;
do

HS1="B5:6A:41:7F:6A:D5"
HS2="18:B9:6E:D6:86:CF"

ch1=$(bluetoothctl info $HS1 | grep Connected)

ch2=$(bluetoothctl info $HS2 | grep Connected)




if [ ${ch1: -3} == "yes" ]
then

x1=$(python3 /mnt/F/Scripts/Bluetooth/BT_Battery/BT_Battery.py $HS1)
x1=${x1: -3: 2}
x1=$(expr $x1 + 0)

if [ $x1 -lt 30 ]
then

gxmessage -center -borderless -fn "serif italic 30" -bg black "Critical level ( $x1 )"

fi

elif [ ${ch2: -3} == "yes" ]
then

x2=$(python3 /mnt/F/Scripts/Bluetooth/BT_Battery/BT_Battery.py $HS2)

x2=${x2: -3: 2}
x2=$(expr $x2 + 0)


if [ $x2 -eq 60 ]
then

gxmessage -center -borderless -fn "serif italic 30" -bg black "Battery level reached 50%"


elif [ $x2 -lt 30 ]
then

gxmessage -center -borderless -fn "serif italic 30" -bg black "Critical level ( $x2 )"

fi

fi


sleep 4m

done
