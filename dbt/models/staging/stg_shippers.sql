SELECT
    SHIPPERID   AS SHIPPER_ID,
    COMPANYNAME AS COMPANY_NAME,
    PHONE

FROM {{ source('northwind', 'shippers') }}
