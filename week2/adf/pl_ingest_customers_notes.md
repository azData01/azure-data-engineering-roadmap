 
🗓️ WEEK 2 — DAY-BY-DAY HANDS-ON GUIDE
🟦 DAY 1 — Understand ADF Concepts + Connect ADF to Your Data Lake

Goal: Learn ADF architecture + connect to your ADLS Gen2 from Week 1.

📘 Study (1.5 hrs)

Complete Module 1:

“Introduction to Azure Data Factory”
https://learn.microsoft.com/learn/modules/intro-to-azure-data-factory/

Focus on:

Pipelines

Activities

Linked Services

Datasets

Integration Runtime

Watch (optional but recommended):
🎥 Adam Marczak ADF overview → https://youtu.be/-QFJjzFZUlU

🔧 Hands-On (2–3 hrs)

Open Azure Portal → Create Data Factory

Name: adf-customer360-yourname

Version: V2

Region: same as your storage account

In ADF Studio → Create Linked Service:

Azure Data Lake Storage Gen2

Authentication: Managed Identity (prefer) or Account Key (for learning only)

Test connection

Verify ADF can browse your storage containers raw/, clean/, curated/.

📁 Files to Create in Repo
project/week2-adf/linked-services.md
project/week2-adf/screenshots/


Add screenshot:

Linked Service test successful

🟦 DAY 2 — Build the First Ingestion Pipeline (Static Copy Activity)

Goal: Create a pipeline that copies a known file (customers.csv) → ADLS raw/.

📘 Study (1–1.5 hrs)

Complete Learn Module:

“Build your first data factory and pipeline”
https://learn.microsoft.com/learn/modules/build-your-first-data-factory/

🔧 Hands-On (2.5–3 hrs)

In ADF, create pipeline: pl_ingest_customers

Add Copy Data activity

Create Dataset (Source):

Type: Binary or DelimitedText

Point to your local file or sample dataset

Create Dataset (Sink):

ADLS Gen2

Folder: /raw/customers/

Publish and run the pipeline

Confirm in ADLS that the file appears

📁 Repo Work

Add:

/project/week2-adf/screenshots/run1-success.png
/project/week2-adf/pl_ingest_customers_notes.md
