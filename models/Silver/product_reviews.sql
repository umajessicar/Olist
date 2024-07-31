SELECT 
  oi.product_id,
  COUNT(*) AS comment_count,
  AVG(CAST(r.review_score AS FLOAT64)) AS avg_rating
FROM {{ ref('order_items') }} oi
JOIN {{ ref('Reviews') }} r ON oi.order_id = r.order_id
GROUP BY oi.product_id

