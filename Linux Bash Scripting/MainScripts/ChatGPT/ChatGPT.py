#!/usr/bin/env python
# coding: utf-8

# In[62]:


import os
import sys

# In[ ]:

os.system(f'echo "$(wmctrl -xlp | grep -i ChatGPT | grep -i ".chromium" | cut -d\' \' -f4)" > ${SCRIPTS_DIRECTORY}ChatGPT/wmctrl.txt')

os.system('xdotool search --onlyvisible --name "ChatGPT" > ${SCRIPTS_DIRECTORY}ChatGPT/visible.txt')
os.system('xdotool search --name "ChatGPT" > ${SCRIPTS_DIRECTORY}ChatGPT/check.txt')


# In[63]:


path1 = '${SCRIPTS_DIRECTORY}ChatGPT/visible.txt'
path2 = '${SCRIPTS_DIRECTORY}ChatGPT/check.txt'
visible = open('${SCRIPTS_DIRECTORY}ChatGPT/visible.txt', 'r')
check = open('${SCRIPTS_DIRECTORY}ChatGPT/check.txt', 'r')
visr = open('${SCRIPTS_DIRECTORY}ChatGPT/vis.txt', 'r')
#visw = open('${SCRIPTS_DIRECTORY}ChatGPT/vis.txt', 'w')


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
    os.system(f'echo "$(wmctrl -xlp | grep -i ChatGPT | grep -i ".chromium" | cut -d\' \' -f4)" > ${SCRIPTS_DIRECTORY}ChatGPT/wmctrl.txt')
    os.system(final)
    os.system(f"kill -STOP $(cat ${SCRIPTS_DIRECTORY}ChatGPT/wmctrl.txt)")
    visw = open(f'${SCRIPTS_DIRECTORY}ChatGPT/vis.txt', 'w')
    visw.write(vis_t)
elif m:
    if m in ch_t:
        final = show.format(m,m)
        os.system(f"{final} && kill -CONT $(cat ${SCRIPTS_DIRECTORY}ChatGPT/wmctrl.txt)")
else:
    sys.exit()


