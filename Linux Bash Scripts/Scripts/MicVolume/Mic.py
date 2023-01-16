import os
import sys
import subprocess

encoding = 'utf-8'


# path = '/mnt/F/Scripts/MicVolume/on.txt'
# os.system('pgrep -u amr MicVolume.sh > /mnt/F/Scripts/MicVolume/on.txt')

basiccomm = 'pgrep -u amr MicVolume.sh'

try:
    pg = subprocess.check_output(basiccomm, shell=True)
    print(pg)
except:
    pg = ''



comm2 = 'bash /mnt/F/Scripts/MicVolume/MicVolume.sh &'





# with open(path, 'r') as f:
#     y = f.readlines()

# try:
#     on = y[0].split('\n')[0]
# except:
#     pass
if pg != '':
    comm = 'kill -9 ' + str(pg)
    os.system(comm)

os.system(comm2)

