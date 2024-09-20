#!/bin/bash

source "${HELPERS_DIRECTORY}Notifications.sh"

commandsArray=("update" "upgrade -y" "autoremove -y")

for command in "${commandsArray[@]}"
	do
		echo "$PASSWORD" | sudo -S bash -c "apt $command"
	done
sendMobileNotification "Update Done on $(date)"
