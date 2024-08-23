SELECT 
  seller_id AS store_id,
  COUNT(DISTINCT product_id) AS product_count
FROM {{ ref('order_items') }}
GROUP BY seller_id