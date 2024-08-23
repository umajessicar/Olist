WITH order_counts AS (
  SELECT
    p.product_category_name,
    COUNT(oi.order_id) AS num_orders
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
  product_category_name
FROM
  order_counts
ORDER BY
  num_orders ASC
LIMIT 10
