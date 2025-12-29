# Week 3 Day 4 — Serving Views

## Goal
Create a BI-ready serving layer in Synapse Serverless SQL using views.

## Objects created
- dbo.ext_customers_clean (external table over CETAS Parquet folder)
- dbo.vw_customers (clean dimension view)
- dbo.vw_customer_signups_by_month (aggregation view)
- serving schema + serving.* views for BI consumption

## How BI should consume
Power BI / Fabric should connect to:
- serving.vw_customers
- serving.vw_customer_signups_by_month

## Notes
Views provide stable abstractions so storage paths and file formats can change without breaking dashboards.
