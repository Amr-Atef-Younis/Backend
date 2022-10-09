#!/bin/bash
sleep 100
while true;
do
sleep 2
rm /mnt/F/Scripts/CopyImages/text6.txt
cd ~/Desktop/Screenshots/
ls > /mnt/F/Scripts/CopyImages/text.txt
tr ' ' '\n' < /mnt/F/Scripts/CopyImages/text.txt > /mnt/F/Scripts/CopyImages/text3.txt
while read line;
do
check=$(echo $line | tail -c 5)
if [[ $check == ".png" ]];
then
cp $line ~/Pictures/
fi
done < /mnt/F/Scripts/CopyImages/text3.txt

done
