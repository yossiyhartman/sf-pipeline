CREATE OR REPLACE PROCEDURE LANDING.LOAD_EMPLOYEES()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    COPY INTO LANDING.EMPLOYEES
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
        FROM @LANDING.NORTHWIND_STAGE/employees.csv
    )
    ON_ERROR = abort_statement
    FILE_FORMAT = (FORMAT_NAME = LANDING.NORTHWIND_CSV_INGESTION_FORMAT);

    RETURN 'Loaded LANDING.EMPLOYEES';
END;
$$;
