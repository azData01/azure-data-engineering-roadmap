⭐ WEEK 2 — Azure Data Factory Ingestion Pipeline

Theme: Build an orchestrated ingestion pipeline that loads data → ADLS raw/ → (optional) Dataflow transformation → clean/.
Outcome: You finish Week 2 with a fully functional ADF ingestion pipeline, exported JSON, screenshots, and a runbook committed to GitHub.

📌 WEEK 2 LEARNING SOURCES (reference upfront)
🎓 Microsoft Learn (Primary)

These are the exact modules for Week 2:

1️⃣ Introduction to Azure Data Factory
https://learn.microsoft.com/learn/modules/intro-to-azure-data-factory/

2️⃣ Build your first data factory and pipeline
https://learn.microsoft.com/learn/modules/build-your-first-data-factory/

3️⃣ Copy data with pipelines using Data Factory
https://learn.microsoft.com/learn/modules/copy-data-tool-azure-data-factory/

4️⃣ Use parameterization in ADF pipelines
https://learn.microsoft.com/learn/modules/parameterize-azure-data-factory/

🎥 YouTube (Hands-on Demos)

Adam Marczak — Azure Data Factory Tutorial for Beginners
https://youtu.be/-QFJjzFZUlU

Adam Marczak — Mapping Data Flows (optional)
https://youtu.be/Kv0Z8upGALQ

These are short, practical, and give you instant clarity.

💼 WEEK 2 Deliverables (for reference)

By the end of Week 2, you must produce:

✔ 1. ADF Ingestion Pipeline (JSON exported)

Linked Services

Datasets

Copy Activity

Parameters: file_name, folder_name

Trigger: Manual + Scheduled

✔ 2. Documentation

/project/week2-adf/README.md including:

Pipeline diagram (draw.io PNG)

Screenshot of successful pipeline run

Explanation of parameterisation

Runbook: How to rerun pipeline with a new file

✔ 3. Code + Assets

/src/ingestion/adf/pipeline.json

/src/ingestion/adf/datasets/*.json

/src/ingestion/adf/linkedservices/*.json

✔ 4. PR into main

Branch: week2-adf-pipeline

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

🟦 DAY 3 — Add Parameterisation (Make Pipeline Reusable)

Goal: Allow pipeline to ingest any file name & folder dynamically.

📘 Study (1–2 hrs)

Complete Learn Module:

“Use parameterization in Azure Data Factory pipelines”
https://learn.microsoft.com/learn/modules/parameterize-azure-data-factory/

Notes to focus on:

Pipeline parameters

Dataset parameters

Dynamic Content

@pipeline().parameters.* reference syntax

🔧 Hands-On (2–3 hrs)

Modify your pipeline:

Add parameters:

file_name

source_folder

sink_folder

Modify datasets:

Dataset location = dynamic:

@concat(pipeline().parameters.source_folder, '/', pipeline().parameters.file_name)

Test runs:

Run with parameters:

file_name = customers.csv  
source_folder = staging  
sink_folder = raw/customers

📁 Repo Work

Add:

/src/ingestion/adf/pipeline-parameterized.json
/project/week2-adf/parameterisation-notes.md

🟦 DAY 4 — Add Trigger + Export Pipeline JSON

Goal: Operationalize pipeline + export code for repo versioning.

📘 Study (1 hr)

Learn section:

Triggers in Azure Data Factory (within ADF documentation)
https://learn.microsoft.com/learn/modules/trigger-pipelines-data-factory/

🔧 Hands-On (3 hrs)

Add a Manual Trigger

Add a Scheduled Trigger (every 24 hours or dummy schedule)

Test both triggers

Export pipeline JSON:

ADF Studio → Manage → ARM Template → Export ARM Template
OR

Use built-in JSON export for pipeline only

Place JSON under:

src/ingestion/adf/pipeline.json
src/ingestion/adf/datasets/
src/ingestion/adf/linkedservices/

📁 Repo Work

Add images:

/project/week2-adf/screenshots/trigger-setup.png
/project/week2-adf/runbook.md

🟦 DAY 5 — Create Pipeline Diagram + Documentation + PR

Goal: Produce engineering-grade documentation and submit Week 2 deliverables.

📘 Study (1 hr)

Revisit Module:

Copy data with Data Factory
https://learn.microsoft.com/learn/modules/copy-data-tool-azure-data-factory/

This gives you insight on performance, throughput, and mapping use cases.

🔧 Hands-On (3–4 hrs)
1. Create a pipeline diagram (use Draw.io)

Include:

Source

Dataset

Copy activity

Sink

Trigger

Parameter flow

Export PNG → save under:

project/week2-adf/diagram.png

2. Write Runbook

Add details:

How to change parameters

How to re-run failed loads

How to add new source folders

Place it at:

project/week2-adf/runbook.md

3. Open PR

Branch: week2-adf-pipeline
Target: main

Include the PR template from Week 1.

⭐ WEEK 2 — Summary of Expected Deliverables

In your PR, you will submit:

📁 Code

/src/ingestion/adf/pipeline.json

/src/ingestion/adf/datasets/*.json

/src/ingestion/adf/linkedservices/*.json

📘 Documentation

/project/week2-adf/diagram.png

/project/week2-adf/runbook.md

/project/week2-adf/parameterisation-notes.md

Screenshots folder

⚙️ Pipeline Functionality

Ingests file → ADLS

Uses dynamic file/folder parameters

Has manual + scheduled triggers

Exports JSON via ARM Template

This directly builds into Week 3 (Synapse SQL external tables → analytics layer).
