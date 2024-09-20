#!/bin/bash

function sendMobileNotification() {
	local message="$1"
	kdeconnect-cli --ping-msg "$message" --name "$MOBILE_NAME"
}

function sendDesktopNotifications() {
	local message="$1"
    local urgency="${2:-normal}"
    local timeout="${3:-5000}"
	notify-send -t $timeout -u "$urgency" "$message"
}

function displayDesktopMessage() {
	local message="$1"
    local timeout="${2:-5000}"  
    local color="${3:-yellow}"
    local fontSize="${4:-30}"
	gxmessage -noescape -timeout $timeout -center -sticky -ontop -borderless -fg "$color" -fn "serif italic $fontSize" "$message"
}
