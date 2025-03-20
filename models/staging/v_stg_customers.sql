{%- set yaml_metadata -%}
source_model: 'cust_20250313_181244'
derived_columns:
  customer_pk: 'customer_pk::text'
  first_name: 'first_name::text'
  last_name: 'last_name::text'
  email: 'email::text'
  phone_number: 'phone_number::text'
  registration_date: 'registration_date::text'
  cust_address: 'address::text'
  load_datetime: 'current_timestamp::text'
  record_source: "'stg_source'"
  effective_from: 'registration_date::text'
hashed_columns:
  customer_hashdiff:
    is_hashdiff: true
    columns:
      - first_name
      - last_name
      - email
      - phone_number
      - registration_date
      - cust_address
      - effective_from
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}

{% set derived_columns = metadata_dict['derived_columns'] %}

{% set hashed_columns = metadata_dict['hashed_columns'] %}


WITH staged_data AS (
    {{ automate_dv.stage(
        include_source_columns=true,
        source_model=source_model,
        derived_columns=derived_columns,
        hashed_columns=hashed_columns,
        ranked_columns=none
    ) }}
)

SELECT 
    customer_pk,
    first_name,
    last_name,
    email,
    phone_number,
    registration_date,
    cust_address,
    encode(customer_hashdiff, 'hex') AS customer_hashdiff, {# Приводим хеш к нормальному виду (избавились от bytea) #}
    load_datetime,
    record_source,
    effective_from
FROM staged_data

