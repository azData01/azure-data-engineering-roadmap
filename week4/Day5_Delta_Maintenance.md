“Delta maintenance” is a bit fuzzy in Fabric because some Delta operations are available (and some aren’t) depending on the engine/capacity. In a pay-as-you-go/free/trial setup, you can still do meaningful maintenance; you just need to focus on what’s actually supported.

Below is a step-by-step, do-this-now guide with two tracks:

Track A (Do it in Fabric Lakehouse — recommended)

Track B (If a command isn’t supported — document the production approach)

I’ll also give you the exact deliverable to add to GitHub for Week 4 Day 5.

What “Delta maintenance” means (in practice)

Delta tables need periodic housekeeping to:

Remove small files (improve performance)

Clean old versions / deleted files (reduce storage + avoid long history)

Ensure table stats are fresh (help query planning in engines that use them)

In Spark/Delta land these are usually:

OPTIMIZE (file compaction)

VACUUM (garbage collection of old files)

sometimes ANALYZE TABLE / stats (engine-dependent)

Track A — Do Delta maintenance in Fabric Lakehouse (step-by-step)
Step A1 — Open the notebook you’ll use for maintenance

Go to your Fabric Workspace

Open (or create) a notebook named:
nb_week4_day5_delta_maintenance

Make sure it is attached to your Lakehouse (top toolbar → Lakehouse → attach)

Step A2 — Identify your Delta tables and their storage paths

Run this in a cell:

tables = ["bronze_customers", "silver_customers", "gold_customers_dim", "gold_customer_signups_by_month"]

for t in tables:
    print("Table:", t)
    spark.sql(f"DESCRIBE DETAIL {t}").select("name","format","location","numFiles","sizeInBytes").show(truncate=False)

What to look for

numFiles (if very high, compaction matters more)

location (helps you confirm where Delta lives)

✅ Screenshot this output (it’s great evidence)

Step A3 — Compaction (OPTIMIZE) — try it

In many Spark environments you can run:

spark.sql("OPTIMIZE gold_customers_dim")
spark.sql("OPTIMIZE silver_customers")

If it succeeds:

✅ great — capture output + proceed.

If it fails with “unsupported”:

That’s fine — your environment doesn’t allow it. Move to Track B documentation for production.

Step A4 — Garbage collection (VACUUM) — try it

Try:

spark.sql("VACUUM gold_customers_dim RETAIN 168 HOURS")  # 7 days
spark.sql("VACUUM silver_customers RETAIN 168 HOURS")

Important safety rule (production best practice)

Don’t use very low retention unless you are sure time travel isn’t needed and no concurrent writes are happening.

7 days is a safe demo default.

Again, if VACUUM is unsupported, document it (Track B).

Step A5 — Re-check table stats (before/after evidence)

Run again:

for t in tables:
    spark.sql(f"DESCRIBE DETAIL {t}").select("name","numFiles","sizeInBytes").show(truncate=False)

What you’ll capture

If OPTIMIZE worked: numFiles may drop

If VACUUM worked: storage may reduce later (sometimes not instantly visible)

Track B — If OPTIMIZE/VACUUM are not supported, document the production approach

In some Fabric setups, you may not have these commands available, or they may behave differently.

If you get errors like:

“OPTIMIZE is not supported”

“VACUUM not allowed”

“Operation not permitted”

Then your Day 5 deliverable becomes:
✅ A tested attempt + ✅ a production runbook describing how you would do it.

What to do

Paste the error message into your notes

Document what you would do in production (below template)

Production-grade Delta maintenance approach (what you should write)
Step B1 — When to run maintenance

Run OPTIMIZE:

after heavy daily ingestion

when many small files are created

before BI peak usage hours

Run VACUUM:

weekly or monthly depending on retention needs

after ensuring no need for long time-travel

Step B2 — How to schedule it

Use Fabric Pipeline or Job:

Notebook activity runs OPTIMIZE/VACUUM commands

Trigger nightly/weekly

Step B3 — Safe retention policy

Default: 7–30 days depending on:

audit requirements

rollback requirements

incident recovery needs

✅ Your Week 4 Day 5 deliverable (GitHub)

Create:

project/week4-fabric/day5-delta-maintenance.md

Copy/paste template:
# Week 4 Day 5 — Delta Maintenance Notes (Fabric Lakehouse)

## Tables in scope
- bronze_customers
- silver_customers
- gold_customers_dim
- gold_customer_signups_by_month

## Baseline table details (DESCRIBE DETAIL)
Include screenshots or paste key fields:
- location
- numFiles
- sizeInBytes

## Maintenance actions attempted
### OPTIMIZE
Commands attempted:
- OPTIMIZE silver_customers
- OPTIMIZE gold_customers_dim

Result:
- (Succeeded / Not supported)
- Error message if failed

### VACUUM
Commands attempted:
- VACUUM silver_customers RETAIN 168 HOURS
- VACUUM gold_customers_dim RETAIN 168 HOURS

Result:
- (Succeeded / Not supported)
- Error message if failed

## Observations
- Changes in numFiles / sizeInBytes (if any)
- Expected benefits (query performance, cost)

## Production approach (if unsupported here)
- Schedule maintenance via Fabric pipeline (Notebook activity)
- Run OPTIMIZE after heavy ingestion
- Run VACUUM weekly/monthly with safe retention (7–30 days)
- Use monitoring and alerts for job failures


Also save screenshots to:
project/week4-fabric/screenshots/day5/

And export your maintenance notebook to:
src/fabric/notebooks/day5_delta_maintenance.ipynb

Commit:

git add project/week4-fabric/day5-delta-maintenance.md project/week4-fabric/screenshots/day5 src/fabric/notebooks/day5_delta_maintenance.ipynb
git commit -m "docs(week4-day5): delta maintenance attempts and production runbook"
git push

Quick check (so I tailor the exact commands)

When you run:

spark.sql("OPTIMIZE gold_customers_dim")


Do you get:

✅ it runs

❌ an “unsupported” error

❌ a permission/capacity error
