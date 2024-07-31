{{ config(
    materialized='table'
) }}

SELECT 
  EXTRACT(MONTH FROM o.purchase_date) AS month,
  p.product_category_name,
  SUM(oi.price) AS total_sales
FROM {{ ref('Orders') }} o
JOIN {{ ref('order_items') }} oi ON o.order_id = oi.order_id
JOIN {{ ref('Products') }} p ON oi.product_id = p.product_id
GROUP BY month, p.product_category_name

