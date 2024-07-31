WITH store_sales AS (
  SELECT 
    seller_id AS store_id,
    SUM(price) AS total_sales,
    AVG(freight_value) AS avg_freight_value
  FROM {{ ref('order_items') }}
  GROUP BY seller_id
)
SELECT 
  store_id,
  total_sales,
  avg_freight_value,
  CASE
    WHEN total_sales > 100000 THEN 'Large'
    WHEN total_sales BETWEEN 50000 AND 100000 THEN 'Medium'
    ELSE 'Small'
  END AS store_size
FROM store_sales
