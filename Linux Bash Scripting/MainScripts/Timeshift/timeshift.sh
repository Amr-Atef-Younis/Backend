#!/bin/bash

# notify-send -u critical "Starting Timeshift Backup now"
# notify-send -u critical "$PASSWORD"
echo "$PASSWORD" | sudo -S /usr/bin/timeshift --create &
cpulimit -e timeshift --limit 85 -b
