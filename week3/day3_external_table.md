### CETAS Folder Requirement (Important)

When using CETAS in Synapse Serverless:
- The target LOCATION must NOT exist before execution
- Even empty folders cause CETAS to fail
- CETAS always creates the target folder itself

Correct pattern:
- Use versioned or timestamped folders
- Never manually create CETAS target directories


Week3-Step3.4
SELECT TOP 5 *
From OPENROWSET(
    BULK 'https://datalaked700chgptweek1.dfs.core.windows.net/raw/customers/customers.csv',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    FIRSTROW = 2
    ) as test;

Week3-Step3.5
create DATABASE customer360_analytics;
go

use customer360_analytics;
go

Step3.6
create EXTERNAL data SOURCE eds_datalake
WITH(
    LOCATION = 'https://datalaked700chgptweek1.dfs.core.windows.net'

);
GO

Step3.7
CREATE EXTERNAL FILE FORMAT eff_csv
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR =',',
        STRING_DELIMITER ='"',
        FIRST_ROW = 2
    )
);
GO

Step3.8
CREATE EXTERNAL TABLE dbo.ext_customers_csv
(
    customer_id INT,
    name VARCHAR(100),
    signup_date DATE
)

with (
    LOCATION = '/raw/customers/',
    DATA_SOURCE = eds_datalake,
    FILE_FORMAT = eff_csv
);
GO

select count (*) from dbo.ext_customers_csv

Step3.9
CREATE EXTERNAL FILE FORMAT eff_parquet
WITH 
(
    FORMAT_TYPE = PARQUET
);
go

CREATE EXTERNAL TABLE dbo.ext_customers_parquet
WITH (
    LOCATION = '/clean/customers/',
    DATA_SOURCE = eds_datalake,
    FILE_FORMAT = eff_parquet
)
AS
SELECT * FROM dbo.ext_customers_csv;
GO
