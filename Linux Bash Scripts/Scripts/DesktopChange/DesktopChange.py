import os
import sys

os.system('xdotool get_desktop > /mnt/F/Scripts/DesktopChange/text.txt')

#comm = ' xdotool set_desktop {}; {} & sleep 0.4; {}'

comm = ' xdotool set_desktop {}; {}'


ns = 'notify-send Desktop {}'

show = 'gxmessage -geometry 240x120-960-540 -timeout 1 -borderless  -fn "serif italic 30" "Desktop {}"'

esc = 'xdotool key Escape'

da = int(sys.argv[1])
da_r = str(da)
dx = str(da - 1)

f = open('/mnt/F/Scripts/DesktopChange/text.txt', 'r')

l = f.readline().split()[0]

if l != dx:
	#os.system(comm.format(dx,show.format(str(da)), esc))
	os.system(comm.format(dx, ns.format(da_r)))
