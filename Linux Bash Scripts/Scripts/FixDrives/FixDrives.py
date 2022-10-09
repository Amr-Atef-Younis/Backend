import os


Sudocomm = 'echo %s|sudo -S %s'
password = 'pass'

umountF = 'umount /dev/sda1'
umountE = 'umount /dev/sda2'

ntfsfixF = 'ntfsfix /dev/sda1'
ntfsfixE = 'ntfsfix /dev/sda2'


mountF = 'mount /dev/sda1'
mountE = 'mount /dev/sda2'


umountD = 'umount /dev/sdb1'
umountTSN = 'umount /dev/sdb2'

ntfsfixD = 'ntfsfix /dev/sdb1'
ntfsfixTSN = 'ntfsfix /dev/sdb2'


mountD = 'mount /dev/sdb1'
mountTSN = 'mount /dev/sdb2'


os.system(Sudocomm % (password, umountF))
os.system(Sudocomm % (password, umountE))

os.system(Sudocomm % (password, ntfsfixF))
os.system(Sudocomm % (password, ntfsfixE))

os.system(Sudocomm % (password, mountF))
os.system(Sudocomm % (password, mountE))


os.system(Sudocomm % (password, umountD))
os.system(Sudocomm % (password, umountTSN))

os.system(Sudocomm % (password, ntfsfixD))
os.system(Sudocomm % (password, ntfsfixTSN))

os.system(Sudocomm % (password, mountTSN))
os.system(Sudocomm % (password, mountD))
