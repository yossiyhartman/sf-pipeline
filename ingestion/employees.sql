CREATE OR REPLACE TABLE NORTHWIND_DEV.LANDING.EMPLOYEES (
    EMPLOYEEID integer PRIMARY KEY,
    LASTNAME varchar(100),
    FIRSTNAME varchar(100),
    TITLE varchar(100),
    TITLEOFCOURTESY varchar(100),
    BIRTHDATE datetime,
    HIREDATE datetime,
    ADDRESS varchar(100),
    CITY varchar(100),
    REGION varchar(100),
    POSTALCODE varchar(100),
    COUNTRY varchar(100),
    HOMEPHONE varchar(100),
    "EXTENSION" varchar(100),
    PHOTO STRING,
    NOTES STRING,
    REPORTSTO varchar(100),
    PHOTOPATH STRING

);


COPY INTO NORTHWIND_DEV.LANDING.EMPLOYEES
FROM
(
    SELECT
        $1,
        $2,
        $3,
        $4,
        $5,
        $6,
        $7,
        $8,
        $9,
        $10,
        $11,
        $12,
        $13,
        $14,
        $15,
        $16,
        $17,
        $18
    FROM @NORTHWIND_DEV.LANDING.NORTHWIND_STAGE/employees.csv
)
ON_ERROR = abort_statement
FILE_FORMAT = (FORMAT_NAME = NORTHWIND_DEV.LANDING.NORTHWIND_CSV_INGESTION_FORMAT);
