# How to upload sample data to ADLS Gen2 (raw container)

1. Using Azure Portal:
   - Storage Account -> Containers -> raw -> Upload -> select customers.csv
2. Using Azure Storage Explorer:
   - Connect to subscription -> navigate to storage account -> containers -> raw -> Upload
3. Using Azure CLI:
   az storage blob upload --container-name raw --name customers.csv --file ./customers.csv --account-name datalakeyourname001 --auth-mode login
