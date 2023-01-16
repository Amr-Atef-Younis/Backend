#!/bin/bash

# gxmessage -noescape -center -sticky -ontop -borderless -fg "red" -fn "serif italic 100" "Backup Started"

cp -ru /mnt/D/Anaconda/* "/mnt/F/Machine Learning/Anaconda Installation/Anaconda Backup/Anaconda/"


a1=$(du -shBM /mnt/D/Anaconda)
a2=$(du -shBM "/mnt/F/Machine Learning/Anaconda Installation/Anaconda Backup/Anaconda")


s1=${a1:0:2}
s2=${a2:0:2}

echo ${a1:0:5} > "/mnt/F/Scripts/Backup/Original.txt"
echo ${a2:0:5} > "/mnt/F/Scripts/Backup/Backup.txt"


echo ${a1:0:5}
echo ${a2:0:5}

# if [ "$s1" = "$s2" ]; then
#     gxmessage -noescape -center -sticky -ontop -borderless -fg "red" -fn "serif italic 100" "Backup Done"
# else
#     gxmessage -noescape -center -sticky -ontop -borderless -fg "red" -fn "serif italic 100" "ERROR"
# fi


at now + 3 days "bash /mnt/F/Scripts/Backup/anaconda.sh"

# -geometry 1200x400-800-300
