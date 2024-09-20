#!/bin/bash
source ~/.profile

x=$SCRIPTS_DIRECTORY"TestInternetSpeed/text1.txt"
y=$SCRIPTS_DIRECTORY"TestInternetSpeed/output.txt"

# speedtest --secure > $x
speedtest > $x
egrep "Download" $x > $y

# echo "" >> $x

egrep "Upload" $x >> $y

# check=$(sed '1,3!d' $x)
# check=$(cat $y | head -n 2)


# gxmessage -geometry 950x130-560-540 -sticky -borderless -ontop -title "Internet Speed" -fn "serif italic 30" $check




gxmessage -geometry 520x180-560-540 -sticky -noescape -borderless -ontop -wrap -title "Internet Speed" -fn "serif italic 30" -file $y

