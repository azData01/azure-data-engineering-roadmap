import csv
from datetime import datetime
rows = []
for i in range(1,51):
    rows.append({
        "customer_id": i,
        "name": f"cust_{i}",
        "signup_date": datetime(2023,1,(i%28)+1).isoformat()
    })
with open("customers.csv","w",newline='') as f:
    writer = csv.DictWriter(f, fieldnames=rows[0].keys())
    writer.writeheader()
    writer.writerows(rows)
print("customers.csv created")
