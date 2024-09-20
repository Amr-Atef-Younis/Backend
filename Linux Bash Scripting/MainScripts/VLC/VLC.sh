#!/bin/bash

. /mnt/D/Anaconda/etc/profile.d/conda.sh
conda activate base

python3 "$SCRIPTS_DIRECTORY"VLC/VLC.py $1 $2
