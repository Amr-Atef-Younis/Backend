import os
import sys


passwd = os.environ['PASSWORD']
basic = 'echo {} | sudo -S {}'
hiber = 'pm-hibernate'


os.system(basic.format(passwd,hiber))
    
