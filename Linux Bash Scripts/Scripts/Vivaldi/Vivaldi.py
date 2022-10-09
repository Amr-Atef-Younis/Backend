#!/usr/bin/env python
# coding: utf-8

# In[3]:


import os
import sys




p = 'Profile '
comm = 'vivaldi-stable --profile-directory="{}" --new-window "http://google.com" &'
inp = str(sys.argv[1])





if inp == 'l':
    final = comm.format(p+'1')
    os.system(final)
elif inp == 'm':
    final = comm.format(p+'2')
    os.system(final)
elif inp == 'g':
    final = comm.format(p+'3')
    os.system(final)
elif inp == 'c':
    final = comm.format(p+'4')
    os.system(final)
elif inp == 'e':
    final = comm.format('Default')
    os.system(final)

#print(final)
