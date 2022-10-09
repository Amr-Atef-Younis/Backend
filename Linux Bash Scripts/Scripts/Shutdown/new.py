import os
import sys


kl = str(sys.argv[1])

print(kl)

passwd = 'pass'
basic = 'echo {} | sudo -S {}'
shut = 'shutdown -h 0'
rest = 'shutdown -r now'

f = 'source /etc/environment'

os.system(f)

if kl == 'r':
    os.system(basic.format(passwd,rest))
elif kl == 's':
    os.system(basic.format(passwd,shut))
    
