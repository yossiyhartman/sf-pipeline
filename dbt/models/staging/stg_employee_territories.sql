SELECT
    EMPLOYEEID  AS EMPLOYEE_ID,
    TERRITORYID AS TERRITORY_ID

FROM {{ source('northwind', 'employee_territories') }}
