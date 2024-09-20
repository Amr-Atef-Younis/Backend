import pandas as pd
import numpy as np
import datetime
import logging
from tabulate import tabulate
import sys

# file = "/home/amr/Desktop/Downloads_From_Internet/26-01-2024-18_35_47.xlsx"
# final = "40 SAR"
file = sys.argv[1]
second_arg = str(sys.argv[2]).replace(',','')
f_balance = float(second_arg)
# print(final)
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

Formatter = logging.Formatter('%(message)s')
print(f"{file.rsplit('/',1)[0]}/out.log")
FileHandler = logging.FileHandler(filename=f"{file.rsplit('/',1)[0]}/out.log", mode='w')
FileHandler.setFormatter(Formatter)

logger.addHandler(FileHandler)

pd.set_option('display.colheader_justify','center')
pd.set_option('display.width', 400)
pd.set_option('display.expand_frame_repr', False)

data = pd.read_excel(file)
data['Date'] = pd.to_datetime(data['Date']).dt.date
# data = data[data['Date'] >= datetime.date(year=2023,month=12, day=1)]

# f_balance = round(float(final.split()[0].replace(',','')),3)
# f_balance
idx_list = [
    'Cash Out',
    'Compensation',
    'Rejection',
    'Cash Collection Cycle',
    'Balance Adjustment',
    'Bosta Fees Cycle',
    'Recharge balance' ,
    'Packing Material',
    'Free Credit',
    
    'Borrow']

idx_dic = dict()
for key,value in zip(idx_list,range(len(idx_list))):
    idx_dic[key] = value

data['Category'].replace(idx_dic,inplace=True)
datax = data.sort_values(by=['Date','Category','Transactions ID'])
datax.reset_index(drop=True,inplace=True)
swapped_dict = {value: key for key, value in idx_dic.items()}
datax['Category'].replace(swapped_dict,inplace=True)
# print(datax)
# datax['Balance'], datax['Amount'] = datax['Balance'], datax['Amount']

balance = datax['Balance'].round(2).to_list()
amount = datax['Amount'].round(2).to_list()
lookout = round(f_balance - balance[-1],2)



diff = 0
errors = False
for a,b,c,d in zip(amount[1:],balance[:-1],balance[1:],datax['Transactions ID'].to_list()[1:]):
    sum = round(a + b,2)
    c = round(c,2)
    if sum == c:
        continue
    else:
        errors = True
        entry = datax[datax['Transactions ID'] == d]
        index = entry.index[0]
        out = entry.copy()
        if index - 1 >= 0:
            out = pd.concat([out,datax.iloc[index - 1].to_frame().T])# , ignore_index = True)
        if index + 1 < len(datax):
            out = pd.concat([datax.iloc[index + 1].to_frame().T, out])# , ignore_index = True)



        diff += round(sum - c,2)
        # if diff == lookout:
        # logger.info(entry['Transactions ID'].values[0])
        logger.info(f"\n\nCorrect sum = {sum}\t\tDifference = {round(sum - c,2)}\t\t Cumalitive Difference = {round(diff,2)}")
        logger.info(f"{a},{b},{sum},{c}")
        logger.info(tabulate(out, headers='keys', tablefmt='fancy_grid',colalign=tuple(["center"]*entry.shape[1]),showindex='never'))
        # date_IDs.append((entry['Transactions ID'].values[0], str(entry['Date'].values[0]), diff))

if not errors:
    logger.info("Everything is fine")


datay = datax[datax['Category'] == "Compensation"][['Transactions ID', 'Amount']]
datay.replace({"Transactions ID":"ORDER ID","AMOUNT":"Amount"},inplace=True)
# logger.info(tabulate(datay, headers='keys', tablefmt='fancy_grid',colalign=tuple(["center"]*datay.shape[1]),showindex='never'))
with pd.ExcelWriter(f"{file.rsplit('/',1)[0]}/balance compensations.xlsx", engine='xlsxwriter') as writer:
    
    datay.to_excel(writer, sheet_name='Sheet1', index=False)

    workbook  = writer.book
    worksheet = writer.sheets['Sheet1']

    center_alignment_format = workbook.add_format({'align': 'center', 'valign': 'vcenter'})

    for i, col in enumerate(datay.columns):
        column_len = max(datay[col].astype(str).apply(len).max(), len(col))
        worksheet.set_column(i, i, column_len + 2, cell_format=center_alignment_format)  # Adding a buffer of 2

# f_balance == round(diff + balance[-1],3)
# diff, f_balance - balance[-1]



def uploadToSpreadSheets(resultsDF):
    # Authenticate and create the service
    auth.authenticate_user()
    creds, _ = default()
    gc = gspread.authorize(creds)

    df = resultsDF

    # Create a new Google Sheet
    spreadsheet = gc.create('Request Latency')

    # Select the first sheet
    worksheet = spreadsheet.get_worksheet(0)


    # Format settings
    center_alignment_format = {
        "horizontalAlignment": "CENTER",
        "verticalAlignment": "MIDDLE"
    }

    # Convert DataFrame to list of lists for updating Google Sheets
    data_to_update = [resultsDF.columns.tolist()] + resultsDF.astype(str).values.tolist()

    # Update worksheet with data
    worksheet.update(data_to_update)

    # Fetch all cells in the worksheet
    cell_list = worksheet.range('A1:' + gspread.utils.rowcol_to_a1(resultsDF.shape[0], resultsDF.shape[1]))

    # Update cell formatting
    for i in range(resultsDF.shape[1]):  # iterate over columns
        for j in range(resultsDF.shape[0]):  # iterate over rows
            cell = cell_list[j * resultsDF.shape[1] + i]  # calculate cell index
            cell.horizontalAlignment = center_alignment_format["horizontalAlignment"]
            cell.verticalAlignment = center_alignment_format["verticalAlignment"]

    # Update cells in batch (including formatting)
    worksheet.update_cells(cell_list)


    print('Data uploaded to Google Sheets successfully!')
    print(spreadsheet.url)
    return spreadsheet.url