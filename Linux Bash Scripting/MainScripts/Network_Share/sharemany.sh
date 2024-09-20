#!/bin/bash

source "${HELPERS_DIRECTORY}Notifications.sh"

file_path=$SCRIPTS_DIRECTORY"Network_Share/Folders.txt"
retryTime=5
port="$(zenity --entry --entry-text="45454" --text="Port")"; checkEmpty $port

case "$1" in 
	"receiver")
		mkdir -vp $MY_HOME/installs/
		Destination="$(zenity --entry --entry-text="$MY_HOME/installs/"  --text="Destination")"; checkEmpty $Destination
		{ read numberOfTransfers; } < <(nc -q $retryTime -l -p $port)
		cd "$Destination"
		while true; 
			do
				nc -l -p $port | uncompress -c | tar xfp -
				((i++))
				if [ "$i" -ge "$numberOfTransfers" ]; then
					break
				fi
			done
		pid=$(lsof -t -i :$port)
		kill $pid
		;;
	"sender")
		kate "$file_path"
		readarray -t files < "$file_path"
		ipAddress="$(zenity --entry --entry-text="10.0.0.9" --text="Receiver's IP address")"; checkEmpty $ipAddress
		echo ${#files[@]} | nc -q 1 $ipAddress $port
		sed -i 's!file://!!g' $file_path
		for item in "${files[@]}"; do
			notify-send "Sending file $item"
			dir="$(dirname "$item")"
			cd "$dir"
			shared="$(basename "$item")"
			sleep 1
			tar cfp - "$shared" | compress -c | nc -q 1 $ipAddress $port
			echo "Completed sending file $i"
		done
		sendMobileNotification "Transfer was done successfully for ${files[@]}"
		;;
	 *)
		exit
		;;
esac
