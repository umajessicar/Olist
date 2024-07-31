{{ config(
    materialized='view'
) }}

SELECT 
  s.store_size,
  p.product_category_name,
  SUM(oi.price) AS total_sales,
  AVG(oi.price) AS avg_order_value,
  AVG(oi.freight_value) AS avg_freight_value,
  pc.product_count
FROM {{ ref('sales') }} s
JOIN {{ ref('order_items') }} oi ON s.store_id = oi.seller_id
JOIN {{ ref('Products') }} p ON oi.product_id = p.product_id
JOIN {{ ref('products_count') }} pc ON s.store_id = pc.store_id
GROUP BY s.store_size, p.product_category_name, pc.product_count
ORDER BY s.store_size, total_sales DESC
