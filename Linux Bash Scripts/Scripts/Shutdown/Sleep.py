import os
import sys


passwd = 'pass'
basic = 'echo {} | sudo -S {}'
sleep = 'systemctl suspend'

os.system("pkill vlc")
os.system(basic.format(passwd,sleep))
    
