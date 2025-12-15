# Azure Data Factory – Ingestion Pipeline Runbook
Pipeline: pl_ingest_generic

## 1. Purpose
This pipeline ingests source files into Azure Data Lake Storage Gen2 (Raw zone).
It is designed to be reusable through parameterisation and supports both manual and scheduled execution.

---

## 2. Architecture Overview
- Orchestration: Azure Data Factory
- Source: File-based (CSV)
- Target: ADLS Gen2 – Raw zone
- Authentication: Managed Identity
- Trigger Types: Manual, Scheduled

---

## 3. Pipeline Parameters

| Parameter Name     | Description                         | Example Value        |
|--------------------|-------------------------------------|----------------------|
| p_sourceFolder     | Source folder path                  | raw/customers        |
| p_fileName         | Name of source file                 | customers.csv        |
| p_sinkFolder       | Target folder in Data Lake          | raw/customers        |

---

## 4. How to Run the Pipeline (Manual)

1. Open **Azure Data Factory Studio**
2. Navigate to **Author → Pipelines**
3. Select pipeline: `pl_ingest_generic`
4. Click **Add trigger → Trigger now**
5. Enter parameter values
6. Click **OK**
7. Monitor execution in **Monitor → Pipeline Runs**

---

## 5. Scheduled Execution
- The pipeline is configured with a scheduled trigger
- Frequency: Daily
- Timezone: UTC
- Schedule can be adjusted under **Manage → Triggers**

---

## 6. Monitoring & Validation

### Monitor pipeline:
- ADF Studio → Monitor → Pipeline runs
- Check:
  - Status = Succeeded
  - Duration
  - Data written

### Validate output:
- Navigate to ADLS Gen2
- Path: `/raw/customers/`
- Confirm file exists and size > 0

---

## 7. Error Handling & Recovery

### Common Failures
| Error Type | Cause | Resolution |
|-----------|------|------------|
| File not found | Incorrect parameter value | Verify folder/file name |
| Permission denied | Missing RBAC | Assign Storage Blob Data Contributor |
| Timeout | Large file or network | Increase timeout / split files |

---

## 8. Reprocessing / Rerun Strategy
- Correct input parameters
- Re-run pipeline manually
- Overwrite behavior depends on sink settings
- For idempotent loads, consider:
  - Staging folder
  - File renaming with timestamp

---

## 9. Future Improvements
- Add metadata-driven ingestion
- Add logging table for audit
- Integrate with CI/CD
- Add alerting via Azure Monitor
