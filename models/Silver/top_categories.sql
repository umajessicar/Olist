WITH category_sales AS (
  SELECT
    p.product_category_name AS Category_Name,
    SUM(oi.price * oi.order_item_id) AS Total_Revenue
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
  Total_Revenue
FROM
  category_sales
ORDER BY
  Total_Revenue DESC




