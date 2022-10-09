import os

#comm = 'sensors > /mnt/F/Scripts/Temperature/Temperature.txt'

full = 'echo {} | sudo -S {}'

pas = 'pass'

#os.system(full.format(pas, comm))

ru = 'bash /mnt/F/Scripts/Temperature/Temperature.sh'

os.system(full.format(pas,ru))

re = "gedit '/mnt/F/Scripts/Temperature/fin.txt'"

os.system(re)
