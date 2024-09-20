#!/bin/bash

path="${BOSTA_DIRECTORY}My_Scripts/Extract Text/"

cd "$path"

directoryPath="$path""directory.txt"

# find . -not \( -name "." \) -type d | rev | cut -d"/" -f1 | rev > "$directoryPath"

find . -not \( -iname "*CODs*" -or -iname "*directory*" -or -iname "*Extract*" \) -type f -exec rm {} \;

x=$(zenity --list --text="Directories" --column="Select" --column="Data" --radiolist $(awk '{print ""$0""}' "$directoryPath") --width=300 --height=400)


function getUnique {
    cd "$newPath"
    items=$(find . -iname "temp*.txt" -type f)
    for item in $items;
        do
            filex=$(basename "$item")
            new_file="$(echo $filex | cut -c6-)"
            temp_unique="unique_$new_file"
            sort ./"$filex" | uniq -u > ./"$temp_unique"
            awk 'BEGIN {printf "["} {printf "%s\"%s\"", (NR > 1 ? ", " : ""), $0} END {print "]"}' ./$temp_unique > ./$new_file
        done
        find . \( -iname "temp*.txt" \) -type f -exec rm {} \;
#         -o -iname "unique*.txt"
}

case "$x" in

	"UpdateCOD")
		newPath=$path"$x"
		mkdir -p "$newPath"
		perl -nE '/Tracking Number: (\d+) from/ && print "$1\n"' ./CODs.txt | uniq > "$newPath"/temp_TNs.txt

		perl -nE '/- (\w+) updated/ && print "$1\n"' ./CODs.txt | uniq > "$newPath"/temp_BID.txt

		perl -nE '/User (\w+) with/ && print "$1\n"' ./CODs.txt | uniq  > "$newPath"/temp_UID.txt
    ;;
    
	"UpdateBankinfo")
		newPath=$path"$x"
		mkdir -p "$newPath"
		perl -nE '/- (\w+) tried/ && print "$1\n"' ./CODs.txt | uniq > ./"$newPath"/temp_BID.txt
		perl -nE '/User (\w+) with/ && print "$1\n"' ./CODs.txt | uniq  > ./"$newPath"/temp_UID.txt
    ;;

	"DeletingUsers")
		newPath=$path"$x"
		mkdir -p "$newPath"
		perl -nE '/User (\w+) with[\w\W]+com$/ && print "$1\n"' ./CODs.txt | uniq > ./"$newPath"/temp_deletedUID.txt
		perl -nE '/User (\w+) with[\w\W]+ from/ && print "$1\n"' ./CODs.txt | uniq > ./"$newPath"/temp_UID.txt
		perl -nE '/User \w+ with mail ([\w\W]+) from/ && print "$1\n"' ./CODs.txt | uniq > ./temp_emails.txt
    ;;
    
    "FailedRecharge")
		newPath=$path"$x"
		mkdir -p "$newPath"
		perl -0777 -nE 'print "$1\n" while /, (\w+)\nYour Account Is Locked/g' ./CODs.txt | uniq > "$newPath"/temp_trackingNumbers.txt
    ;;
    
	"FailedDelivery")
		newPath=$path"$x"
		mkdir -p "$newPath"
		perl -nE '/delivery (\d+) to/ && print "$1\n"' ./CODs.txt | uniq > "$newPath"/temp_trackingNumbers.txt
    
    ;;
    "Ips")
		newPath=$path"$x"
		mkdir -p "$newPath"
		perl -nE '/IP: ([\d.]+)/ && print "$1\n"' ./CODs.txt | uniq > "$newPath"/temp_Ips.txt
esac

getUnique




# cd "$newPath"
# 
# items=$(find . -iname "temp*.txt" -type f)
# 
# for item in $items;
# do
# 
# filex=$(basename "$item")
# 
# if [ "$filex" != "CODs.txt" ];
# then
# new_file="$(echo $filex | cut -c6-)"
# sed -E 's/(OR\W+|,\W?)$//g' "$item" > "./$new_file"
# rm "$item"
# fi
# done
