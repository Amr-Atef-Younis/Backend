 
import os 
import sys
import subprocess

encoding = 'utf-8'

app = str(sys.argv[1])

# if app == 'torrent':
#     filex = '/mnt/F/Scripts/Bitwarden/qtorrent.txt'
#     app2s = 'qbittorrent'
# else:
#     filex = '/mnt/F/Scripts/Bitwarden/bitwarden'
#     app2s = 'bitwarden'

basiccomm = f'xdotool search --onlyvisible --name {app}'

try:
    comm = subprocess.check_output(basiccomm, shell=True)
    final_comm = f'wmctrl -c {app}'
except:
    final_comm = app

os.system(final_comm)