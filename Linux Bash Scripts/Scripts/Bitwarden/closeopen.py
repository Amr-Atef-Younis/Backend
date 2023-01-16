 
import os 
import sys
import subprocess

encoding = 'utf-8'

app = str(sys.argv[1])

if app == 'xdman':
    app = 'xdm'
    
basiccomm = f'xdotool search --onlyvisible --name {app}'

try:
    comm = subprocess.check_output(basiccomm, shell=True)
    final_comm = f'wmctrl -c {app}'
except:
    if app == 'xdm':
        final_comm = 'xdman'
    else:
        final_comm = app


os.system(final_comm)