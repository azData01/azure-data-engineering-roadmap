# DP-700 Skill Mapping to My Architecture

## Lakehouse & Delta
- Bronze/Silver/Gold tables implemented in Fabric Lakehouse
- Delta format used with OPTIMIZE and VACUUM

## Data Ingestion
- CSV ingestion via notebook
- Incremental logic introduced (timestamp-based)

## Transformation
- PySpark notebooks for Silver and Gold layers

## Serving & BI
- Gold tables exposed for semantic model
- Power BI / Fabric semantic model planned

## Orchestration
- Fabric Pipeline orchestrates notebooks

## Monitoring & Performance
- Pipeline run history
- Delta OPTIMIZE/VACUUM executed
