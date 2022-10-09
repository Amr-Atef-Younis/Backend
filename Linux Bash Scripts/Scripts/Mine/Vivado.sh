#!/bin/bash

wmctrl -l > output.txt 

file=output.txt

variable=`grep "Vivado 2019.1"  $file`

var=${variable:18}


comp="Vivado 2019.1"

echo $var2

while [ "$var" != "$comp" ] 
do

wmctrl -l > output.txt 

file=output.txt

variable=`grep "Vivado 2019.1"  $file`

var=${variable:18}

done


#xdotool search --pid "$var2" set_desktop_for_window %@ 6 

wmctrl -r "$var" -t 4
