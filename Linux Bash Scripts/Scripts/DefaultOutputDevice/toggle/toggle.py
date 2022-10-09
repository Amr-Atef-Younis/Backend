#!/usr/bin/env python
import os


os.system('dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause')

os.system("pactl list short sinks > /mnt/F/Scripts/DefaultOutputDevice/toggle/text.txt")

os.system('dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause')

path = '/mnt/F/Scripts/DefaultOutputDevice/toggle/text.txt'

comm = 'pactl set-default-sink '


with open(path, 'r') as f:
    x = f.read().splitlines()


f = 0
run = -1

devices = []
HS = False

for w in x:
    k = w.split('\t')
    op = k[1]
    if 'hdmi' in op:
        print('hi')
        devices.append(op)
        hd = op
        f += 1
        if 'RUNNING' in w:
            run = 1
    elif 'analog-stereo' in op and '.pci' in op:
        f += 1
        devices.append(op)
        HS = True
        if 'RUNNING' in w:
            run = 0
    elif 'USB_Audio_Device' in op:
        f += 1
        devices.append(op)
        if 'RUNNING' in w:
            run = 2
    if f == 3:
        break

print(run)
print(devices)
devices.sort()


if f == 2 and HS:
    Nrun = int((run+1)%2)
elif f == 2 and not HS:
    if run == 2:
        Nrun = 0
    else:
        Nrun = 1
else:
    Nrun = run + 1
    if Nrun == 3:
        Nrun = 0

if run == -1:
    fcomm = comm + devices[0]
else:
    fcomm = comm + devices[Nrun]

print(fcomm)

os.system('{}'.format(fcomm))
