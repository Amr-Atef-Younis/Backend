#!/bin/sh


#sleep 52

#xdotool search --name "automate the boring stuff with python.pdf" set_desktop_for_window %@ 3 

#!/bin/bash

variable=""
variable=$(wmctrl -l | grep "automate the boring stuff with python.pdf")





while [ "$variable" == "" ] 
do


variable=$(wmctrl -l | grep "automate the boring stuff with python.pdf")


done

xdotool search --name "automate the boring stuff with python.pdf" set_desktop_for_window %@ 3 

