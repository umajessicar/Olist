{{ config(
    materialized='table'
) }}

SELECT 
  ps.product_id,
  ps.product_category_name,
  ps.total_sales,
  ps.avg_order_value,
  ps.avg_freight_value,
  pc.comment_count,
  pc.avg_rating
FROM {{ ref('products_sales') }} ps
JOIN {{ ref('product_reviews') }} pc ON ps.product_id = pc.product_id
ORDER BY ps.total_sales DESC




