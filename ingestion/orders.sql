create
or replace table NORTHWIND_DEV.LANDING.REGIONS (
    REGIONID INTEGER primary key,
    DESCRIPTION varchar(50)
);
copy into NORTHWIND_DEV.LANDING.REGIONS
from
    (
        select
            $1,
            $2
        from
            @NORTHWIND_DEV.LANDING.NORTHWIND_STAGE/regions.csv
    ) on_error = abort_statement file_format = (
        format_name = NORTHWIND_DEV.LANDING.NORTHWIND_CSV_INGESTION_FORMAT
    );
