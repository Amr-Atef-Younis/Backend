#!/bin/bash

wmctrl -lp > output.txt 

file=output.txt

variable=`grep "New Tab - Google Chrome"  $file`



comp="New Tab - Google Chrome"


while [ "$variable" = "" ] 
do

wmctrl -l > output.txt 

file=output.txt

variable=`grep "New Tab - Google Chrome"  $file`

var=${variable:24:29}

done

var=${variable:13}

echo $var

str=""
for value in $var
do

    if [ "$value" != "amr" ]
    then
    str+=$value
    else
    break
    fi
done


echo $str

wmctrl -r $str -t 4
