#!/bin/bash 

killall gxmessage
x='"$SCRIPTS_DIRECTORY"Memory/'

free --mega -h > $x'text.txt'
awk '{print $7}' $x'text.txt' > $x'text2.txt'
sed -n '2 p'  $x'text2.txt' > $x'text3.txt'
gxmessage -geometry 110x118 -borderless -fn "serif italic 30" -bg black -file $x'text3.txt'
