 
PR: Week 1 — Azure Storage Foundations & Data Lake Design
📌 Summary

This PR introduces the foundational components for the Customer 360 Lakehouse Project as part of my DP-700 learning roadmap.
The main focus of Week 1 was to design and provision the Azure Data Lake (ADLS Gen2), establish the base folder structure, configure access, and document core architectural decisions.

This PR contains all initial setup artifacts, documentation, and evidence to ensure the platform is ready for ingestion and transformation work beginning next week.

✅ What Was Completed This Week
1. Azure Resources Provisioned

Created Storage Account (ADLS Gen2) with hierarchical namespace enabled

Added 3 core containers:

raw/

clean/

curated/

Uploaded sample customers.csv to raw/

Verified access using Azure Portal / Storage Explorer

2. Security & Access

Assigned appropriate RBAC permissions (Storage Blob Data Contributor / Reader)

Created an access plan for future ADF, Databricks, and Synapse components (managed identity approach)

Documented access model in project/week1-setup/access-plan.md

3. Repository Structure Established

Created initial folder structure for the entire 12-month roadmap, including:

docs/
project/
src/
00-documentation/


Added Week 1 deliverables under:

project/week1-setup/

4. Architecture & Design Docs

week1-datalake-design.md — Data Lake zones, naming conventions, formats

lakehouse-architecture.md — high-level architecture incl. security and medallion layers

Added starter sample data generator script

📂 Files & Folders Added in This PR
project/week1-setup/
    screenshots/
    access-plan.md
    sample_data/generate_sample_data.py
    how-to-upload.md
project/week1-datalake-design.md
docs/lakehouse-architecture.md
00-documentation/README.md

🧪 Verification Evidence

Screenshots of Storage Account deployment

Screenshots of containers + raw data upload

(Optional) Downloaded file check via Azure CLI

No secrets committed (validated via GitHub Actions pre-commit workflow)

🚀 Next Steps (Week 2 Preview)

Build Azure Data Factory ingestion pipeline

Establish dataset parameterisation

Introduce repeatable ingestion pattern (Raw → Clean)

Capture Pipeline JSON and runbook into the repo

✔️ PR Checklist

 ADLS Gen2 created and hierarchical namespace enabled

 Containers raw/, clean/, curated/ created

 Sample data uploaded & validated

 RBAC plan documented

 Week 1 architectural docs committed

 Screenshots added

 No credentials committed (validated via workflow)

This PR finalises Week 1 and sets the foundation for all upcoming data engineering and analytics tasks in the DP-700 roadmap.
