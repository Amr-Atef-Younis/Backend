#!/bin/bash

pkill gedit

x=$SCRIPTS_DIRECTORY"Temperature/"

rm $x'fin.txt'

sensors > $x'Temperature.txt'

sed -n '3,$p;7q' $x'Temperature.txt' > $x'fin.txt'


# echo   >> $x'Temperature.txt
# echo   >> $x'Temperature.txt



echo   >> $x'fin.txt'
echo   >> $x'fin.txt'




tail -n6 $x'Temperature.txt' >> $x'fin.txt'

gedit $SCRIPTS_DIRECTORY"Temperature/fin.txt"

# echo   >> $x'fin.txt'

# hddtemp /dev/sdb >> $x'fin.txt'

# echo   >> $x'fin.txt'

# hddtemp /dev/sdc >> $x'fin.txt'

# echo   >> $x'fin.txt'

