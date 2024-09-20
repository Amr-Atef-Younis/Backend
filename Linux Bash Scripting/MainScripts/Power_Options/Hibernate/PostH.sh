#! /usr/bin/env python

import os
import time

passwd = os.environ['PASSWORD']
basic = 'echo {} | sudo -S {} -a'

comms = ['swapoff', 'swapon']


os.system("killall vlc")
os.system("killall spotify")

time.sleep(120)

for comm in comms:
    os.system(basic.format(passwd,comm))
    time.sleep(20)
