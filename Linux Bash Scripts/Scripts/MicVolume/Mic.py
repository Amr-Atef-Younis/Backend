import os

path = '/mnt/F/Scripts/MicVolume/on.txt'
os.system('pgrep -u amr MicVolume.sh > /mnt/F/Scripts/MicVolume/on.txt')

on = ''

comm2 = '/mnt/F/Scripts/MicVolume/MicVolume.sh &'

with open(path, 'r') as f:
    y = f.readlines()

try:
    on = y[0].split('\n')[0]
except:
    pass
if on != '':
    comm = 'kill -9 ' + str(on)
    os.system(comm)

os.system(comm2)

