import os


path = '/mnt/F/Scripts/VLC/'
comm1 = 'pactl list short sink-inputs > {}'
comm2 = 'pactl list sink-inputs > {}'
comm3 = 'egrep -i "corked" {} > {}'
comm4 = 'egrep -i "application.name" {} > {}'
os.system(comm1.format(path + 'text.txt'))

os.system(comm2.format(path + 'text2.txt'))

os.system(comm3.format(path + 'text2.txt', path + 'text3.txt'))

os.system(comm4.format(path + 'text2.txt', path + 'text4.txt'))


count_corked = open(path + 'text3.txt')

find_vlc = open(path + 'text4.txt')



count_corked = count_corked.readlines()


for i,found in enumerate(find_vlc):
	if 'VLC' in found:
		found_idx = i
		break

if 'no' in count_corked[found_idx]:
	

