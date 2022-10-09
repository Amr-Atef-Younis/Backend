#!/bin/bash
bt-device -r 18:B9:6E:D6:86:CF
#sleep 2
bluetoothctl scan on &
while :
do
file=$(bluetoothctl pair 18:B9:6E:D6:86:CF)
check1=""
check2=""
check1=$(grep Failed <<< "$file")
check2=$(grep "Pairing successful" <<< "$file")
if [ "$check2" != "" ] && [ "$check1" = "" ]
then
bluetoothctl scan off
break
fi
done

bluetoothctl trust 18:B9:6E:D6:86:CF;
bluetoothctl connect 18:B9:6E:D6:86:CF;

