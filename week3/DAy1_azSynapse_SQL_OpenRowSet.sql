SELECT top 10 *
FROM   OPENROWSET(
    BULK 'https://datalaked700chgptweek1.blob.core.windows.net/raw/customers/customers.csv',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    FIRSTROW = 2
) as rows;