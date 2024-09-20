#!/usr/bin/env python
# coding: utf-8

# In[62]:


import os
import sys

# In[ ]:


os.system('xdotool search --onlyvisible --class thunderbird > /mnt/F/Bosta/My_Scripts/Minimize/thunderbird/visible.txt')
os.system('xdotool search --class thunderbird > /mnt/F/Bosta/My_Scripts/Minimize/thunderbird/check.txt')


# In[63]:


path1 = '/mnt/F/Bosta/My_Scripts/Minimize/thunderbird/visible.txt'
path2 = '/mnt/F/Bosta/My_Scripts/Minimize/thunderbird/check.txt'
visible = open('/mnt/F/Bosta/My_Scripts/Minimize/thunderbird/visible.txt', 'r')
check = open('/mnt/F/Bosta/My_Scripts/Minimize/thunderbird/check.txt', 'r')
visr = open('/mnt/F/Bosta/My_Scripts/Minimize/thunderbird/vis.txt', 'r')
#visw = open('/mnt/F/Bosta/My_Scripts/Minimize/thunderbird/vis.txt', 'w')


# In[67]:


# visible 1 item


# In[58]:


show = 'xdotool windowmap {}; xdotool windowactivate {}'
hide = 'xdotool windowunmap {}'


# In[18]:


chpid = check.readlines()


# In[54]:


ch_t = list(map(lambda x: x.split()[0], chpid))
op = True
try:
    vis_t = visible.readlines()[0].split()[0]
except:
	op = False






m = visr.readline()


visr.close()

if op:
	
	final = hide.format(vis_t)
	visw = open('/mnt/F/Bosta/My_Scripts/Minimize/thunderbird/vis.txt', 'w')
	visw.write(vis_t)
elif m:
	if m in ch_t:
		
		final = show.format(m,m)
else:
	sys.exit()
        
        

os.system(final)
        



