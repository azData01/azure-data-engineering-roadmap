# Lakehouse Architecture (High level)

## Components
- ADLS Gen2 (OneLake) — storage for bronze/silver/gold
- Fabric Notebooks / Databricks — transformations (PySpark)
- Fabric Pipelines / ADF — orchestration
- Synapse SQL / Fabric Warehouse — serving layer
- Power BI / Fabric Reports — consumption

## Data Flow
1. Ingest raw files → raw/ container
2. Orchestrator triggers notebook → transforms raw → clean/ (parquet/delta)
3. Further transforms create curated/ (gold)
4. SQL Warehouse exposes curated datasets to analysts

## Security
- Managed Identity for pipelines
- Role-based access per zone
