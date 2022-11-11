import os


Sudocomm = 'echo %s|sudo -S %s'
password = 'pass'

umountF = 'umount /dev/sda4'
umountE = 'umount /dev/sda3'

ntfsfixF = 'ntfsfix /dev/sda4'
ntfsfixE = 'ntfsfix /dev/sda3'


mountF = 'mount /dev/sda4'
mountE = 'mount /dev/sda3'

os.system(Sudocomm % (password, umountF))
os.system(Sudocomm % (password, umountE))

os.system(Sudocomm % (password, ntfsfixF))
os.system(Sudocomm % (password, ntfsfixE))

os.system(Sudocomm % (password, mountF))
os.system(Sudocomm % (password, mountE))
