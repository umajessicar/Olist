{{ config(
    materialized='table'
) }}

WITH product_reviews AS (
    SELECT
        product_id,
        COUNT(review_id) AS comment_count,
        AVG(CAST(review_score AS FLOAT64)) AS avg_rating
    FROM
        {{ ref('silver_table') }}
    GROUP BY
        product_id
)

SELECT 
    s.product_id,
    s.product_category_name,
    SUM(CAST(s.price AS FLOAT64)) AS total_sales,
    AVG(CAST(s.price AS FLOAT64)) AS avg_order_value,
    AVG(CAST(s.freight_value AS FLOAT64)) AS avg_freight_value,
    pr.comment_count,
    pr.avg_rating
FROM 
    {{ ref('silver_table') }} s
LEFT JOIN 
    product_reviews pr ON s.product_id = pr.product_id
GROUP BY
    s.product_id,
    s.product_category_name,
    pr.comment_count,
    pr.avg_rating
ORDER BY 
    total_sales DESC






