import os
import sys
import subprocess

encoding = 'utf-8'

clip_paste = ""

path = "/mnt/F/Scripts/Youtube\ Download/"


# encoding = 'utf-8'
clip_paste = subprocess.check_output('xclip -o', shell=True)
clip_paste = str(clip_paste, encoding).splitlines()[0]

comm_paste = 'zenity --entry --entry-text="{}" --text="Enter Video URL"'.format(clip_paste)

vid_url = subprocess.check_output(comm_paste, shell=True)
vid_url = str(vid_url, encoding).splitlines()[0]


get_formats = f'yt-dlp -F "{vid_url}" > {path}formats.txt'

os.system(get_formats)



mp4_formats = f"cat {path}formats.txt | awk '/mp4/ && (/1920x1080/ || /1280x720/)' >> {path}combined.txt"
webm_formats = f"cat {path}formats.txt | awk '/webm/ && (/medium/ || /high/)' >> {path}combined.txt"
m4a_formats = f"cat {path}formats.txt | awk '/m4a/ && (/medium/ || /high/)' > {path}combined.txt"

newline = f'echo "" >> {path}combined.txt'


os.system(m4a_formats + ' && ' + newline + ' && '  + webm_formats + ' && ' + newline + ' && ' + newline + ' && ' + mp4_formats)



dest = subprocess.check_output('zenity --entry --entry-text="/mnt/F/Machine Learning/Courses/Courses/" --text="Destination Folder"', shell=True)
dest = str(dest, encoding).splitlines()[0]


multformats = False

comm = f'gedit {path}combined.txt'

os.system(comm)


x = subprocess.check_output('zenity --entry --text="Enter # of Format"', shell=True)

x = str(x, encoding).splitlines()[0]


try:
    k = x.split()
    form1 = k[0]
    form2 = k[1]
    multformats = True
except:
    pass

if multformats:
    formating = form1 + '+' + form2
else:
    formating = x


download_v = 'yt-dlp -f {} {} -o {}%(title)s.%(ext)s{}'




final_comm = download_v.format(formating, '"'+vid_url+'"', '"'+dest, '"')

start = 'gxmessage -noescape -geometry 440x125-800-420 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "Download Started"' 
done = 'gxmessage -noescape -geometry 440x125-800-420 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "Download Finished"'


# print(final_comm)

os.system(f'echo {final_comm} > {path}fcomm.txt')
os.system(final_comm + ' && ' + done)

# os.system(start)
# https://www.youtube.com/watch?v=fSwmbEjX4NA&t=1s
