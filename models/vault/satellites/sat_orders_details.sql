{{
    config(
        materialized='incremental',
        unique_key='order_pk',
        incremental_strategy='merge'
    )
}}

{%- set source_model = 'v_stg_orders' -%}
{%- set src_pk = 'order_pk' -%}
{%- set src_hashdiff = 'ord_hashdiff' -%}
{%- set src_payload = [
    'order_pk',
    'order_date',
    'quantity', 
    'status'
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
    order_pk, 
    order_date, 
    quantity, 
    status,
    encode(ord_hashdiff, 'hex') AS order_hashdiff, {# Приводим хеш к нормальному виду (избавились от bytea) #}
    load_datetime,
    record_source,
    ord_hashdiff, 
    effective_from
FROM customers_data
