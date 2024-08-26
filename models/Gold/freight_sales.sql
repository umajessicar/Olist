WITH average_freight AS (
    SELECT 
        AVG(freight_value) AS avg_freight_value
    FROM 
        {{ ref('silver_table') }}
),
freight_ranges AS (
    SELECT 
        s.product_id,
        s.product_category_name,
        CASE
            WHEN s.freight_value <= af.avg_freight_value THEN 'Low'
            ELSE 'High'
        END AS freight_range,
        s.freight_value
    FROM 
        {{ ref('silver_table') }} s
    CROSS JOIN 
        average_freight af
),
sales_analysis AS (
    SELECT
        fr.freight_range,
        SUM(s.price) AS total_sales,
        COUNT(DISTINCT s.product_id) AS total_products
    FROM 
        {{ ref('silver_table') }} s
    JOIN 
        freight_ranges fr ON s.product_id = fr.product_id
    GROUP BY 
        fr.freight_range
)
SELECT
    freight_range,
    total_sales,
    total_products,
    total_sales / NULLIF(total_products, 0) AS avg_sales_per_product
FROM 
    sales_analysis
ORDER BY 
    total_sales DESC

