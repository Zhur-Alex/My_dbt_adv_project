{%- set yaml_metadata -%}
source_model: 'store_20250313_181244'
derived_columns:
  store_pk: 'store_pk::text' 
  shop_name: 'name::text'
  shop_address: 'address::text'
  city: 'city::text'
  load_datetime: 'current_timestamp::text'
  record_source: "'stg_source'"
  effective_from: 'current_timestamp::text'
hashed_columns:
  str_hashdiff:
    is_hashdiff: true
    columns:
      - shop_name
      - shop_address 
      - city
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
    store_pk, 
    shop_name, 
    shop_address, 
    city,
    load_datetime,
    record_source,
    str_hashdiff,
    effective_from
FROM staged_data

