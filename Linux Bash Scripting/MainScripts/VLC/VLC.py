#!/usr/bin/env python
# coding: utf-8



# In[600]:

import sys
import os
import re
import numpy as np






def getEfolder(path, season):
	folders = os.listdir(path)
	folders.sort()
	pattern = '[Ss]eason[.\s]+(\d{1})'
    
	for fp in folders:
		# print('fp ',fp)
		if len(fp) == 1:
			if fp == season:
				fns = fp
				print(season + '\n')
				break
		else:
			ch = re.findall(pattern, fp)
			if ch:
				if ch[0] == season:
					fns = fp
					break
			
	files = os.listdir(path + fns)
	files.sort()

	print('getEfolder: \t fns: {}'.format(fns))

	return fns, files


# In[602]:


def Finalname(files, Episode):
    # print('Finalname ', files)
    # print('Episode FN ', Episode)
    pattern = '\d{2}[eE]{1}\d{2}'

    for i in files:
        ch = re.findall(pattern,i)
        print("ch: {}".format(ch))
        if ch == []:
            continue
        else:
            x = ch[0]
            print('x ', x)
            if x[-2:] == Episode:
                return x


# In[603]:


def frm(filesN):
    ls = []
    for i in filesN:
        ls.append(i[-4:])
    temp = np.asarray(ls)
    x,y = np.unique(temp, return_counts=True)

    mmx = np.max(y)

    lsc = []

    for i in range(len(y)):
        if y[i] == mmx:
            lsc.append(i)
    if len(lsc) > 1:
        if x[lsc[0]] == '.srt':
            found = x[lsc[1]]
        else:
            found = x[lsc[0]]
    else:
        found = x[np.argmax(y)]
    
    print('frm: \t format: {}'.format(found))
    print('found', found)
    return found


# In[604]:


def getEname(files, Episode, path,SeasonDir, season):
    
	c = 0

	fns = SeasonDir

	SeasonN = season

	filesN = files.copy()

	pattern = '[eE]01'

	if str(sys.argv[2]) == '0':
		Episode = int(Episode)
	elif str(sys.argv[2]) == '1':
		Episode = int(Episode) + 1

	checkv = frm(filesN)

	for i in filesN:
		if checkv in i:
			c += 1
	if Episode > c:
		SeasonN = str(int(SeasonN) + 1)
		print('SeasonN ', SeasonN)
		fns, filesN = getEfolder(path, SeasonN)
		checkv = frm(filesN)
		print('checkv ', checkv)
			
		for i in filesN:
			if i[-4:] == checkv:
				if re.findall(pattern, i):
					Episode = re.findall(pattern, i)[0]
					print('Episode ', Episode, 'fns ', fns, 'SeasonN ', SeasonN)
					return Episode[1:], fns, SeasonN, filesN

	if Episode < 10:
		Episode = '0' + str(Episode)
	else:
		Episode = str(Episode)

        
    #print('getEname:\n Episode: {} \n fns: {} \n Season: {}'.format(Episode, fns, SeasonN))

    
	return Episode, fns, SeasonN, filesN


# In[605]:


def fullpath(path, inr2):
    import os
    
    SE = inr2.split(' ')
    

    season = SE[0]
    Episode = SE[1]

    SeasonDirName, files = getEfolder(path, season)

    Episode, SeasonDirName, season, filesN = getEname(files, Episode, path, SeasonDirName,season)
    
    
    
    key = Finalname(filesN, Episode)
    
    #print('fullpath: \n SeasonDirName: {} \n Episode: {} \n season: {}'          .format(SeasonDirName, Episode, season))
    #print(f'key: {key}')
    
    return SeasonDirName, Episode, season, key


# In[606]:


def check():
    file = '${SCRIPTS_DIRECTORY}VLC/next.txt'
    f = open(file, 'r')
    temp = f.readline()
    series = temp.splitlines()[0]
    
    temp2 = f.readline()
    SE = temp2.splitlines()[0]
    
    f.close()
    
    return series, SE


# In[607]:


def search_for_series(name,path):
    files = os.listdir(path)
    print(name)
    for i in files:
        # print(i.lower())
        if name in i.lower():
            Series = i
            print('found')
            return Series


# In[608]:


def Next():
    comm = '/usr/bin/vlc --started-from-file {} &'
    Mpath = '/mnt/E/Series/'
    configfile = '${SCRIPTS_DIRECTORY}VLC/Config.txt'
    
    inr = open(configfile, 'r')
    inr1 = inr.readline()
    SeriesName = inr1.splitlines()[0]
    
    
    Series = search_for_series(SeriesName.lower(), Mpath)
    
    
    # SeriesNameLin = Series.replace(' ', '\ ')
    

    print('Mpath = {}\nSeries = {}'.format(Mpath, Series))
    path_func = Mpath + Series + '/'
    path = Mpath + Series + '/'
    
    
    lastseries, LSE = check()
    
    if lastseries == SeriesName:
        #print('Match!')
        FSE = LSE
    else:
        temp = inr.readline()
        print(temp)
        lk = temp.splitlines()
        lk = lk[0].split()
        print(lk)
        season = lk[0]
        episode = int(lk[1]) + 1 if sys.argv[2] == 1 else int(lk[1])
        FSE = str(season) + ' ' +str(episode)
    print('FSE ', FSE)
    inr.close()
    SeasonDirName, Episode, season, key = fullpath(path_func, FSE)
    print('Episode ', Episode)


    ls = [' ', '[', ']', '(', ')']

    # SDNLin = SeasonDirName.replace(' ', '\ ')
    # SDNLin = SDNLin.replace('[','\[')
    # SDNLin = SDNLin.replace(']','\]')
    
    print(key,Episode,SeasonDirName)
    
    FullPath2 = path + SeasonDirName + '/' + '*' + key + '*'

    for chr in ls:
        FullPath2 = FullPath2.replace(chr, '\\'+chr)
    
    print('Finalcommand: {}'.format(FullPath2))
    
    file = '${SCRIPTS_DIRECTORY}VLC/next.txt'
    
    f = open(file, "w")
    f.write(SeriesName)
    f.write('\n')
    f.write(season+ ' '+ Episode)
    f.close()
    
    test = '--pidfile ${SCRIPTS_DIRECTORY}VLC/test.txt'
    
    Finalcomm = comm.format(FullPath2)
    
    # print(Finalcomm)
    
    clean='wmctrl -c "{}"'.format(inr1.splitlines()[0])
    os.system(clean)
    os.system(Finalcomm)


# In[ ]:
# clean = 'wmctrl -c "the big bang"'
# os.system(clean)

wh = str(sys.argv[1])
if wh == 'n':
    Next()
elif wh == 'o':
    comm = '/usr/bin/vlc --started-from-file  &'
    os.system(comm)


#os.system('killall vlc')

