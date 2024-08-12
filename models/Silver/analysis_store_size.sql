WITH store_size_mapping AS (
  SELECT
    store_id,
    CASE 
      WHEN LOWER(store_size) = 'small' THEN 1
      WHEN LOWER(store_size) = 'medium' THEN 250
      WHEN LOWER(store_size) = 'large' THEN 1000
      ELSE 0
    END AS store_size_numeric
  FROM `olist-428220`.`dbt_olist`.`sales`
)

SELECT 
  CASE 
    WHEN ssm.store_size_numeric <= 100 THEN 'small'
    WHEN ssm.store_size_numeric BETWEEN 101 AND 500 THEN 'medium'
    ELSE 'large'
  END AS store_size_group,
  p.product_category_name,
  SUM(oi.price) AS total_sales,
  AVG(oi.price) AS avg_order_value,
  AVG(oi.freight_value) AS avg_freight_value,
  pc.product_count
FROM store_size_mapping ssm
JOIN `olist-428220`.`dbt_olist`.`order_items` oi ON ssm.store_id = oi.seller_id
JOIN `olist-428220`.`dbt_olist`.`Products` p ON oi.product_id = p.product_id
JOIN `olist-428220`.`dbt_olist`.`products_count` pc ON ssm.store_id = pc.store_id
GROUP BY store_size_group, p.product_category_name, pc.product_count
ORDER BY store_size_group, total_sales DESC


