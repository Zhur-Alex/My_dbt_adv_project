{{
    config(
        materialized = 'view'
    )
}}

select
    store_pk, 
    name, 
    address, 
    city,
    current_timestamp as load_datetime,     {# время загрузки #}
    'stg_sources' as record_source          {# источник загрузки #}
from
    {{ source('stg_sources', 'store_20250313_181244') }}
