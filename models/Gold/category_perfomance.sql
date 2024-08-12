WITH category_performance AS (
  SELECT
    p.product_category_name AS Category_Name,
    COUNT(oi.order_id) AS Total_Purchases,  -- Frequência de compras
    SUM(oi.price * oi.order_item_id) AS Total_Revenue  -- Receita total
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
  Total_Purchases,
  Total_Revenue
FROM
  category_performance
ORDER BY
  Total_Revenue DESC,  -- Ordenar por receita total, ou
  Total_Purchases DESC -- Alternativamente, ordenar por frequência de compras
