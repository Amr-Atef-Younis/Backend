#!/bin/bash

dest="$MY_HOME/Videos/"

if [ "$1" = "d" ];
then
# cb_zen=$(zenity --entry --text="Pattern for directory")

# CorS=$(echo $cb_zen | rev | cut -c1)
cb_final=$(zenity --entry --text="Pattern for directory")
# cb_final=$(echo $cb_zen | rev | cut -c3- | rev)
[ -z "$cb_final" ] && exit

item=$(echo "$cb_final" | sed 's/ /\*/g')


# if [ "$CorS" = "S" ];
# then
# final_item=$(find /mnt/E/Entertainment/ /mnt/X/Entertainment/ -iname *"$item"* -type d | head -n 1)
# else
path="$COURSES_DIRECTORY"
# echo "find \"$path\" -iname *\"$item\"* -type d"
# find "$path" -maxdepth 2 -iname *"$item"* -type d
final_item=$(find "$path" -maxdepth 4 -iname *"$item"* -type d | head -n 1)
echo $final_item
# fi


elif [ "$1" = "f" ];
then

# cb_zen=$(zenity --entry --text="Pattern for file")

cb_final=$(zenity --entry --text="Pattern for file")
[ -z "$cb_final" ] && exit
# CorS=$(echo $cb_zen | rev | cut -c1)

# cb_final=$(echo $cb_zen | rev | cut -c3- | rev)

item=$(echo "$cb_final" | sed 's/ /\*/g')

# if [ "$CorS" = "S" ];
# then
# final_item=$(find /mnt/E/Entertainment/ /mnt/X/Entertainment/ \( -iname *"$item"*.mp4 -o -iname *"$item"*.mkv -o -iname *"$item"*.avi \) -type f | head -n 1)
# else
path="$COURSES_DIRECTORY"
final_item="$(find "$path" \( -iname *"$item"*.mp4 -o -iname *"$item"*.mkv \) -type f | head -n 1)"
# fi

else
cb=$(xsel -b | tr '' '\n')
final_item=$(echo $cb | cut -c 8-)
ext=$(echo $cb | rev | cut -c1-4 | rev)
if [ "$ext" = ".pdf" ] || [ "$ext" = ".png" ] || [ "$ext" = ".txt" ];
then
dest="$MY_HOME/Desktop/"
fi

fi
# echo $final_item
# echo $ext
# echo $dest
ln -sr "$final_item" -t $dest
