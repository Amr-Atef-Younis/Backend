#!/bin/bash


python3 "$SCRIPTS_DIRECTORY"Hibernate/hibernate.py


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
	  python3 "$SCRIPTS_DIRECTORY"Shutdown/new.py s
	  ;;
	r)
	  python3 "$SCRIPTS_DIRECTORY"Shutdown/new.py r
	  ;;
    *)
      exit 1
      ;;
  esac
done

# echo $statearg
# echo $diskarg


echo $diskarg > /sys/power/disk
echo $statearg > /sys/power/state
