import os
# import subprocess

Sudocomm = 'echo "{}" | sudo -S {}'
password = os.environ['PASSWORD']

path = '/sys/power/'

ls = ['state', 'disk']

chmod = 'chmod 777 {}'

for i in ls:
   
    mcomm = Sudocomm.format(password,chmod.format(path+i))
    # print(mcomm)
    os.system(mcomm)
