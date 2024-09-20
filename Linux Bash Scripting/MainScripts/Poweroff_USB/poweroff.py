import os
import subprocess

encoding = 'utf-8'

$PASSWORDword = os.environ['PASSWORD']

path = '${SCRIPTS_DIRECTORY}Poweroff_USB/hub-ctrl'

file = "./hub-ctrl"

Sudocomm = 'cd "{}" && echo $PASSWORD |sudo -S {}'

command = "{} -H 3 -P 3 -p {}"

check_comm = f'{file} | grep -n 6'

check = subprocess.check_output(Sudocomm.format(path, check_comm), shell=True)
check = str(check, encoding).splitlines()[0] 
test = 'power' in check

print(check)
print(test)

sCommand = command.format(file, str(int(not test)))

final_command = Sudocomm.format(path, sCommand)

# print(final_command)

os.system(final_command)