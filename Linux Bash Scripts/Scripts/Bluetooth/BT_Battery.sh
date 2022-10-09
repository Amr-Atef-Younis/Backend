#!/bin/bash
python3 /mnt/F/Scripts/Bluetooth/BT_Battery/BT_Battery.py B5:6A:41:7F:6A:D5 > /mnt/F/Scripts/Bluetooth/log.txt

# Sudo B5:6A:41:7F:6A:D5
# Realme 18:B9:6E:D6:86:CF




x="/mnt/F/Scripts/Bluetooth/"

p="Battery level is "

while read line;
do

gxmessage -center -borderless -fn "serif italic 30" -bg black  $p${line: -3}


done < $x'log.txt'



ch=$(pgrep -u amr check.sh)



if [ "$ch" == "" ]
then

/mnt/F/Scripts/Bluetooth/check.sh &

echo $(pgrep -u amr check.sh)

fi
