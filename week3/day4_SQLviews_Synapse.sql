--Week3 - Day4



CREATE OR ALTER VIEW dbo.vw_customers
AS
SELECT
    customer_id,
    name,
    signup_date,
    CAST(signup_date AS DATE) AS signup_date_clean,
    DATEFROMPARTS(YEAR(signup_date), MONTH(signup_date), 1) AS signup_month_start,
    YEAR(signup_date) AS signup_year,
    MONTH(signup_date) AS signup_month
FROM dbo.ext_customers_clean;
GO

select top 10 * from dbo.vw_customers


CREATE OR ALTER View dbo.vw_customer_signups_by_month
AS
select
signup_month_start,
count(*) as customers_signed_up
from dbo.vw_customers
group by signup_month_start;
GO

select * from dbo.vw_customer_signups_by_month

IF NOT EXISTS (SELECT 1 from sys.schemas where name ='serving')
BEGIN
    exec('create schema serving');
END
Go


CREATE OR ALTER VIEW serving.vw_customers
AS
SELECT * FROM dbo.vw_customers;
GO

CREATE OR ALTER VIEW serving.vw_customer_signups_by_month
AS
SELECT * FROM dbo.vw_customer_signups_by_month;
GO