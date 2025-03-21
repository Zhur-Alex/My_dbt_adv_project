{%- set yaml_metadata -%}
source_model: 'ord_20250313_181256'
derived_columns:
  order_pk: 'order_pk::text'
  order_date: 'order_date::text'
  customer_pk: 'customer_pk::text'
  product_pk: 'product_pk::text'
  store_pk: 'store_pk::text'
  quantity: 'quantity::text'
  status: 'status::text'
  load_datetime: 'current_timestamp::text'
  record_source: "'stg_source'"
  effective_from: 'current_timestamp::text'
hashed_columns:
  ord_hashdiff:
    is_hashdiff: true
    columns:
      - order_pk
      - order_date
      - quantity 
      - status
  order_customer_shop_pk:
    - order_pk
    - customer_pk
    - store_pk
  order_product_pk:
    - order_pk
    - product_pk
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}

{% set derived_columns = metadata_dict['derived_columns'] %}

{% set hashed_columns = metadata_dict['hashed_columns'] %}


WITH order_data AS (
    {{ automate_dv.stage(
        include_source_columns=true,
        source_model=source_model,
        derived_columns=derived_columns,
        hashed_columns=hashed_columns,
        ranked_columns=none
    ) }}
)

SELECT 
    order_pk, 
    order_date, 
    customer_pk, 
    product_pk, 
    store_pk, 
    quantity, 
    status,
    encode(order_customer_shop_pk, 'hex') AS order_customer_shop_pk,
    encode(order_product_pk, 'hex') AS order_product_pk,
    load_datetime,
    record_source,
    ord_hashdiff, 
    effective_from
FROM order_data


