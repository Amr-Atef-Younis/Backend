import os
import numpy as np


path = '/mnt/F/Scripts/Spotify/text2.txt'
current =  open(path, 'r')
lines = f.readline().splitlines()[0].split()
current.close()
pid =[]
for i in lines:
    pid.append(int(i))
pid1 = pid.copy()

#fpid = np.array(pid.copy())
#fpid = fpid.reshape(-1,1)
command = 'pidof spotify > /mnt/F/Scripts/Spotify/text3.txt'
while True:
    os.system('sleep 1')
    os.system(command)
    path2 = '/mnt/F/Scripts/Spotify/text3.txt'
    new = open(path2, 'r')
    lines = new.readline().splitlines()[0].split()

    pid =[]
    for i in lines:
        pid.append(int(i))


    pid2 = pid.copy()
    check = []
    for element in pid2:
        if element in pid1:
            continue
        else:
            check.append(element)
    print(check)
    if len(check) == 0:
        continue
    else:
        for i in check:
            comm3 = 'kill -9 ' + str(i)
            os.system(comm3)
        
    new.close()
