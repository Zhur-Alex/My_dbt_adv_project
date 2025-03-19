{{
    config(
        materialized = 'view'
    )
}}

select
    customer_pk, 
    first_name, 
    last_name, 
    email, 
    phone_number::varchar(12) as phone_number, 
    registration_date, 
    address,
    current_timestamp as load_datetime,     {# время загрузки #}
    'stg_sources' as record_source          {# источник загрузки #}

from
    {{ source('stg_sources', 'cust_20250313_181244') }}
