import os
import subprocess

encoding = 'utf-8'

$PASSWORDword = os.environ['PASSWORD']

path = '${SCRIPTS_DIRECTORY}Poweroff_USB/hub-ctrl/'

file = "./hub-ctrl"

Sudocomm = 'cd "{}" && echo $PASSWORD |sudo -S {}'

command1 = "./hub-ctrl -H 1 -P 3 -p 0"
command2 = "./hub-ctrl -H 1 -P 3 -p 1"
sleep = "sleep 2"

comms = [command1, sleep, command2]

# final_command = Sudocomm.format(path, command)

for comm in comms:
    os.system(Sudocomm.format(path, comm))