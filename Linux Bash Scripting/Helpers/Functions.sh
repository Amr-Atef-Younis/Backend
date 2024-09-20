#!/bin/bash

function exitIfEmpty() {
	local check="$1"
	if [ -z "$check" ];
		then
			echo "Exiting!"
			exit
		fi
}

function zenityQuestion() {
	local message="$1"
	local timeout="${2:-3}"
	$(zenity --question --text="$message" --timeout $timeout)
	if [ $? -eq 0 ];
		then
			echo "Exiting!"
			exit
		fi
}

function exitIfNotEmpty() {
	local check="$1"
	if [ ! -z "$check" ];
		then
			echo "Exiting!"
			exit
		fi
}

function checkEmptyAssignDefault() {
	local check="$1"
	local valueIfNotEmpty="$2"
	local valueIfEmpty="$3"
	if [ ! -z "$check" ]; then
		echo "$valueIfNotEmpty"
	else
		echo "$valueIfEmpty"
	fi
}

function assignIfTrueElse() {
	local check="$1"
	local ifTrue="$2"
	local ifFalse="$3"
	if [ "$check" = true ]; then
		echo "$ifTrue"
	else
		echo "$ifFalse"
	fi
}


function openFileIntoArray() {
	local file_path="$1"
	gedit "$file_path"
	sed -i 's!file://!!g' "$file_path"
}
