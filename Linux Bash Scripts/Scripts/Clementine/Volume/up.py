import time
import os




os.system("pactl list sink-inputs > /mnt/F/Scripts/Clementine/Volume/text.txt")
os.system("grep '#' /mnt/F/Scripts/Clementine/Volume/text.txt > /mnt/F/Scripts/Clementine/Volume/text2.txt")
os.system("grep 'application.name = ' /mnt/F/Scripts/Clementine/Volume/text.txt > /mnt/F/Scripts/Clementine/Volume/text3.txt")

a_file = open("/mnt/F/Scripts/Clementine/Volume/text3.txt")
lines = a_file.readlines()
x = 0
index = 200
for line in lines:
    data = line.split()
    word = data[2]
    if word.find("Clementine") == 1:
        index = x
        break
    else:
        x = x + 1
a_file.close()
if index != 200:
    a_file = open("/mnt/F/Scripts/Clementine/Volume/text2.txt")
    lines = a_file.readlines()
    findex = ""
    data = lines[index].split()
    for i in data[2]:
        if i != '#':
            findex = findex + i
    a_file.close()

    os.system("pactl set-sink-input-volume " + findex +  " +1%")
    a_file.close()
