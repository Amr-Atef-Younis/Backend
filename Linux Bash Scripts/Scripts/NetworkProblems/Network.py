import os

passw = 'pass'

comm = 'echo {}| sudo -S {}'

r = '/mnt/F/Scripts/NetworkProblems/Network.sh'

os.system(comm.format(passw,r))
