#!/bin/bash


#A=$(basename "$file" | sed 's/\(.*\)\..*/\1/')

new="new_"

x=1

while [ $x -le 23 ]
do

mod="$new$x.mkv"
ffmpeg -i "$x.mkv" -map_metadata -1 -c copy $mod

x=$(( $x + 1 ))

done






#ffmpeg -i Person.of.Interest.S01E01.720p.HDTV.X264-MRSK.mkv -map_metadata -1 -c copy movie_new.mkv
