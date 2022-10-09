#!/usr/bin/env python
# coding: utf-8

# In[62]:


import os
import sys

# In[ ]:


os.system('xdotool search --onlyvisible --class rambox > /mnt/F/Scripts/Rambox/visible.txt')
os.system('xdotool search --class rambox > /mnt/F/Scripts/Rambox/check.txt')


# In[63]:


path1 = '/mnt/F/Scripts/Rambox/visible.txt'
path2 = '/mnt/F/Scripts/Rambox/check.txt'
visible = open('/mnt/F/Scripts/Rambox/visible.txt', 'r')
check = open('/mnt/F/Scripts/Rambox/check.txt', 'r')
visr = open('/mnt/F/Scripts/Rambox/vis.txt', 'r')
#visw = open('/mnt/F/Scripts/Rambox/vis.txt', 'w')


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
	visw = open('/mnt/F/Scripts/Rambox/vis.txt', 'w')
	visw.write(vis_t)
elif m:
	if m in ch_t:
		final = show.format(m,m)
else:
	sys.exit()
        
        
os.system(final)
        



