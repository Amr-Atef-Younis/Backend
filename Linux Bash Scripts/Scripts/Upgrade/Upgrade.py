import os




passwd = 'pass'

comm1 = 'apt update'

comm2 = 'apt upgrade -y'

comm3 = 'apt autoremove -y'

Mcomm = 'echo {} | sudo -S {}'

f_comm1 = Mcomm.format(passwd, comm1)
f_comm2 = Mcomm.format(passwd, comm2)
f_comm3 = Mcomm.format(passwd, comm3)


os.system(f_comm1)
os.system(f_comm2)
os.system(f_comm3)
