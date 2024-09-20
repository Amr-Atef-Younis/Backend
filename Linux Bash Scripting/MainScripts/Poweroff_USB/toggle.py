import os
import subprocess
import time

encoding = 'utf-8'

$PASSWORDword = os.environ['PASSWORD']

path = '$SCRIPTS_DIRECTORY"Poweroff_USB/hub-ctrl"'

file = "./hub-ctrl"


port = 4
Sudocomm = 'cd "{}" && echo $PASSWORD |sudo -S {}'

command = f"{file} -H 3 -P {port} -p "

check_comm = f'{file} | grep -i "high-speed connect"'

try:
    check = subprocess.check_output(Sudocomm.format(path, check_comm), shell=True)
    check = str(check, encoding).splitlines()[0]
    test = f'Port  {port}' in check
    state = str(int(not test))
except:
    state = "1"

# command = command.format(file, "0")

# tempCommand = command + "0" + " && sleep 2 && " + command + "1"

finalCommand1 = Sudocomm.format(path, command + state)
# finalCommand2 = Sudocomm.format(path, command + "1")

print(finalCommand1)
# print(finalCommand2)

# print(final_command)

os.system(finalCommand1)
# time.sleep(2)
# os.system(finalCommand2)