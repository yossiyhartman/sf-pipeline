SELECT
    TERRITORYID AS TERRITORY_ID,
    DESCRIPTION,
    REGIONID    AS REGION_ID

FROM {{ source('northwind', 'territories') }}
