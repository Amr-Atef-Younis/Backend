#!/bin/bash



file2=$(ls | grep .mkv)

count=1
format=".mkv"
fix1="new_"
x=1
y="0"
while [ $x -le 23 ]
do

if [ $x -le 9 ]
then
total="$fix1$y$x.mkv"
else
total="$fix1$x.mkv"
fi

mv "$fix1$x.mkv" $total


x=$(( $x + 1 ))

done
