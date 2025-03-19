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
    price,
    current_timestamp as load_datetime,     {# время загрузки #}
    'stg_sources' as record_source          {# источник загрузки #}
from
    {{ source('stg_sources', 'prdct_20250313_181244') }}
