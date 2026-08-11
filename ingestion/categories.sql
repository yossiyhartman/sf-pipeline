create or replace table NORTHWIND_DEV.LANDING.CATEGORIES (
    CATEGORYID INTEGER primary key,
    CATEGORYNAME VARCHAR(100),
    DESCRIPTION STRING,
    PICTURE STRING
);
copy into NORTHWIND_DEV.LANDING.CATEGORIES
from
(
    select
        $1,
        $2,
        $3,
        $4
    from
        @NORTHWIND_DEV.LANDING.NORTHWIND_STAGE/categories.csv
) on_error = abort_statement
file_format
= (format_name = NORTHWIND_DEV.LANDING.NORTHWIND_CSV_INGESTION_FORMAT);