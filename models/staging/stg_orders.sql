{{
    config(
        materialized = 'view'
    )
}}

select
    order_pk, 
    order_date, 
    customer_pk, 
    product_pk, 
    store_pk, 
    quantity, 
    status
from
    {{ source('stg_sources', 'ord_20250313_181256') }}
