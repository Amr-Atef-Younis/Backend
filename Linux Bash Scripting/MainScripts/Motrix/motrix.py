#!/usr/bin/env python
# coding: utf-8

# In[62]:


import os
import sys

# In[ ]:


os.system('xdotool search --onlyvisible --name motrix > ${SCRIPTS_DIRECTORY}Motrix/visible.txt')
os.system('xdotool search --name motrix > ${SCRIPTS_DIRECTORY}Motrix/check.txt')


# In[63]:


path1 = '${SCRIPTS_DIRECTORY}Motrix/visible.txt'
path2 = '${SCRIPTS_DIRECTORY}Motrix/check.txt'
visible = open('${SCRIPTS_DIRECTORY}Motrix/visible.txt', 'r')
check = open('${SCRIPTS_DIRECTORY}Motrix/check.txt', 'r')
visr = open('${SCRIPTS_DIRECTORY}Motrix/vis.txt', 'r')
#visw = open('${SCRIPTS_DIRECTORY}Motrix/vis.txt', 'w')


# In[67]:


# visible 1 item


# In[58]:


show = 'xdotool windowmap {}; xdotool windowactivate {}'
hide = 'xdotool windowunmap {}'


# In[18]:


chpid = check.readlines()
print(chpid)

# In[54]:


ch_t = list(map(lambda x: x.split()[0], chpid))
op = True
try:
    vis_t = visible.readlines()[0].split()[0]
except:
	op = False


print(ch_t)



m = visr.readline()
print(m)

visr.close()
print('op = {}'.format(op))
if op:
	print('hide')
	final = hide.format(vis_t)
	visw = open('${SCRIPTS_DIRECTORY}Motrix/vis.txt', 'w')
	visw.write(vis_t)
elif m:
	if m in ch_t:
		print('match')
		final = show.format(m,m)
else:
	sys.exit()
        
        
print(final)
os.system(final)
        



