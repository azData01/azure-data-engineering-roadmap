Below is a very clear click-by-click guide in ADF Studio (from Azure Portal), for BOTH patterns:

Pattern A (recommended): parameterise the dataset (folder + file name)

Pattern B: parameterise the Copy activity source/sink (less reusable)

I’ll focus on Pattern A because it’s the cleanest and what you want for a reusable ingestion framework.

✅ Pattern A — Parameterise the Dataset (Recommended)
Step 0 — Open ADF Studio

Azure Portal → open your Data Factory resource

Click Launch Studio (or “Open Azure Data Factory Studio”)

Step 1 — Create pipeline parameters

Left menu → Author (pencil icon)

Open your pipeline (e.g. pl_ingest_customers or pl_ingest_generic)

Click on the empty canvas (so pipeline properties appear)

In the right pane → Parameters → + New

p_sourceFolder (String)

p_fileName (String)

p_sinkFolder (String) (optional but useful)

Example values (for testing):

p_sourceFolder = raw/customers (or wherever your source is)

p_fileName = customers.csv

p_sinkFolder = raw/customers

Step 2 — Add parameters to your Source Dataset (ADLS / file)

You need your dataset to accept dynamic values.

2.1 Open the dataset

In the pipeline, click your Copy data activity

Go to the Source tab

Next to Source dataset, click the dataset name (hyperlink)

This opens the dataset definition

2.2 Create dataset parameters

In the dataset editor, click the Parameters tab (top of dataset editor)

Click + New

p_folderPath (String)

p_fileName (String)

Step 3 — Set dataset “Location” dynamically (this is the missing part)

Still inside the dataset editor:

Click the Connection tab (top of dataset editor)

Look for File path section (wording varies depending on dataset type):

Container

Directory

File
(or “Folder path” / “File name”)

3.1 Make Directory dynamic

In the Directory box, click Add dynamic content (small link under the box)

In the expression editor, enter:

@dataset().p_folderPath


Click Finish

3.2 Make File dynamic

In the File box (or File name), click Add dynamic content

Enter:

@dataset().p_fileName


Click Finish

✅ Now your dataset points to a dynamic folder + file.

If you don’t see “Directory” and “File”, you might be using a dataset type like Binary/DelimitedText where the UI labels differ. The concept is identical: set the folder field to @dataset().p_folderPath and file field to @dataset().p_fileName.

Step 4 — Pass pipeline parameters into the dataset (back in the Copy activity)

Now you must “feed” the dataset parameters from the pipeline.

Click the pipeline tab again

Select your Copy data activity

Go to Source tab

Under your Source dataset, find Parameters (it appears once dataset has params)

Set values like this:

p_folderPath = Add dynamic content →

@pipeline().parameters.p_sourceFolder


p_fileName = Add dynamic content →

@pipeline().parameters.p_fileName

Step 5 — Repeat for Sink Dataset (ADLS destination)

Do the same for the sink dataset:

Copy activity → Sink tab

Click sink dataset name to open it

Add dataset parameter: p_folderPath (String)

In dataset Connection tab:

Directory → @dataset().p_folderPath

File name (optional) → you can either:

Keep same name as source: @dataset().p_fileName (add param), OR

Use a fixed file name, OR

Write to a folder only (common for parquet output)

Back in pipeline → Sink tab → dataset parameters:

@pipeline().parameters.p_sinkFolder

Step 6 — Debug run with parameters

Click Debug (top toolbar in pipeline)

Fill the pipeline parameters popup:

p_sourceFolder = raw/customers

p_fileName = customers.csv

p_sinkFolder = raw/customers

Run and verify in ADLS Gen2.

✅ Quick sanity check (common mistakes)

If ADF says it can’t find the file:

Your folder path might need to be without leading slash

Use: raw/customers not /raw/customers

If the dataset “Parameters” section doesn’t show in Copy activity:

You didn’t add parameters in the dataset, only in the pipeline

If you can’t see “Add dynamic content”:

Click inside the Directory/File box and look under it; the link appears contextually
