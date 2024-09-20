import os

passw = os.environ['PASSWORD']

comm = 'echo {}| sudo -S {}'

r = '${SCRIPTS_DIRECTORY}NetworkProblems/Network.sh'

os.system(comm.format(passw,r))
