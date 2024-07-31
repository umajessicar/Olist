SELECT 
  oi.product_id,
  p.product_category_name,
  SUM(oi.price) AS total_sales,
  AVG(oi.price) AS avg_order_value,
  AVG(oi.freight_value) AS avg_freight_value
FROM {{ ref('order_items') }} oi
JOIN {{ ref('Products') }} p ON oi.product_id = p.product_id
GROUP BY oi.product_id, p.product_category_name
