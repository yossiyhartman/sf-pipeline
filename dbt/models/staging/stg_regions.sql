SELECT
    REGIONID AS REGION_ID,
    DESCRIPTION

FROM {{ source('northwind', 'regions') }}
