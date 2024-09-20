import os
import sys


kl = str(sys.argv[1])

# print(kl)

passwd = os.environ['PASSWORD']
basic = 'echo {} | sudo -S {}'
# shut = 'sudo shutdown -Ph now'
shut = 'systemctl poweroff'
rest = 'systemctl reboot'

# f = 'source /etc/environment'

# os.system(f)

if kl == 'r':
    os.system(basic.format(passwd,rest))
elif kl == 's':
    os.system(basic.format(passwd,shut))
    
