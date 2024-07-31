{{ config(
    materialized='table'
) }}

WITH sales_freight_data AS (
  SELECT 
    product_id,
    price,
    freight_value
  FROM {{ ref('order_items') }}
)
SELECT 
  CORR(price, freight_value) AS sales_freight_correlation
FROM sales_freight_data
