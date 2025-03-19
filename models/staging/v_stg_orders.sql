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
    status,
    current_timestamp as load_datetime,     {# время загрузки #}
    'stg_sources' as record_source,         {# источник загрузки #}
    {{ 
        hash(
            "order_pk || '-' || customer_pk || '-' || store_pk"
        ) 
    }} as order_customer_shop_pk,
    {{ 
        hash(
            "order_pk || '-' || product_pk"
        ) 
    }} as order_product_pk

from
    {{ source('stg_sources', 'ord_20250313_181256') }}
