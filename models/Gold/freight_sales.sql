WITH average_freight AS (
    SELECT 
        AVG(freight_value) AS avg_freight_value
    FROM 
        {{ ref('silver_table') }}
),
sales_analysis AS (
    SELECT
        product_id,
        product_category_name,
        price,
        freight_value,
        CASE
            WHEN price <= 100 THEN 'Low'
            WHEN price BETWEEN 100 AND 500 THEN 'Medium'
            ELSE 'High'
        END AS price_range,
        CASE
            WHEN freight_value <= af.avg_freight_value THEN 'Low'
            ELSE 'High'
        END AS freight_range
    FROM 
        {{ ref('silver_table') }} s
    CROSS JOIN 
        average_freight af
)
SELECT
    price_range,
    freight_range,
    SUM(price) AS total_sales,
    COUNT(DISTINCT product_id) AS total_products,
    AVG(price) AS avg_price_per_product,
    AVG(freight_value) AS avg_freight_value,
    SUM(price) / NULLIF(COUNT(DISTINCT product_id), 0) AS avg_sales_per_product
FROM 
    sales_analysis
GROUP BY 
    price_range,
    freight_range
ORDER BY 
    price_range,
    freight_range,
    total_sales DESC
