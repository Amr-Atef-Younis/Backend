import pandas as pd
import os
import sys
from tabulate import tabulate

def writeExcel(path, dataframe, filename):
    with pd.ExcelWriter(path+filename, engine='xlsxwriter') as writer:

        dataframe.to_excel(writer, sheet_name='Sheet1', index=False)

        workbook  = writer.book
        worksheet = writer.sheets['Sheet1']

        center_alignment_format = workbook.add_format({'align': 'center', 'valign': 'vcenter'})

        for i, col in enumerate(dataframe.columns):
            column_len = max(dataframe[col].astype(str).apply(len).max(), len(col))
            worksheet.set_column(i, i, column_len + 4, cell_format=center_alignment_format)  # Adding a buffer of 2



def log_file(file_path):

    import logging

    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)

    Formatter = logging.Formatter('%(message)s')

    FileHandler = logging.FileHandler(file_path,mode='w')
    FileHandler.setFormatter(Formatter)
    logger.addHandler(FileHandler)

    return logger

path = str(sys.argv[1]) 
compen_path = path+"Compensations/"
files = os.listdir(compen_path)

orders = []
compensations = []
sum = 0
order_dic = {}
for f in files:
    if not ('lock' in f or 'all' in f):
        id = str(f.split('.')[0])
        data = pd.read_excel(f"{compen_path+f}")
        data_sum = data['Compensation Amount'].round(3)
        new_sum = data_sum.sum()
        sum += new_sum
        ls = data['Order ID'].astype(str).to_list()
        orders += ls
        compensations += [[id, len(ls), new_sum]]
        for order_id, value in zip(ls, data_sum):
            order_dic[order_id] = value if not order_id in list(order_dic.keys()) else order_dic[order_id] + value

business_name = data['Business Name'].values[0]
order_list = list(order_dic.items())
order_list.sort()

all_exists = False
try:
    batch_path = compen_path+"all.xlsx"
    batch = pd.read_excel(batch_path)

    business_comp = batch[batch['BUSINESS'] == business_name].copy()
    business_comp['ORDER ID'] = business_comp['ORDER ID'].astype(str)

    x1 = [(i,float(j)) for i,j in zip(business_comp['ORDER ID'].to_list(), business_comp['AMOUNT'].to_list())]
    x1.sort()
    all_exists = True
except:
    all_exists = False

duplicate_orders = [(i,orders.count(i)) for i in set(orders) if orders.count(i) > 1 ]

linked_compensations = pd.DataFrame(compensations,columns=['Compensation ID', 'Number of Orders', 'Total Amount'])

comparison_file = pd.read_excel(f"{path}balance compensations.xlsx")
comparison_file.set_index(["Transactions ID"],inplace=True)


mismatch = []
for item,amount in zip(linked_compensations['Compensation ID'],linked_compensations['Total Amount']):
    if round(comparison_file.loc[int(item)]["Amount"],3) != round(amount,3):
        mismatch.append(item)
if len(mismatch) > 0:
    mismatch_df = linked_compensations.loc[linked_compensations['Compensation ID'].isin(mismatch), :]
    writeExcel(path, mismatch_df,"Mismatched Compensations.xlsx")


logger = log_file(f'{path+"compensation.log"}')
logger.info(tabulate(linked_compensations, headers='keys', tablefmt='fancy_grid',colalign=tuple(["center"]*linked_compensations.shape[1]),showindex='never'))
if all_exists:
    logger.info(f'\nBatch-Individual\t=\t{list(set(x1)-set(order_list))}\t\tIndividual-Batch\t=\t{list(set(order_list)-set(x1))}')
# print(duplicate_orders)
for x in duplicate_orders:
    # logger.info(f"# of Duplicate compensation\t=\t{len(duplicate_orders)}\t\t
    logger.info(f"ID\t=\t{x[0]}\t\t# of occurrences\t=\t{x[1]}\t\tValue per occurrence\t=\t{float(order_dic[x[0]])/float(x[1])}")
logger.info(f'Total compensation\t=\t{round(sum,2)}')


writeExcel(path, linked_compensations,"linked_compensations.xlsx")


