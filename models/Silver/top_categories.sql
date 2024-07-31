WITH order_counts AS (
  SELECT
    p.product_category_name AS Category_Name,
    COUNT(oi.order_id) AS Purchases
  FROM
    {{ ref('order_items') }} oi
  JOIN
    {{ ref('Products') }} p
  ON
    oi.product_id = p.product_id
  GROUP BY
    p.product_category_name
)

SELECT
  Category_Name,
  Purchases
FROM
  order_counts
ORDER BY
  Purchases DESC
LIMIT 10


