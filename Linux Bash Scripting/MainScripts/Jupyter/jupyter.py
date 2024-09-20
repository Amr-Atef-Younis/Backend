import os
import subprocess

SCRIPTS_DIRECTORY = str(os.getenv('SCRIPTS_DIRECTORY'))
print(SCRIPTS_DIRECTORY)

maincomm = '. /mnt/D/Anaconda/bin/activate\
      && export TRANSFORMERS_CACHE=/mnt/D/Anaconda/Models/HuggingFace/ \
          && export TORCH_HOME="/mnt/D/Anaconda/Models/Torch/" \
              && export KERAS_HOME="/mnt/D/Anaconda/Models/Tensorflow/" \
              && export NLTK_DATA="/mnt/D/Anaconda/Datasets/" \
                  && jupyter-notebook --browser firefox '

encoding = 'utf-8'

lastdir = ''
try:
    with open(f'{SCRIPTS_DIRECTORY}Jupyter/lastdir.txt','r') as f:
        lastdir = f.readline()
except:
    pass


notebookdir_comm = f'zenity --entry --entry-text="{lastdir}" --text="Notebook Directory"'


notebookdir = subprocess.check_output(notebookdir_comm, shell=True)
try:
    notebookdir = str(notebookdir, encoding).splitlines()[0]
except:
    notebookdir = ''
# notebookdir = notebookdir.split(' ')

# ndir = notebookdir

# for i in notebookdir[1:]:
#     ndir += '\ ' + i


if notebookdir == '':
    fcomm = maincomm + ' &'
else:
    fcomm = maincomm + f' --notebook-dir "{notebookdir}"' + ' &'
    with open(f'{SCRIPTS_DIRECTORY}Jupyter/lastdir.txt','w') as f:
        f.write(notebookdir)


os.system('pkill firefox && lsof | grep "/mnt/D/Anaconda/" | awk \'{print $2}\' | xargs kill')
if notebookdir != '':
    os.system(fcomm)