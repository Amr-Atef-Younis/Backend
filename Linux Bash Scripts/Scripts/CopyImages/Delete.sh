#!/bin/bash

sleep 100

while true;
do

cd ~/Desktop/Screenshots/
ls > /mnt/F/Scripts/CopyImages/S.txt
cd ~/Pictures/
ls > /mnt/F/Scripts/CopyImages/P.txt
tr ' ' '\n' < /mnt/F/Scripts/CopyImages/S.txt > /mnt/F/Scripts/CopyImages/Sm.txt
tr ' ' '\n' < /mnt/F/Scripts/CopyImages/P.txt > /mnt/F/Scripts/CopyImages/Pm.txt

sleep 600

diff  /mnt/F/Scripts/CopyImages/Sm.txt /mnt/F/Scripts/CopyImages/Pm.txt > /mnt/F/Scripts/CopyImages/Diff.txt

tr ' ' '\n' < /mnt/F/Scripts/CopyImages/Diff.txt > /mnt/F/Scripts/CopyImages/Diffm.txt
cat /mnt/F/Scripts/CopyImages/Diffm.txt | grep Sc  > /mnt/F/Scripts/CopyImages/Final.txt
cd ~/Pictures/
line=""
while read line;
do

if [[ $line != "" ]];
then
rm $line
fi

done < /mnt/F/Scripts/CopyImages/Final.txt

done
