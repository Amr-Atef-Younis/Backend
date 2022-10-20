import os
import sys

os.system('pactl list short sink-inputs > /mnt/F/Scripts/DefaultOutputDevice/All/apps.txt')
os.system('pactl list short sinks > /mnt/F/Scripts/DefaultOutputDevice/All/devices.txt')

apps = open('/mnt/F/Scripts/DefaultOutputDevice/All/apps.txt')

devices = open('/mnt/F/Scripts/DefaultOutputDevice/All/devices.txt')

num = int(sys.argv[1])


choice = ""

if num == 1:
    choice = 'hdmi'
elif num == 2:
    choice = 'usb'
else:
    choice = '.pci'

app_ls = []
devices_dict = dict()

default_dev = ""

available = ['hdmi', 'usb', '.pci']

hdmi = ""
usb = ""
headphone = ""

for line in apps:
    k = line.split('\t')[0]
    app_ls.append(k)

for line in devices:
    k = line.split('\t')
    if "hdmi" in k[1]:
        hdmi = k[0]
        if choice in k[1]:
            default_dev = k[1]
    elif "USB" in k[1]:
        if choice in k[1]:
            default_dev = k[1]
        usb = k[0]
    elif 'analog-stereo' in k[1] and '.pci' in k[1]:
        if choice in k[1]:
            default_dev = k[1]
        headphone = k[0]

devices_idx = [hdmi, usb, headphone]



for i,k in zip(available, devices_idx):
    devices_dict[i] = k



change2 = devices_dict[choice]

if change2 == "":
    quit()

comm = 'pactl move-sink-input {}'

comm2 = 'pactl set-default-sink {}'.format(default_dev)

for i in app_ls:
    final_comm = comm.format(str(i)+ ' '+ str(change2))
    os.system(final_comm)
os.system(comm2)
