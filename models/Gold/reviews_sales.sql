{{ config(
    materialized='table'
) }}

WITH product_sales AS (
  SELECT 
    s.product_id,
    SUM(CAST(s.price AS FLOAT64)) AS total_sales
  FROM {{ ref('silver_table') }} s
  GROUP BY s.product_id
),
product_reviews AS (
  SELECT 
    s.product_id,
    AVG(CAST(s.review_score AS FLOAT64)) AS avg_rating,
    COUNT(s.review_id) AS total_reviews
  FROM {{ ref('silver_table') }} s
  GROUP BY s.product_id
),
high_sales_low_satisfaction AS (
  SELECT 
    ps.product_id,
    ps.total_sales,
    pr.avg_rating,
    pr.total_reviews,
    'Low Satisfaction' AS satisfaction_category
  FROM product_sales ps
  JOIN product_reviews pr ON ps.product_id = pr.product_id
  WHERE ps.total_sales > 10000 AND pr.avg_rating < 3.0
),
high_sales_high_satisfaction AS (
  SELECT 
    ps.product_id,
    ps.total_sales,
    pr.avg_rating,
    pr.total_reviews,
    'High Satisfaction' AS satisfaction_category
  FROM product_sales ps
  JOIN product_reviews pr ON ps.product_id = pr.product_id
  WHERE ps.total_sales > 10000 AND pr.avg_rating >= 4
),
medium_satisfaction AS (
  SELECT 
    ps.product_id,
    ps.total_sales,
    pr.avg_rating,
    pr.total_reviews,
    'Medium Satisfaction' AS satisfaction_category
  FROM product_sales ps
  JOIN product_reviews pr ON ps.product_id = pr.product_id
  WHERE ps.total_sales > 10000 AND pr.avg_rating BETWEEN 3.0 AND 4.0
),
all_satisfaction AS (
  SELECT * FROM high_sales_low_satisfaction
  UNION ALL
  SELECT * FROM high_sales_high_satisfaction
  UNION ALL
  SELECT * FROM medium_satisfaction
)
SELECT 
  satisfaction_category,
  SUM(total_sales) AS total_sales,
  COUNT(DISTINCT product_id) AS total_products,
  AVG(total_sales) AS avg_sales_per_product,
  SUM(total_reviews) AS total_reviews
FROM all_satisfaction
GROUP BY satisfaction_category
ORDER BY total_sales DESC




