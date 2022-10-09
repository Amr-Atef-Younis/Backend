#!/bin/bash

pkill gedit

x='/mnt/F/Scripts/Temperature/'

rm $x'fin.txt'

sensors > $x'Temperature.txt'

sed -n '3,$p;7q' $x'Temperature.txt' > $x'fin.txt'


# echo   >> $x'Temperature.txt
# echo   >> $x'Temperature.txt



echo   >> $x'fin.txt'
echo   >> $x'fin.txt'




hddtemp /dev/sda >> $x'fin.txt'

echo   >> $x'fin.txt'

hddtemp /dev/sdb >> $x'fin.txt'

echo   >> $x'fin.txt'

hddtemp /dev/sdc >> $x'fin.txt'

echo   >> $x'fin.txt'

