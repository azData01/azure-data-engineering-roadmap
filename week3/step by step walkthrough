🗓️ WEEK 3 — DAY-BY-DAY HANDS-ON PLAN (5 study days)
🟦 DAY 1 — Synapse Workspace + First Lake Queries

Goal: Create Synapse workspace and query raw data directly in ADLS.

📘 Study (1–1.5 hrs)

Complete Microsoft Learn module:

Analyze data with Azure Synapse serverless SQL pools
https://learn.microsoft.com/training/modules/analyze-data-with-sql-serverless/

Focus on:

What serverless SQL is

OPENROWSET

Pay-per-query model

When to use serverless vs dedicated

🔧 Hands-On (2.5–3 hrs)
Step 1 — Create Synapse Workspace

Azure Portal → Create resource → Azure Synapse Analytics

Workspace name: syn-customer360-yourname

Link it to your existing ADLS Gen2 account

Set default container (e.g. clean or curated)

Create workspace

Step 2 — Query CSV in raw zone (no tables yet)

Open Synapse Studio → Data → SQL scripts → New script

Run this (adjust storage account name):

SELECT TOP 10 *
FROM OPENROWSET(
    BULK 'https://datalakeyourname001.dfs.core.windows.net/raw/customers/customers.csv',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    FIRSTROW = 2
) AS rows;


✅ This proves:

Synapse can read your Data Lake

Security & permissions are correct

📁 Day 1 Deliverables

Commit to GitHub:

src/analytics/synapse/day1_openrowset.sql
project/week3-synapse/screenshots/synapse-query-success.png
project/week3-synapse/day1-notes.md


day1-notes.md should include:

What serverless SQL is

Cost model

Why OPENROWSET is powerful

🟦 DAY 2 — Query Parquet + Partitioned Data

Goal: Query Parquet files efficiently and understand partitioning.

📘 Study (1 hr)

Microsoft Learn:

Query data in Azure Data Lake using serverless SQL pools
https://learn.microsoft.com/training/modules/query-data-lake-using-serverless-sql-pools/

Focus on:

Parquet vs CSV

Partition elimination

File pruning

🔧 Hands-On (3 hrs)
Step 1 — Query Parquet (if you have it)

If Week 2 ingested Parquet, run:

SELECT TOP 10 *
FROM OPENROWSET(
    BULK 'https://datalakeyourname001.dfs.core.windows.net/clean/customers/*.parquet',
    FORMAT = 'PARQUET'
) AS customers;

Step 2 — Partition-aware query (example)

If your folders are date-partitioned:

SELECT COUNT(*) AS cnt
FROM OPENROWSET(
    BULK 'https://datalakeyourname001.dfs.core.windows.net/clean/customers/year=2025/month=01/*.parquet',
    FORMAT = 'PARQUET'
) AS customers;

Step 3 — Compare CSV vs Parquet performance

Run same query against CSV and Parquet.
Note execution time & data scanned.

📁 Day 2 Deliverables
src/analytics/synapse/day2_parquet_queries.sql
project/week3-synapse/performance/csv_vs_parquet.md


Include:

Execution time

Data scanned (from Synapse UI)

Short conclusion

🟦 DAY 3 — Create External Data Source, File Format & Tables

Goal: Build reusable SQL objects instead of ad-hoc OPENROWSET queries.

📘 Study (1–1.5 hrs)

Microsoft Learn:

Create external tables using serverless SQL pools
https://learn.microsoft.com/training/modules/create-external-tables-serverless-sql-pools/

🔧 Hands-On (3 hrs)
Step 1 — Create external data source
CREATE EXTERNAL DATA SOURCE eds_datalake
WITH (
    LOCATION = 'https://datalakeyourname001.dfs.core.windows.net'
);

Step 2 — Create external file format
CREATE EXTERNAL FILE FORMAT eff_parquet
WITH (
    FORMAT_TYPE = PARQUET
);

Step 3 — Create external table
CREATE EXTERNAL TABLE dbo.ext_customers
(
    customer_id INT,
    name VARCHAR(100),
    signup_date DATE
)
WITH (
    LOCATION = '/clean/customers/',
    DATA_SOURCE = eds_datalake,
    FILE_FORMAT = eff_parquet
);

Step 4 — Query external table
SELECT COUNT(*) FROM dbo.ext_customers;

📁 Day 3 Deliverables
src/analytics/synapse/external_objects.sql
src/analytics/synapse/external_tables/ext_customers.sql
project/week3-synapse/day3-external-tables.md


Document:

Why external tables matter

Difference vs OPENROWSET

🟦 DAY 4 — Build Analytics Views (Serving Layer)

Goal: Create BI-friendly views and basic star-schema concepts.

📘 Study (1 hr)

Read:

Synapse Serverless best practices

Views vs tables in analytics

🔧 Hands-On (3–4 hrs)
Create curated views
CREATE VIEW dbo.vw_customers
AS
SELECT
    customer_id,
    name,
    signup_date,
    YEAR(signup_date) AS signup_year
FROM dbo.ext_customers;


Query:

SELECT signup_year, COUNT(*) 
FROM dbo.vw_customers
GROUP BY signup_year;

Optional: Join example

If you have transactions:

CREATE VIEW dbo.vw_customer_sales
AS
SELECT
    c.customer_id,
    c.name,
    COUNT(t.transaction_id) AS orders
FROM dbo.ext_customers c
LEFT JOIN dbo.ext_transactions t
    ON c.customer_id = t.customer_id
GROUP BY c.customer_id, c.name;

📁 Day 4 Deliverables
src/analytics/synapse/views/vw_customers.sql
src/analytics/synapse/views/vw_customer_sales.sql
project/week3-synapse/serving-layer-design.md

🟦 DAY 5 — Performance Testing + Documentation + PR

Goal: Treat this like production engineering work.

🔧 Performance Testing (2 hrs)
Run these comparisons:

OPENROWSET vs External Table

CSV vs Parquet

Partitioned vs non-partitioned

Record:

Execution time

Data scanned

Cost implications

📘 Documentation (2 hrs)

Create:

project/week3-synapse/performance-report.md


Include:

Query screenshots

Observations

Optimization recommendations

🔁 GitHub Work

Branch: week3-synapse-serverless

Commit all SQL + docs

Open PR → main

📦 WEEK 3 FINAL DELIVERABLES (BIG PICTURE)

By end of Week 3, your repo contains:

✅ SQL Code
src/analytics/synapse/
├── day1_openrowset.sql
├── day2_parquet_queries.sql
├── external_objects.sql
├── external_tables/
│   └── ext_customers.sql
└── views/
    ├── vw_customers.sql
    └── vw_customer_sales.sql

✅ Documentation
project/week3-synapse/
├── day1-notes.md
├── day3-external-tables.md
├── serving-layer-design.md
├── performance/
│   └── performance-report.md
└── screenshots/

✅ Skills Gained (DP-700 Relevant)

Serverless SQL analytics

Lakehouse querying patterns

External tables

BI-ready views

Cost-aware performance tuning

Git-based SQL development
