#!/bin/bash
while [ true ] ; do
read -t 2 -n 1
if [ $? = 0 ] ; then
exit ;
else
xset dpms force off
fi
done
