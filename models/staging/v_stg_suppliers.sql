{{
    config(
        materialized = 'view'
    )
}}

select
    supplier_pk, 
    company_name, 
    brand, 
    country,
    current_timestamp as load_datetime,     {# время загрузки #}
    'stg_sources' as record_source          {# источник загрузки #}
from
    {{ source('stg_sources', 'sup_20250313_181244') }}
