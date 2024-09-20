#!/bin/bash


# python3 "$SCRIPTS_DIRECTORY"Power_Options/Change_files_permissions.py


while getopts ':sohpr' OPTION; do
  case $OPTION in
    s)
	  python3 "$SCRIPTS_DIRECTORY"Power_Options/Power.py s
      ;;
    o)
      python3 "$SCRIPTS_DIRECTORY"Power_Options/Power.py o
      ;;
	h)
	  python3 "$SCRIPTS_DIRECTORY"Power_Options/Power.py h
      ;;
	p)
	  python3 "$SCRIPTS_DIRECTORY"Power_Options/Power.py p
	  ;;
	r)
	  python3 "$SCRIPTS_DIRECTORY"Power_Options/Power.py r
	  ;;
    *)
      exit 1
      ;;
  esac
done

# echo $diskarg > /sys/power/disk
# echo $statearg > /sys/power/state
