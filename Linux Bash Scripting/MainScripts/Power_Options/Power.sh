#!/bin/bash

# path=$SCRIPTS_DIRECTORY"Power_Options/Change_files_permissions.py"
# python3 "$path"

echo "$PASSWORD" | sudo -S chmod 777 /sys/power/state
echo "$PASSWORD" | sudo -S chmod 777 /sys/power/disk

while getopts ':sohpr' OPTION; do
  case $OPTION in
    s)
      statearg="mem"
	  diskarg="suspend"
      ;;
    o)
      statearg="disk"
	  diskarg="platform"
      ;;
	h)
      statearg="disk"
	  diskarg="shutdown"
      ;;
	p)
	  python3 $SCRIPTS_DIRECTORY"Power_Options/Power.py" p
	  ;;
	r)
	  python3 $SCRIPTS_DIRECTORY"Power_Options/Power.py" r
	  exit
	  ;;
    *)
      exit 
      ;;
  esac
done

echo $diskarg  > /sys/power/disk
echo $statearg > /sys/power/state
