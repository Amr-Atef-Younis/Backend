import os
import sys


kl = str(sys.argv[1])

# print(kl)

passwd = os.environ['PASSWORD']
# print(passwd)
basic = 'echo "{}" | sudo -S systemctl {} '


comms = {"r": "reboot",
         "p": "poweroff",
         "s": "suspend",
         "h": "hibernate",
         "o": "hybrid-sleep",
}

os.system(basic.format(passwd,comms[kl]))
    
