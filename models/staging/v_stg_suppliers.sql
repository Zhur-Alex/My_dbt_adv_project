{%- set yaml_metadata -%}
source_model: 'sup_20250313_181244'
derived_columns:
  supplier_pk: 'supplier_pk::text' 
  company_name: 'company_name::text'
  brand: 'brand::text'
  country: 'country::text'
  load_datetime: 'current_timestamp::text'
  record_source: "'stg_source'"
  effective_from: 'current_timestamp::text'
hashed_columns:
  suppl_hashdiff:
    is_hashdiff: true
    columns:
      - company_name
      - brand 
      - country
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
    supplier_pk, 
    company_name, 
    brand, 
    country,
    load_datetime,
    record_source,
    suppl_hashdiff,
    effective_from
FROM staged_data

