#!/bin/bash

path="$BOSTA_DIRECTORY/Routine/$(date '+%m %B')/"

find "$BOSTA_DIRECTORY/Routine/" -type d -exec rm -d "{}" \; > /dev/null 2>&1

today="$(date '+%d %A')"

new_path="$path$today/"
mkdir -p "$new_path"
