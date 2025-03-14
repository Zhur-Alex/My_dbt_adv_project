{{
    config(
        materialized = 'view'
    )
}}

select
    supplier_pk, 
    company_name, 
    brand, 
    country
from
    {{ source('stg_sources', 'sup_20250313_181244') }}
