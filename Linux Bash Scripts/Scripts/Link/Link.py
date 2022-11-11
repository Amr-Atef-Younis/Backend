import os
import sys
import subprocess


encoding = 'utf-8'

clip_paste = subprocess.check_output('xclip -o', shell=True)
clip_paste = str(clip_paste, encoding).splitlines()[0]

kind = subprocess.check_output('zenity --entry --text="Series : 1	Movies : 2	OW : 3"', shell=True)
kind = str(kind, encoding).splitlines()[0]
print(kind)
SM = True

if kind == "3":
	get_path = 'zenity --entry --entry-text="{}" --text="Specify Source Folder"'.format(clip_paste)
	Source_path = subprocess.check_output(get_path, shell=True)
	Source_path = str(Source_path, encoding).splitlines()[0]
	Source_path = Source_path[:-1]
	SM = False
else:
	name = subprocess.check_output('zenity --entry --text="Specify Movie or Series"', shell=True)
	name = str(name, encoding).splitlines()[0]

DesktopVideo = subprocess.check_output('zenity --entry --text="Videos:1    Desktop:2     OW:3"', shell=True)
DesktopVideo = str(DesktopVideo, encoding).splitlines()[0]

if DesktopVideo == '1':
	dest = '/home/amr/Videos/'
elif DesktopVideo == '2':
	dest = '/home/amr/Desktop/'
elif DesktopVideo == '3':
	dest = subprocess.check_output('zenity --entry --text="Destination Folder"', shell=True)
	dest = str(dest, encoding).splitlines()[0]


if SM:
	name = name.lower()

	if kind == "1":
		jn = "Series/"
	elif kind == "2":
		jn = "Movies/"

	dir = "/mnt/E/{}".format(jn)

	folders = os.listdir(dir)



	folder_name = ""

	for i in folders:
		if name in i.lower():
			folder_name = i
			break
		
		
	Source_path = dir+folder_name

comm = 'ln -s "{}" "{}"'

final_comm = comm.format(Source_path, dest)

print(final_comm)

os.system(final_comm)
