import os,pathlib
import cv2 as cv
import tensorflow as tf
from tensorflow.python.keras.utils.data_utils import get_file
import numpy as np



class Functions:

    def __init__(self):
    self.download_models_repo()
    self.install_obj_det()
    pass


#######################################################################################
#######################################################################################


  # def install_obj_det(self):
  #   comm = 'pip install --ignore-installed --upgrade tensorflow==2.5.0 && cd models/research/ && protoc object_detection/protos/*.proto --python_out=.\
  #    && cp object_detection/packages/tf2/setup.py . && python3 -m pip install .'
     
  #   os.system(comm)


#######################################################################################
#######################################################################################


    def download_models_repo(self):
    if "models" in pathlib.Path.cwd().parts:
        while "models" in pathlib.Path.cwd().parts:
            os.chdir('..')
    elif not pathlib.Path('models').exists():
        os.system('git clone --depth 1 "https://github.com/tensorflow/models"')


#######################################################################################
#######################################################################################


  def download_model(self, modelurl):
    zipfile = modelurl.split('/')[-1]
    self.modelname = zipfile.split('.')[0]
    get_file(
        zipfile, modelurl,
        cache_dir='.'
        )
    x = f"tar -xf 'datasets/' + {zipfile} -C ."
    os.system(x)
    return self.modelname, self.modelname.replace('-','')
   
#######################################################################################
#######################################################################################



  def moving(self, project_dir, model_name):
    test_data_dir = 'models/research/object_detection/test_data/'
    # config_dir = 'models/research/object_detection/configs/tf2/'

    self.modelname = model_name

    comm = f'cp -r "{project_dir}{model_name}/checkpoint" "{project_dir}{test_data_dir}"'
    os.system(comm)

    self.pipeline_config = model_name + '/pipeline.config'

    self.checkpoint_dir = test_data_dir + 'checkpoint/'
    


#######################################################################################
#######################################################################################

