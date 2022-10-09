#!/bin/bash


xdotool search --onlyvisible --class caprine > /mnt/F/Scripts/Messenger/visible.txt


xdotool search --class caprine > /mnt/F/Scripts/Messenger/check.txt





# tr ' ' '\n' < /mnt/F/Scripts/Messenger/file.txt
# tr ' ' '\n' < /mnt/F/Scripts/Messenger/file2.txt
# 
# ch=""
# 
# while read line2;
# do
# 
# 
# while read line;
# do
# 
# if [[ $line == $line2 ]];
# then
# ch=$line
# break
# fi
# 
# done < /mnt/F/Scripts/Messenger/file.txt
# 
# 
# if [[ $ch != "" ]];
# then
# break
# fi
# 
# done < /mnt/F/Scripts/Messenger/file2.txt
# 
# 
# echo "ch = $ch"
# echo "check = $check"
# 
# if [[ $ch != "" ]];
# then
# 
# if [[ $check == "" ]];
# then
# xdotool windowmap $ch
# xdotool windowactivate $ch
# else
# xdotool windowunmap $ch
# fi
# 
# fi
