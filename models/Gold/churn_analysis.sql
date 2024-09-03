WITH customer_activity AS (
    SELECT 
        customer_id,
        DATE_DIFF(DATE '2018-10-17', MAX(purchase_date), DAY) AS days_since_last_order,
        COUNT(order_id) AS total_orders,
        AVG(CAST(price AS FLOAT64)) AS avg_order_value,
        AVG(DATE_DIFF(CAST(delivered_customer_date AS DATE), CAST(purchase_date AS DATE), DAY)) AS avg_delivery_time,
        AVG(CAST(review_score AS FLOAT64)) AS avg_review_score,
        SUM(CASE WHEN DATE_DIFF(CAST(delivered_customer_date AS DATE), CAST(estimated_delivery_date AS DATE), DAY) > 0 THEN 1 ELSE 0 END) AS late_delivery_count
    FROM 
        {{ ref('silver_table') }}
    GROUP BY 
        customer_id
),
customer_risk AS (
    SELECT 
        customer_id,
        days_since_last_order,
        total_orders,
        avg_order_value,
        avg_delivery_time,
        avg_review_score,
        late_delivery_count,
        CASE 
            WHEN days_since_last_order > 90 THEN 'High Risk'
            WHEN days_since_last_order BETWEEN 60 AND 90 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS churn_risk
    FROM 
        customer_activity
),
risk_summary AS (
    SELECT 
        churn_risk,
        COUNT(customer_id) AS number_of_customers,
        AVG(total_orders) AS avg_total_orders,
        AVG(avg_order_value) AS avg_order_value,
        AVG(avg_delivery_time) AS avg_delivery_time,
        AVG(avg_review_score) AS avg_review_score,
        AVG(late_delivery_count) AS avg_late_deliveries
    FROM 
        customer_risk
    GROUP BY 
        churn_risk
)
SELECT 
    churn_risk,
    number_of_customers,
    avg_total_orders,
    avg_order_value,
    avg_delivery_time,
    avg_review_score,
    avg_late_deliveries
FROM 
    risk_summary
ORDER BY 
    churn_risk DESC

