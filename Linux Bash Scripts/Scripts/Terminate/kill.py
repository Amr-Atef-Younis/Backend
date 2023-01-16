import os
import subprocess


inp='zenity --entry --entry-text="xbindkeys" --text="Name of the app to Kill"'





encoding = 'utf-8'
app = subprocess.check_output(inp, shell=True)
app = str(app, encoding).splitlines()[0]
if app != 'xbindkeys':
    app2kill = app[0].upper() + app[1:]

# test = f'wmctrl -l | grep {app2kill}'

# print(app2kill)

kill = f'pkill {app2kill}'

print(kill)

os.system(kill)

comm = f'zenity --entry --entry-text={app} --text="Name of the app to launch"'

out = subprocess.check_output(comm, shell=True)
out = str(out, encoding).splitlines()[0]

if out == 'spotify':
    launch = 'env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify %U'
else:
    check_comm = f'ls /usr/bin/ | grep {out}'

    check = subprocess.check_output(check_comm, shell=True)
    check = str(check, encoding).splitlines()[0]

    launch = f'/usr/bin/{check}'

# print(launch)

os.system(launch)
