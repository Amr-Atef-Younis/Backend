import os
os.system("efibootmgr > /mnt/F/Scripts/DuplicatedEntries/text.txt")
#os.system("grep Partition text.txt > text2.txt")
os.system("grep UEFI /mnt/F/Scripts/DuplicatedEntries/text.txt > /mnt/F/Scripts/DuplicatedEntries/text3.txt")

pwd = 'pass'
#a_file = open("text2.txt")
#lines = a_file.readlines()
#for line in lines:
    #first_word = line.split()[0]
    #number = first_word[4:8]
    #print(number)
    #comm = 'efibootmgr -b '+number+' -B'
    #os.system('echo %s|sudo -S %s' % (pwd, comm))
#a_file.close()


b_file = open("/mnt/F/Scripts/DuplicatedEntries/text3.txt")
lines2 = b_file.readlines()
for line2 in lines2:
    first_word2 = line2.split()[0]
    number2 = first_word2[4:8]
    print(number2)
    comm2 = 'efibootmgr -b '+number2+' -B'
    os.system('echo %s|sudo -S %s' % (pwd, comm2))
b_file.close()
