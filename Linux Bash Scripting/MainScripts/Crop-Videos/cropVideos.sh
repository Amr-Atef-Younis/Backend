#!/bin/bash

dest="$COURSES_DIRECTORY"

startTime="$(zenity --entry --text="Start time HH:MM:SS" --entry-text="00:00:10")"

endTime="$(zenity --entry --text="End time HH:MM:SS" --entry-text="00:00:10")"

echo "starTime=$startTime"
echo "endTime=$endTime"

if [ ! -z "$startTime" ];
then
start=" -ss $startTime "
else
start=""
fi

if [ ! -z "$endTime" ];
then
end=" -to $endTime "
else
end=""
fi

echo "start=$start"
echo "end=$end"

inputFile="$(zenity --file-selection --filename="$dest")"

if [ -z "$inputFile" ];
then
exit
fi

format="$(echo $inputFile | rev | cut -d '.' -f1 | rev)"
fileName="$(echo $(basename "$inputFile") | cut -d '.' -f1 )"

echo "fileName=$fileName"


mainDir="$(dirname "$inputFile")"

tempFile="$mainDir/$fileName-temp.$format"
# echo "mv \"$inputFile\" \"$mainDir/$fileName-temp.$format\""
mv "$inputFile" "$tempFile"

cd "$mainDir"



# outputFile="-c copy $(zenity --entry --text="Output file name").$format"
# outputFile="$inputFile"

command="ffmpeg -i \"$tempFile\"$start$end -c copy \"$inputFile\""

echo "command=$command"
eval "$command"

rm "$tempFile"
