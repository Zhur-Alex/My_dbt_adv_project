{{
    config(
        materialized='incremental',
        unique_key='store_pk',
        incremental_strategy='merge'
    )
}}

{%- set source_model = 'v_stg_shops' -%}
{%- set src_pk = 'store_pk' -%}
{%- set src_hashdiff = 'str_hashdiff' -%}
{%- set src_payload = [
    'store_pk', 
    'shop_name', 
    'shop_address', 
    'city'
] -%}
{%- set src_ldts = 'load_datetime' -%}
{%- set src_source = 'record_source' -%}
{%- set src_extra_columns = ['effective_from'] -%}

WITH customers_data AS (
    {{ automate_dv.sat(
        src_pk=src_pk,
        src_hashdiff=src_hashdiff,
        src_payload=src_payload,
        src_ldts=src_ldts,
        src_source=src_source,
        source_model=source_model,
        src_extra_columns=src_extra_columns
    ) }}
)

SELECT 
    store_pk, 
    shop_name, 
    shop_address, 
    city,
    encode(str_hashdiff, 'hex') AS store_hashdiff, {# Приводим хеш к нормальному виду (избавились от bytea) #}
    load_datetime,
    record_source,
    str_hashdiff, 
    effective_from
FROM customers_data
