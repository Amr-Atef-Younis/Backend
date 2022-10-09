#!/bin/bash
pgrep evolution > /mnt/F/Scripts/Mail/text.txt
tr ' ' '\n' < /mnt/F/Scripts/Mail/text.txt > /mnt/F/Scripts/Mail/text2.txt
while read line;
do

kill $line

done < /mnt/F/Scripts/Mail/text2.txt

sleep 6
evolution &
