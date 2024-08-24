WITH customer_activity AS (
    SELECT 
        customer_id,
        DATE_DIFF(DATE '2018-10-17', MAX(purchase_date), DAY) AS days_since_last_order,
        COUNT(order_id) AS total_orders
    FROM 
        {{ ref('silver_table') }}
    GROUP BY 
        customer_id
),
customer_risk AS (
    SELECT 
        customer_id,
        days_since_last_order,
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
        COUNT(customer_id) AS number_of_customers
    FROM 
        customer_risk
    GROUP BY 
        churn_risk
)
SELECT 
    churn_risk,
    number_of_customers
FROM 
    risk_summary
ORDER BY 
    number_of_customers DESC


