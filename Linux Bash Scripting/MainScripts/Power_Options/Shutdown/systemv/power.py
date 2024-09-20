import os
import sys


req = sys.argv[1]



passwd = os.environ['PASSWORD']
basic = 'echo {} | sudo -S {}'

cmd_ls = ['pm-suspend', 'pm-hibernate', 'shutdown -h now', 'shutdown -r now']#, 'pm-suspend-hybrid --quirk-dpms-on --quirk-vbe-post']

cmd_st = ['Sleep', 'Hibernate', 'Shutdown', 'Restart']

cmd_dict = {}

for cmd, st in zip(cmd_ls, cmd_st):
    cmd_dict[st] = cmd

os.system(basic.format(passwd,cmd_dict[req]))