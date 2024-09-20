#!/bin/bash

killall gxmessage

x='"$SCRIPTS_DIRECTORY"GPU/'
cat $x'test.txt' > $x'text.txt'

nvidia-smi --query-gpu=utilization.gpu,memory.free,clocks.mem --format=csv -f $x'text.csv'


tail -n 1 $x'text.csv' >> $x'text.txt'
sed -i -e 's/,/\t/g' $x'text.txt'
gxmessage -center -borderless -fn "serif italic 30" -bg black -file $x'text.txt'
