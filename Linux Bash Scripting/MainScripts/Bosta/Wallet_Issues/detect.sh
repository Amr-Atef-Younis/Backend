#!/bin/bash

. /mnt/D/Anaconda/bin/activate

path="$BOSTA_DIRECTORY/Routine/$(date '+%m %B')/"
downloads="$BOSTA_DIRECTORY/Downloads/"
python_script="$BOSTA_DIRECTORY/My_Scripts/Wallet_Issues/wallet_issues.py"

today="$(date '+%d %A')"

new_path="$path$today/"
mkdir -p "$new_path"

while true
# [ $(date +%H) -le 19 ]
do

x=$(ls $downloads | grep ".xlsx"| head -n 1)
source="$downloads$x"

if [ -z "$x" ];
then
continue
else


final_balance="$(zenity --entry --text="final Balance")"
if [ "$final_balance" != "" ];
then
name=$(zenity --entry --text="business ID")

if [ -z "$name" ];
then
continue
else
final_path="$new_path$name/"

mkdir -p "$final_path"

mv "$source" "$final_path$name.xlsx"

destination="$final_path$name.xlsx"

python3 $python_script "$destination" "$final_balance" #> /dev/null 2>&1
# sleep 1
# kate -n "$final_path""out.log" & > /dev/null 2>&1

common="$final_path"
fi

else

name="$(zenity --entry --text="compensation ID")"
if [ -z "$name" ];
then
continue
else
final_path=$common"/Compensations/"

mkdir -p "$final_path"

mv "$source" "$final_path$name"".xlsx"

destination="$final_path""$name"".xlsx"
fi

fi

fi

sleep 1

done
