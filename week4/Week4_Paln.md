Week 4 Theme

Fabric Lakehouse + Spark (PySpark basics) + Delta + Medallion + Orchestration

Week 4 end-state (big picture)

By Friday you will have:

A Fabric Workspace + Lakehouse

Your customers data loaded into the Lakehouse as Delta tables

A medallion layout (Bronze/Silver/Gold) implemented as Delta tables

A Fabric Pipeline that runs a Notebook activity to refresh Silver/Gold

A GitHub “Week 4” folder with notebooks exported + runbook + screenshots

Day 1 — Fabric workspace + Lakehouse + load data
Study (60–90 min)

Fabric “Get started” path (skim, focus on Lakehouse + how components fit). 
Microsoft Learn

Tutorial: Create a lakehouse, ingest sample data, and build a report (we’ll do the lakehouse + ingest part today). 
Microsoft Learn

Tutorial: How to use a notebook to load data into your lakehouse. 
Microsoft Learn

Hands-on (2.5–3.5 hrs)

Create / open Fabric workspace (or reuse if you already have one). 
Microsoft Learn

Create a Lakehouse in that workspace.

Load your customers.csv into the lakehouse Files area.

Create a notebook and connect it to the lakehouse. 
Microsoft Learn

In notebook: read CSV → write to Delta table bronze_customers.

Notebook skeleton (PySpark)

df = spark.read.option("header", "true").csv("Files/customers.csv")
df.write.mode("overwrite").format("delta").saveAsTable("bronze_customers")

Deliverables (end of Day 1)

bronze_customers Delta table exists in Lakehouse

GitHub:

project/week4-fabric/day1-notes.md

project/week4-fabric/screenshots/day1_lakehouse_created.png

src/fabric/notebooks/day1_bronze_customers.ipynb (export notebook)

Day 2 — Delta table fundamentals + Silver layer transform
Study (60–90 min)

Fabric Lakehouse + Delta overview. 
Microsoft Learn

Microsoft Learn module: Work with Delta Lake tables in Microsoft Fabric. 
Microsoft Learn

Optional video session (learn-live): Delta tables in Fabric. 
Microsoft Learn

Hands-on (2.5–3.5 hrs)

Create silver_customers as cleaned/typed version:

enforce types (customer_id int, signup_date date)

trim / standardize name

Add data quality basics (null checks) in notebook and output a small “DQ summary” dataframe.

Example transform

from pyspark.sql.functions import col, trim, to_date

bronze = spark.table("bronze_customers")
silver = (bronze
          .withColumn("customer_id", col("customer_id").cast("int"))
          .withColumn("name", trim(col("name")))
          .withColumn("signup_date", to_date(col("signup_date"))))

silver.write.mode("overwrite").format("delta").saveAsTable("silver_customers")

Deliverables (end of Day 2)

silver_customers Delta table created

GitHub:

src/fabric/notebooks/day2_silver_transform.ipynb

project/week4-fabric/day2-data-quality.md (what checks you did + why)

project/week4-fabric/screenshots/day2_silver_table.png

Day 3 — Gold layer + BI-friendly shapes
Study (45–75 min)

Re-read Delta/Lakehouse concepts: why Delta is the preferred table format in Fabric, and how it integrates across Fabric items. 
Microsoft Learn
+1

Hands-on (3–4 hrs)

Build gold_customers_dim (BI-friendly dimension):

add signup_year, signup_month_start

ensure no null customer_id

Build a simple aggregate gold_customer_signups_by_month.

Example

from pyspark.sql.functions import year, month, trunc

silver = spark.table("silver_customers")

gold_dim = (silver
            .filter(col("customer_id").isNotNull())
            .withColumn("signup_year", year(col("signup_date")))
            .withColumn("signup_month_start", trunc(col("signup_date"), "month")))

gold_dim.write.mode("overwrite").format("delta").saveAsTable("gold_customers_dim")

gold_agg = (gold_dim.groupBy("signup_month_start")
            .count()
            .withColumnRenamed("count","customers_signed_up"))

gold_agg.write.mode("overwrite").format("delta").saveAsTable("gold_customer_signups_by_month")

Deliverables (end of Day 3)

gold_customers_dim + gold_customer_signups_by_month Delta tables exist

GitHub:

src/fabric/notebooks/day3_gold_layer.ipynb

project/week4-fabric/day3-gold-serving.md (how this maps to BI-ready layer)

project/week4-fabric/screenshots/day3_gold_tables.png

Day 4 — Orchestration: Fabric Pipeline + Notebook activity
Study (45–75 min)

Fabric pipeline activity overview (concepts). 
Microsoft Learn

Notebook activity documentation (how to run notebooks via pipeline). 
Microsoft Learn

Decision guide (when to use Copy vs Dataflow vs Spark). 
Microsoft Learn

Hands-on (3–4 hrs)

Create a Fabric Pipeline.

Add Notebook activity to run your notebook that builds Silver/Gold (or split into two notebook activities).

Configure notebook parameters (optional): run_mode=full.

Run pipeline manually and confirm tables refresh.

Deliverables (end of Day 4)

A Fabric pipeline that successfully runs notebook(s) and refreshes Silver/Gold

GitHub:

project/week4-fabric/day4-pipeline-runbook.md (how to run + monitor)

project/week4-fabric/screenshots/day4_pipeline_success.png

src/fabric/pipelines/day4_pipeline_notes.md (export if you can; otherwise document steps + screenshots)

Day 5 — Delta performance + housekeeping + Week 4 release
Study (45–60 min)

Delta optimization concepts in Fabric module (OPTIMIZE/VACUUM concepts; follow what Fabric supports). 
Microsoft Learn
+1

Hands-on (3–4 hrs)

Measure and document:

row counts across Bronze/Silver/Gold

basic query timing comparisons (small dataset is fine; focus on methodology)

(If supported in your environment) run basic Delta maintenance steps or document what you would do in production.

Create a Week 4 README summarizing what you built + architecture diagram (simple draw.io).

Deliverables (end of Day 5)

GitHub:

project/week4-fabric/performance-notes.md

project/week4-fabric/week4-summary.md

project/week4-fabric/architecture/week4_fabric_lakehouse.png

PR merged: week4-fabric-lakehouse → main

Tag a release: week4-v1

GitHub commits (daily pattern)

Use one branch for the week:

git checkout -b week4-fabric-lakehouse
# commit each day
git add .
git commit -m "feat(week4-dayX): <what you built>"
git push --set-upstream origin week4-fabric-lakehouse

Week 4 Deliverables (final checklist)

 Fabric Lakehouse created + data loaded via notebook 
Microsoft Learn
+1

 Bronze/Silver/Gold Delta tables implemented 
Microsoft Learn
+1

 Pipeline runs Notebook activity to refresh tables 
Microsoft Learn
+1

 Repo has notebooks, runbooks, screenshots, summary
