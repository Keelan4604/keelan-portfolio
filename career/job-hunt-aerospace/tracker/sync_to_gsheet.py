import csv
import json
import subprocess
from pathlib import Path

CSV_PATH = Path(r'C:\Users\Keela\.openclaw\workspace\career\job-hunt-aerospace\tracker\job_tracker.csv')
SHEET_ID = '1Ai0SI73whnjJD704LDx4eTGYQTOFl0O0znrTL21nGEo'
GOG = Path(r'C:\Users\Keela\.openclaw\bin\gog.exe')
SHEET_NAME = 'Sheet1'

rows = []
with CSV_PATH.open(newline='', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    headers = reader.fieldnames
    rows.append(headers)
    for r in reader:
        rows.append([r.get(h, '') for h in headers])

if not rows or not rows[0]:
    raise RuntimeError('Tracker CSV is empty or missing headers.')

col_count = len(rows[0])
end_col = chr(ord('A') + col_count - 1)
vals = json.dumps(rows)

subprocess.check_call([str(GOG), 'sheets', 'clear', SHEET_ID, f'{SHEET_NAME}!A:Z'])
subprocess.check_call([
    str(GOG),
    'sheets', 'update', SHEET_ID,
    f'{SHEET_NAME}!A1:{end_col}{len(rows)}',
    '--values-json', vals,
    '--input', 'USER_ENTERED'
])
print('synced')
