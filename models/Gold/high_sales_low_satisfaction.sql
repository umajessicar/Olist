-- models/gold/products_high_sales_low_satisfaction.sql
{{ config(
    materialized='table'
) }}

WITH product_sales AS (
  SELECT 
    oi.product_id,
    SUM(oi.price) AS total_sales
  FROM {{ ref('order_items') }} oi
  GROUP BY oi.product_id
),
product_reviews AS (
  SELECT 
    oi.product_id,
    AVG(CAST(r.review_score AS FLOAT64)) AS avg_rating
  FROM {{ ref('order_items') }} oi
  JOIN {{ ref('Reviews') }} r ON oi.order_id = r.order_id
  GROUP BY oi.product_id
)
SELECT 
  ps.product_id,
  ps.total_sales,
  pr.avg_rating
FROM product_sales ps
JOIN product_reviews pr ON ps.product_id = pr.product_id
WHERE ps.total_sales > 10000 AND pr.avg_rating < 3.0
ORDER BY ps.total_sales DESC
