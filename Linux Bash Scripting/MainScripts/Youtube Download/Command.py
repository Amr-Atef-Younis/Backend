import os
import sys
import subprocess
import logging

encoding = 'utf-8'
path = "${SCRIPTS_DIRECTORY}Youtube\ Download/"

logger = logging.getLogger(__name__)

logger.setLevel(logging.INFO)

FinalComman_fh = logging.FileHandler('${SCRIPTS_DIRECTORY}Youtube Download/FinalCommand.log')
# Size_fh = logging.FileHandler('Size.log')

formatter = logging.Formatter('%(asctime)s:%(message)s')

FinalComman_fh.setFormatter(formatter)
# Size_fh.setFormatter(formatter)

FinalComman_fh.setLevel(logging.INFO)

logger.addHandler(FinalComman_fh)
# logger.addHandler(Size_fh)

clip_paste = ""
console.log(`\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\# getStarCount \#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#`)
console.log(getStarCount)
console.log(`\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\# getStarCount \#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#`)

# encoding = 'utf-8'
clip_paste = subprocess.check_output('xclip -o', shell=True)
clip_paste = str(clip_paste, encoding).splitlines()[0]
print(clip_paste)

comm_paste = 'zenity --entry --entry-text="{}" --text="Enter Video URL"'.format(clip_paste)

vid_url = subprocess.check_output(comm_paste, shell=True)
vid_url = str(vid_url, encoding).splitlines()[0]


get_formats = f'timeout 6 yt-dlp -F "{vid_url}" > {path}formats.txt'

os.system(get_formats)

only_file = "cat \"${SCRIPTS_DIRECTORY}Youtube Download/formats.txt\" | awk '/^\[download\] Downloading item 2/ { print NR; exit}'"

try:
    only_file_comm = subprocess.check_output(only_file, shell=True)
    only_file_comm = str(only_file_comm, encoding).splitlines()[0]
    # print(only_file_comm)
    os.system("cat \"${SCRIPTS_DIRECTORY}Youtube Download/formats.txt\" \
    | head -n $(($(cat \"${SCRIPTS_DIRECTORY}Youtube Download/formats.txt\" \
    | awk '/^\\[download\\] Downloading item 2/ \
    { print NR; exit}') - 1)) > \"${SCRIPTS_DIRECTORY}Youtube Download/formats.txt\"")
except:
    pass

mp4_formats = f"cat {path}formats.txt | awk '/mp4/ && (/1920x1080/ || /1280x720/)' >> {path}combined.txt"
webm_formats = f"cat {path}formats.txt | awk '/webm/ && (/medium/ || /high/)' >> {path}combined.txt"
m4a_formats = f"cat {path}formats.txt | awk '/m4a/ && (/medium/ || /high/)' > {path}combined.txt"

newline = f'echo "" >> {path}combined.txt'


os.system(m4a_formats + ' && ' + newline + ' && '  + webm_formats + ' && ' + newline + ' && ' + newline + ' && ' + mp4_formats)



# dest = subprocess.check_output('zenity --entry --entry-text="/mnt/F/Machine Learning/Courses/Default YT directory/" --text="Destination Folder"', shell=True)
# dest = str(dest, encoding).splitlines()[0]

dest = "/mnt/F/Machine Learning/Courses/Default YT directory/"


idx = subprocess.check_output('zenity --entry --entry-text="Na" --text="Idx of video"', shell=True)
idx = str(idx, encoding).splitlines()[0]


multformats = False

comm = f'gedit {path}combined.txt'

os.system(comm)


x = subprocess.check_output('zenity --entry --entry-text="22" --text="Enter # of Format"', shell=True)

x = str(x, encoding).splitlines()[0]


get_size = 'cat {}combined.txt | grep "{}" | perl -n -e\'/(\d+\.*\d+[MG])iB/ && print $1\''
size = 0

if '+' in x:
    k = x.split('+')
    forms = [k[0],k[1]]
    extra = [' mp4', ' m4a']
    for f,e in zip(forms,extra):
        get_size_comm = subprocess.check_output(get_size.format(path,f+e), shell=True)
        get_size_comm = str(get_size_comm, encoding).splitlines()[0]
        print(get_size_comm)
        size += float(get_size_comm[:-1]) if get_size_comm[-1] == 'M' else float(get_size_comm[:-1]) * 1024
# else:
    # get_size_comm = subprocess.check_output(get_size.format(path,x), shell=True)
    # print(get_size_comm)
    # size += float(str(get_size_comm, encoding).splitlines()[0][:-1])

download_v = 'yt-dlp -f {} {} -o {}%(title)s.%(ext)s{}'


# copy_dest = subprocess.check_output('zenity --entry --entry-text="Temp" --text="Copy Destination Folder"', shell=True)
# copy_dest = str(copy_dest, encoding).splitlines()[0]



final_comm = download_v.format(x, '"'+vid_url+'"', '"'+dest, '"')

if idx != "Na":
    final_comm += " -I " + idx

start = 'gxmessage -noescape -timeout 1 -geometry 440x125-800-420 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "Download Started"' 
done = 'gxmessage -noescape -timeout 1 -geometry 440x125-800-420 -sticky -ontop -borderless -fg "yellow" -fn "serif italic 30" "Download Finished"'

copy = 'bash "${SCRIPTS_DIRECTORY}Youtube Download/copy.sh" "{}" &'


os.system(f'{start} && {final_comm} && {done}')
# && {copy.format(copy_dest)}
logger.info(final_comm)
# logger.info(copy.format(copy_dest))
# logger.info(f'Size\t=\t{size} MiB')

# os.system(f'')