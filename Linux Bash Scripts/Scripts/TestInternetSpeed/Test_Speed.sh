#!/bin/bash
source ~/.profile

speedtest --secure > "/mnt/F/Scripts/TestInternetSpeed/text1.txt"

egrep "Download" "/mnt/F/Scripts/TestInternetSpeed/text1.txt" > "/mnt/F/Scripts/TestInternetSpeed/output.txt"

egrep "Upload" "/mnt/F/Scripts/TestInternetSpeed/text1.txt" >> "/mnt/F/Scripts/TestInternetSpeed/output.txt"

check=$(sed '1,3!d' "/mnt/F/Scripts/TestInternetSpeed/output.txt")


gxmessage -geometry 950x130-560-540 -sticky -borderless -ontop -title "Internet Speed" -fn "serif italic 30" $check

# -geometry 240x120-960-540

# -file /mnt/F/Scripts/TestInternetSpeed/output.txt

# kate "/mnt/F/Scripts/TestInternetSpeed/output.txt"
