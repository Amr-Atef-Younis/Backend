import os
import subprocess

encoding = 'utf-8'

$PASSWORDword = os.environ['PASSWORD']

path = '${SCRIPTS_DIRECTORY}Poweroff_USB/hub-ctrl/'

file = "./hub-ctrl"

Sudocomm = 'cd "{}" && echo $PASSWORD |sudo -S {}'

command = "./hub-ctrl -H 1 -P 3 -p 0 && sleep 2 && ./hub-ctrl -H 1 -P 3 -p 1"

final_command = Sudocomm.format(path, command)

# final_command = Sudocomm.format(path, command)

# print(final_command)

os.system(final_command)