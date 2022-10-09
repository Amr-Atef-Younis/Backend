import os
import sys


passwd = 'pass'
basic = 'echo {} | sudo -S {}'
hiber = 'pm-hibernate'


os.system(basic.format(passwd,hiber))
    
