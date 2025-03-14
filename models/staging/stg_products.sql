{{
    config(
        materialized = 'view'
    )
}}

select
    product_pk, 
    brand, 
    product_name, 
    category, 
    price
from
    {{ source('stg_sources', 'prdct_20250313_181244') }}
