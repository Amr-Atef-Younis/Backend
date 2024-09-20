#!/bin/bash


applications25=( timeshift )
applications50=( notion-app brave-browser )


for app in ${applications25[@]};
do
	cpulimit -e "${app}" --limit 25 -b &
done


for app in ${applications50[@]};
do
	cpulimit -e "${app}" --limit 50 -b &
done
