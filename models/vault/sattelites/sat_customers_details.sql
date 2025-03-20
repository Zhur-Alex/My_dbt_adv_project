{{
    config(
        materialized='table'
    )
}}

{%- set source_model = "v_stg_customers" -%}
{%- set src_pk = "customer_pk" -%}
{%- set src_hashdiff = "hashdiff" -%}
{%- set src_payload = ["first_name", "last_name", "email", "phone_number", "address"] -%}
{%- set src_ldts = "load_datetime" -%}
{%- set src_source = "record_source" -%}

{{ automate_dv.sat(
    src_pk=src_pk,
    src_hashdiff=src_hashdiff,
    src_payload=src_payload,
    src_ldts=src_ldts,
    src_source=src_source,
    source_model=source_model
) }}