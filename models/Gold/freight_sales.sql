WITH freight_ranges AS (
  SELECT 
    ps.product_id,
    ps.product_category_name,
    CASE
      WHEN ps.avg_freight_value <= (SELECT AVG(avg_freight_value) FROM {{ ref('products_sales') }}) THEN 'Low'
      ELSE 'High'
    END AS freight_range,
    ps.avg_freight_value
  FROM {{ ref('products_sales') }} ps
),
sales_analysis AS (
  SELECT
    fr.freight_range,
    SUM(ps.total_sales) AS total_sales,
    COUNT(ps.product_id) AS total_products
  FROM {{ ref('products_sales') }} ps
  JOIN freight_ranges fr ON ps.product_id = fr.product_id
  GROUP BY fr.freight_range
)
SELECT
  freight_range,
  total_sales,
  total_products,
  total_sales / NULLIF(total_products, 0) AS avg_sales_per_product
FROM sales_analysis
ORDER BY total_sales DESC
