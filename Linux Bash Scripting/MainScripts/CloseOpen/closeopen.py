 
import os 
import sys
import subprocess

encoding = 'utf-8'

commands_file = "${SCRIPTS_DIRECTORY}CloseOpen/commands"

app = str(sys.argv[1])

# print(app)

basiccomm = 'wmctrl -pxl | grep -i "\.{}"'

try: 
    list_processes = subprocess.check_output(basiccomm.format(app), shell=True)
    list_processes = str(list_processes, encoding).splitlines()[0].split()
except: 
    list_processes = None

# list_processes = try:subprocess.check_output(basiccomm.format(app), shell=True).split() except:None

try: 
    relaunch =  subprocess.check_output(f'cat {commands_file} | grep -i {app}', shell=True)
    relaunch = str(relaunch, encoding).splitlines()[0]
except: 
    relaunch = None
# subprocess.check_output(f'cat {commands_file} | grep {app}', shell=True)

# print(list_processes)
# print(relaunch)

if list_processes:
    # app_title = ' '.join(list_processes[5:])
    # print(f'title = {app_title}')
    if not relaunch:
        relaunch = list_processes[3].split('.')[0] 
        save = os.system(f'echo {relaunch} >> {commands_file}')
    comm = f'wmctrl -ic {list_processes[0]}'
else:
    comm = f'{relaunch} &'


print(comm)

os.system(comm)

