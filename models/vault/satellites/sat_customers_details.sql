{{
    config(
        materialized='incremental',
        unique_key='customer_pk',
        incremental_strategy='merge'
    )
}}

{%- set source_model = 'v_stg_customers' -%}
{%- set src_pk = 'customer_pk' -%}
{%- set src_hashdiff = 'cust_hashdiff' -%}
{%- set src_payload = [
    'first_name',
    'last_name',
    'email',
    'phone_number',
    'registration_date',
    'cust_address'
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
    customer_pk,
    encode(cust_hashdiff, 'hex') as customer_hashdiff,
    first_name,
    last_name,
    email,
    phone_number,
    registration_date,
    cust_address,
    load_datetime,
    record_source,
    cust_hashdiff,
    effective_from
FROM customers_data
