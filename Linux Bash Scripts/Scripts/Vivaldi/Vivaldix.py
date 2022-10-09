#!/usr/bin/env python
# coding: utf-8

# In[3]:


import os
import sys


# In[ ]:


p = 'Profile '
comm = 'vivaldi-stable --profile-directory={} --new-window &'

inp = str(sys.argv[1])





match inp:
    case 'l':
        os.system(comm.format('Main'))
    case 'm':
        os.system(comm.format(p+'1'))
    case 'g':
        os.system(comm.format(p+'2'))
    case 't':
        os.system(comm.format(p+'3'))
    case 'c':
        os.system(comm.format(p+'4'))
