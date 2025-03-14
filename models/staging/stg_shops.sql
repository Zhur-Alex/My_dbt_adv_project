{{
    config(
        materialized = 'view'
    )
}}

select
    store_pk, 
    name, 
    address, 
    city
from
    {{ source('stg_sources', 'store_20250313_181244') }}
