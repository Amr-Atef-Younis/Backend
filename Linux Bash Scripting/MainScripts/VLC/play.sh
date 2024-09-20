#!/bin/bash


cdir="$SCRIPTS_DIRECTORY"VLC/"

series=$(cat $cdir"Config.txt" | head -n 1)
next_series=$(cat $cdir"next.txt" | head -n 1)


if [ "$series" = "$next_series" ];
then

season=$(cat $cdir"next.txt" | tail -n 1 | cut -d' ' -f1)

episode=$(cat $cdir"next.txt" | tail -n 1 | cut -d' ' -f2)

if [ $season -lt 10 ];
then
season_search="0$season"
else
season_search="$season"
fi

# count=$(ls "$(find /mnt/E/Entertainment/ /mnt/X/Entertainment/ -iname *"$series"*"s"*"$season_search"* -type d)" \
# | grep -E ".mp4|.mkv" | wc -l)

count=$(find /mnt/E/Entertainment/ /mnt/X/Entertainment/ -iname *"$series"*"s"*$season_search"E"* -type f | grep -E ".mp4|.mkv" | wc -l)

if [ "$1" = "n" ];
then
episode=$(( episode + 1 ))

echo $episode

if [ $episode -gt $count ];
then

season=$(( season + 1 ))

episode=1

fi

elif [ "$1" = "p" ];
then
episode=$(( episode - 1 ))

if [ $episode -lt 0 ];
then

season=$(( season - 1 ))

fi


fi

else

season=$(cat $cdir"Config.txt" | tail -n 1 | cut -d' ' -f1)

episode=$(cat $cdir"Config.txt" | tail -n 1 | cut -d' ' -f2)



fi


if [ $episode -lt 10 ];
then
episode_search="0$episode"
else
episode_search="$episode"
fi

echo series=$series
echo season=$season
echo episode=$episode

echo $series > $cdir"next.txt" 
echo "$season $episode" >> $cdir"next.txt" 
echo season_search=$season_search
echo episode=$episode
# -iname *"$series"*"s"*$season_search"E"*
item=$(find /mnt/E/Entertainment/ /mnt/X/Entertainment/ \
\( -iname *"$series"*"s"*$season_search"E"$episode_search*".mkv" -o \
-iname *"$series"*"s"*$season_search"E"$episode_search*".mp4" \) \
| head -n 1 ) 

echo item="$item"

wmctrl -c "$series"
xdg-open "$item" &
