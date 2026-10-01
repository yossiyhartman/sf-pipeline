CREATE OR REPLACE PROCEDURE LANDING.LOAD_ORDERS()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    COPY INTO LANDING.ORDERS
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
            $14
        FROM @LANDING.NORTHWIND_STAGE/orders.csv
    )
    ON_ERROR = abort_statement
    FILE_FORMAT = (FORMAT_NAME = LANDING.NORTHWIND_CSV_INGESTION_FORMAT);

    RETURN 'Loaded LANDING.ORDERS';
END;
$$;
