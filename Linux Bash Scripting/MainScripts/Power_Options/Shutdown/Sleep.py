import os
import sys


passwd = os.environ['PASSWORD']
basic = 'echo {} | sudo -S {}'
sleep = 'systemctl suspend'

os.system("pkill vlc")
os.system(basic.format(passwd,sleep))
    
