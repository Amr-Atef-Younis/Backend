#!/bin/bash

cb=$(xsel -b | tr '' '\n')


while getopts ':rs' OPTION; do
  case $OPTION in
    r)
	  #receive
	  cd "$cb"
	  nc -w 10 $special_ip 45454 | tar -xz
	  ;;
	s)
	  #send
	 item=$(zenity --entry --entry-text="$cb")
	  
	 check1=$(echo $item | rev | cut -d'/' -f1 | rev | cut -c1)
	 check2=$(echo $item | rev | cut -c1)
	 echo check2=$check2

	 if [ "$check1" = "*" ];
	 then

     cd /"$(echo $item | rev | cut -d'/' -f2- | rev)"
     item=$(echo $item | rev | cut -d'/' -f1 | rev | cut -c2-) 
	 
	 #echo "case 1"
	 #echo $item

	 tar -cz *"$item" | nc -q 10 -l -p 45454

	 elif [ "$check2"  = "/" ];
	 then
	 cd /"$(echo $item | rev | cut -d'/' -f3- | rev)"
	 #echo "case 2"
	 #echo $item


	 tar -cz ./"$(echo $item | rev | cut -d'/' -f2 | rev)" | nc -q 10 -l -p 45454

	 else

	 echo $item
	 echo "case 3"

	 cd /"$(echo $item | rev | cut -d'/' -f2- | rev)"


	 tar -cz "$(echo $item | rev | cut -d'/' -f1 | rev)" | nc -q 10 -l -p 45454


	 fi
	 ;;

	*)
	  exit 1
	  ;;
  esac
done
