# Week 3 — Synapse Serverless Performance Report

## Test Scope
Performance comparison of CSV vs Parquet using Synapse Serverless SQL.

## Test Environment
- Engine: Synapse Serverless SQL
- Storage: ADLS Gen2
- Dataset: Customers
- Records: ~<your count>

---

## Test Results Summary

| Test Case | Object | Data Processed | Duration | Notes |
|----------|------|---------------|---------|------|
| OPENROWSET CSV | raw/customers | XXX MB | XXX ms | Full scan |
| External Table CSV | ext_customers_csv | XXX MB | XXX ms | Similar to OPENROWSET |
| External Table Parquet | ext_customers_clean | XXX MB | XXX ms | Column pruning |
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
