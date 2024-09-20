#!/usr/bin/env python
# coding: utf-8

# In[62]:


import os
import sys

# In[ ]:


os.system(f'xdotool search --onlyvisible --classname "{sys.argv[1]}" > /mnt/F/Bosta/My_Scripts/Minimize/{sys.argv[1]}/visible.txt')
os.system(f'xdotool search --classname "{sys.argv[1]}" > /mnt/F/Bosta/My_Scripts/Minimize/{sys.argv[1]}/check.txt')


# In[63]:


path1 = f'/mnt/F/Bosta/My_Scripts/Minimize/{sys.argv[1]}/visible.txt'
path2 = f'/mnt/F/Bosta/My_Scripts/Minimize/{sys.argv[1]}/check.txt'
visible = open(f'/mnt/F/Bosta/My_Scripts/Minimize/{sys.argv[1]}/visible.txt', 'r')
check = open(f'/mnt/F/Bosta/My_Scripts/Minimize/{sys.argv[1]}/check.txt', 'r')
visr = open(f'/mnt/F/Bosta/My_Scripts/Minimize/{sys.argv[1]}/vis.txt', 'r')
#visw = open('/mnt/F/Bosta/My_Scripts/Minimize/{sys.argv[1]}/vis.txt', 'w')


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
        
        
if op:
	print('hide')
	final = hide.format(vis_t)
	os.system(f'echo "$(wmctrl -xlp | grep -i \'\.{sys.argv[1]}*\' | cut -d\' \' -f4)" > /mnt/F/Bosta/My_Scripts/Minimize/{sys.argv[1]}/wmctrl.txt')
	os.system(final)
	os.system(f"kill -STOP $(cat /mnt/F/Bosta/My_Scripts/Minimize/{sys.argv[1]}/wmctrl.txt)")
	visw = open(f'/mnt/F/Bosta/My_Scripts/Minimize/{sys.argv[1]}/vis.txt', 'w')
	visw.write(vis_t)
elif m:
	if m in ch_t:
		print('show')
		final = show.format(m,m)
		# os.system(f"{final}")
		os.system(f"{final} && kill -CONT $(cat /mnt/F/Bosta/My_Scripts/Minimize/{sys.argv[1]}/wmctrl.txt)")
		# os.system()
else:
	sys.exit()
        



