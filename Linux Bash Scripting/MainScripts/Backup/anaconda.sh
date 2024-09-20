#!/bin/bash



a1=$(du -shBM /mnt/D/Anaconda)
a2=$(du -shBM "/mnt/F/Machine Learning/Anaconda Installation/Anaconda")



s1=(${a1//M/ })
s2=(${a2//M/ })

d=$(date)

fd=${d:0:-21}

echo $fd >> $SCRIPTS_DIRECTORY"Backup/Original.txt"
echo $fd >> $SCRIPTS_DIRECTORY"Backup/Backup.txt"

# echo $s1
# echo $s2


echo $s1 >> $SCRIPTS_DIRECTORY"Backup/Original.txt"
echo $s2 >> $SCRIPTS_DIRECTORY"Backup/Backup.txt"

difference=$(( s1 - s2 ))


if [ $difference -gt 7 ]
then

cp -ru /mnt/D/Anaconda/* "/mnt/F/Machine Learning/Anaconda Installation/Anaconda Backup/Anaconda/"

kdeconnect-cli --ping-msg "Backup Done" --name "WAS-LX1A"

else



kdeconnect-cli --ping-msg "No need for Backup" --name "WAS-LX1A"

fi
