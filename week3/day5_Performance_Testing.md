WEEK 3 — DAY 5
Performance Testing, Cost Awareness & Final Documentation
Today’s objectives

You will:

Compare OPENROWSET vs External Tables vs Views

Understand data scanned & cost drivers

Learn what you can and cannot optimize in Synapse Serverless

Produce a performance report suitable for GitHub & interviews

Close Week 3 cleanly

Step 0 — Ground rules (important)

Synapse Serverless performance is not about indexes or tuning like SQL Server.

Instead, it’s driven by:

File format (CSV vs Parquet)

File size & number of files

Column pruning

Predicate pushdown

How queries are written

Keep that mental model in mind.

Step 1 — Establish your baseline objects

You should already have:

dbo.ext_customers_csv → CSV in /raw/customers/

dbo.ext_customers_clean → Parquet in /clean/customers_v1/

serving.vw_customers

serving.vw_customer_signups_by_month

If any are missing, stop and fix before continuing.

Step 2 — Enable query statistics view

In Synapse Studio → SQL script editor:

Run any query

After execution, open Messages / Query details

Look for:

Data processed

Elapsed time

Result cache (if any)

You will record these values manually.

Step 3 — Performance Test 1: CSV via OPENROWSET (worst case)
SELECT COUNT(*) 
FROM OPENROWSET(
    BULK 'https://<storage-account>.dfs.core.windows.net/raw/customers/*.csv',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    FIRSTROW = 2
) AS csv_data;
GO

Record:

Data processed (MB)

Duration (ms)

Notes

This represents:

No schema reuse

No metadata

No optimization

Step 4 — Performance Test 2: CSV External Table
SELECT COUNT(*) 
FROM dbo.ext_customers_csv;
GO

Record:

Data processed

Duration

Difference vs OPENROWSET

Expected result:
Slightly better readability, but similar scan cost.

Step 5 — Performance Test 3: Parquet External Table (key comparison)
SELECT COUNT(*) 
FROM dbo.ext_customers_clean;
GO

Record:

Data processed

Duration

Compare with CSV

Expected result:
✔ Significantly less data scanned
✔ Faster execution
✔ Lower cost

This is the core lakehouse justification.

Step 6 — Performance Test 4: Column Pruning
SELECT customer_id 
FROM dbo.ext_customers_clean;
GO


Compare with:

SELECT * 
FROM dbo.ext_customers_clean;
GO

Observe:

Data processed difference

Why Parquet helps here

Step 7 — Performance Test 5: Serving View vs Base Table
SELECT COUNT(*) 
FROM serving.vw_customers;
GO


Compare with:

SELECT COUNT(*) 
FROM dbo.ext_customers_clean;
GO

Expected insight

Views do not increase scan cost

Views improve usability, not performance

Performance comes from storage format & query shape

Step 8 — What you CANNOT optimize in Serverless (document this)

Important to show maturity.

You cannot:

Create indexes

Create statistics

Force partitions like SQL DW

Control file ordering

You can:

Choose Parquet/Delta

Control folder layout

Control file sizes (later via Spark)

Write efficient SELECTs

Step 9 — Write the performance report (core deliverable)

Create this file:

project/week3-synapse/performance-report.md

Copy-paste template (fill with your numbers)
# Week 3 — Synapse Serverless Performance Report

## Test Scope
Performance comparison of CSV vs Parquet using Synapse Serverless SQL.

## Test Environment
- Engine: Synapse Serverless SQL
- Storage: ADLS Gen2
- Dataset: Customers
- Records: 50

---

## Test Results Summary

| Test Case | Object | Data Processed | Duration | Notes |
|----------|------|---------------|---------|------|
| OPENROWSET CSV | raw/customers | 1MB | XXX ms | Full scan |
| External Table CSV | ext_customers_csv | 1 MB | 0.99 ms | Similar to OPENROWSET |
| External Table Parquet | ext_customers_clean | 1 MB | 0.21 ms | Column pruning |
| View (Parquet) | serving.vw_customers | XXX MB | XXX ms | Same scan cost |

---

## Observations
- Parquet significantly reduces data scanned
- Column pruning works automatically with Parquet
- Views do not add performance overhead
- CSV scans are cost-inefficient at scale

---

## Conclusions
Synapse Serverless is best suited for:
- Ad-hoc analytics
- Lakehouse exploration
- BI semantic layers

For heavy transformations:
- Use Spark / Fabric / Databricks

---

## Recommendations
- Always convert raw CSV to Parquet
- Use views for BI consumption
- Avoid frequent large CSV scans

Step 10 — Screenshots (evidence)

Capture:

Query result for each test

Query details showing data processed

Save to:

project/week3-synapse/screenshots/day5-performance/

GitHub commits (Day 5)
git checkout -b week3-day5-performance
git add project/week3-synapse/performance-report.md project/week3-synapse/screenshots
git commit -m "docs(week3): add Synapse serverless performance comparison and analysis"
git push --set-upstream origin week3-day5-performance


Open PR → merge into main.

WEEK 3 — FINAL OUTCOME (Big Picture)

After today, your Week 3 demonstrates:

✔ Synapse Serverless SQL mastery
✔ External tables & CETAS
✔ ACL & managed identity troubleshooting
✔ Lakehouse clean/serving layers
✔ Performance & cost awareness
✔ BI-ready design thinking

This is solid DP-700-aligned, real-world data engineering experience.
