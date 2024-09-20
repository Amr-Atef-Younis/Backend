#!/bin/bash

source "${HELPERS_DIRECTORY}Functions.sh"

sleep 9

zenityQuestion "Do you wish to skip the applications ?" "3"
"${SCRIPTS_DIRECTORY}AutoStart/limitCpu.sh" &
"${SCRIPTS_DIRECTORY}AutoStart/StartApplications.sh" &

sleep 10
bash "${BOSTA_DIRECTORY}My_Scripts/Routine/Daily.sh" &

sleep 3
"${SCRIPTS_DIRECTORY}AutoStart/Extras.sh"

sleep 1m
"${SCRIPTS_DIRECTORY}Backup/backup_scripts.sh" &

sleep 3m
"${SCRIPTS_DIRECTORY}Upgrade/Upgrade.sh" &

exit
