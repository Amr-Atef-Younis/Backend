import os

#comm = 'sensors > ${SCRIPTS_DIRECTORY}Temperature/Temperature.txt'

full = 'echo {} | sudo -S {}'

pas = os.environ['PASSWORD']

#os.system(full.format(pas, comm))

ru = 'bash ${SCRIPTS_DIRECTORY}Temperature/Temperature.sh'

os.system(full.format(pas,ru))

#re = "gedit '${SCRIPTS_DIRECTORY}Temperature/fin.txt'"

#os.system(re)
