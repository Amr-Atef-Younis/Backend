#!/usr/bin/env python
# coding: utf-8

# In[62]:


import os
import sys

# In[ ]:


os.system('xdotool search --onlyvisible --class discord > ${SCRIPTS_DIRECTORY}Discord/visible.txt')
os.system('xdotool search --class discord > ${SCRIPTS_DIRECTORY}Discord/check.txt')


# In[63]:


path1 = '${SCRIPTS_DIRECTORY}Discord/visible.txt'
path2 = '${SCRIPTS_DIRECTORY}Discord/check.txt'
visible = open('${SCRIPTS_DIRECTORY}Discord/visible.txt', 'r')
check = open('${SCRIPTS_DIRECTORY}Discord/check.txt', 'r')
visr = open('${SCRIPTS_DIRECTORY}Discord/vis.txt', 'r')
#visw = open('${SCRIPTS_DIRECTORY}Discord/vis.txt', 'w')


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
	visw = open('${SCRIPTS_DIRECTORY}Discord/vis.txt', 'w')
	visw.write(vis_t)
elif m:
	if m in ch_t:
		final = show.format(m,m)
else:
	sys.exit()
        
        
os.system(final)
        



