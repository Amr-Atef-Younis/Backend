import pandas as pd
import sys
import re
import os

main_path = '/home/amr/Desktop/Downloads_From_Internet/'

src = [i for i in os.listdir(main_path) if ".xlsx" in i][0]

data = pd.read_excel(f"{main_path+src}", skiprows=1).drop(columns=['Emp ID'])
data.rename(columns={data.columns[0]: 'Name'}, inplace=True)

team = ['Nermine Samir', 'Amr Atef', 'Abdelrahman Tarek', 'Nour Korany', 'Haidy khalil', 'Omnia Mansor', 'Mariam Mohsen', 'Haydee Muhammad']


dest = "/mnt/F/Temp Career/Team_Schedule/"

final_name = 'Team_' + src.split('/')[-1].split('.')[0].replace(' ', '_')

x = data[data['Name'].isin(team)]
final_data = x[x['Wave'] != 'Wave 121'].drop(columns=['Wave'])
final_data.set_index(['Name'], inplace=True)
final_data.sort_index(inplace=True)

final_data.to_html(dest+final_name+'.html')

