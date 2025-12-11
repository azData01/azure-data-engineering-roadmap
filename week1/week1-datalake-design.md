# Week 1 — Data Lake Design (Customer 360 Lakehouse)

## Objective
Design a Data Lake as the foundation for the Customer 360 Lakehouse project. This document records naming conventions, folder structure, and initial access model.

## Zones / Containers
- raw/        : Raw ingested files (immutable)
- clean/      : Cleaned, schema-normalised parquet/delta
- curated/    : Business-ready datasets (gold) for analytics

## Naming conventions
- Lowercase only
- Use underscores for separation, e.g. customer_activity_2025_12_01.csv
- Partitioning: use folder-based date partitioning: /yyyy/MM/dd/

## File formats
- Raw: CSV or JSON (ingest as-is)
- Clean/Curated: Parquet or Delta (prefer Delta for ACID, time travel)

## Partition strategy
- Time-based partitioning per ingest date: /yyyy/MM/dd/
- Additional partition on region or logical shard when scale requires

## Access & RBAC (initial)
- Data Engineers (Dev): Storage Blob Data Contributor on resource group
- Analytics (Read-only): Storage Blob Data Reader on curated containers
- Pipelines (ADF/Databricks): Use Managed Identity assigned Storage Blob Data Contributor

## Notes
- Hierarchical namespace enabled (ADLS Gen2)
- Do not store secrets in repo. Use Key Vault for secrets.

## Artifacts
- Storage account name: datalakeyourname001
- Containers created: raw, clean, curated
- Sample files uploaded: customers.csv, transactions.csv
