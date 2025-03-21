{%- set yaml_metadata -%}
source_model: 'prdct_20250313_181244'
derived_columns:
  product_pk: 'product_pk::text' 
  brand: 'brand::text'
  product_name: 'product_name::text'
  category: 'category::text'
  price: 'price::text'
  load_datetime: 'current_timestamp::text'
  record_source: "'stg_source'"
  effective_from: 'current_timestamp::text'
hashed_columns:
  prdct_hashdiff:
    is_hashdiff: true
    columns:
      - brand
      - product_name 
      - category
      - price
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
    product_pk, 
    brand, 
    product_name, 
    category, 
    price,
    load_datetime,
    record_source,
    prdct_hashdiff, 
    effective_from
FROM staged_data

