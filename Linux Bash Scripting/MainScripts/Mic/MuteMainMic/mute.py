import os  
import subprocess

import sys

m = int(sys.argv[1])


comm = "pactl list short sources"

encoding = 'utf-8'
sources = subprocess.check_output(comm, shell=True)
sources_ls = str(sources, encoding).splitlines()

src = [x.split()[1] for x in sources_ls if not('monitor' in x)]

un_mute = "pactl set-source-mute {} {}"


for k in src:
    os.system(un_mute.format(k, m))


if m == 1:
    mess = 'timeout 1 gxmessage -center -timeout 1 -borderless -geometry 500x200 -fn "serif italic 20" -bg red "Mic is Muted"'
else:
    mess = 'timeout 1 gxmessage -center -timeout 1 -borderless -geometry 500x200 -fn "serif italic 20" -bg green "Mic is on"'


os.system(mess)