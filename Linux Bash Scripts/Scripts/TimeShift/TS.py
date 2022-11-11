import os

Sudocomm = 'echo %s|sudo -S %s'
password = 'pass'


comm = 'timeshift-launcher'


os.system(Sudocomm % (password, comm))

