SELECT
    ORDERID   AS ORDER_ID,
    PRODUCTID AS PRODUCT_ID,
    UNITPRICE AS UNIT_PRICE,
    QUANTITY,
    DISCOUNT

FROM {{ source('northwind', 'order_details') }}
