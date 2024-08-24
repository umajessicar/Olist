WITH orders AS (
    SELECT 
        order_id,
        customer_id,
        order_status,
        DATE(order_purchase_timestamp) AS purchase_date,
        TIME(order_purchase_timestamp) AS purchase_time,
        DATE(order_approved_at) AS order_approved_date,
        TIME(order_approved_at) AS order_approved_time,
        DATE(order_delivered_carrier_date) AS carrier_delivered_date,
        TIME(order_delivered_carrier_date) AS carrier_delivered_time,
        DATE(order_delivered_customer_date) AS delivered_customer_date,
        TIME(order_delivered_customer_date) AS delivered_customer_time,
        DATE(order_estimated_delivery_date) AS estimated_delivery_date,
        TIME(order_estimated_delivery_date) AS estimated_delivery_time
    FROM 
       {{ ref('Orders') }}
),
customers AS (
    SELECT
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state
    FROM
        {{ ref('customers') }}
),
order_items AS (
    SELECT
        order_id,
        product_id,
        seller_id,
        shipping_limit_date,
        price,
        freight_value
    FROM
        {{ ref('order_items') }}
),
products AS (
    SELECT
        product_id,
        product_category_name
    FROM
        {{ ref('Products') }}
),
reviews AS (
    SELECT
        review_id,
        order_id,
        review_score,
        review_comment_title,
        review_comment_message,
        review_creation_date,
        review_answer_timestamp
    FROM
        {{ ref('Reviews') }}
)
SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    o.order_status,
    o.purchase_date,
    o.purchase_time,
    o.order_approved_date,
    o.order_approved_time,
    o.carrier_delivered_date,
    o.carrier_delivered_time,
    o.delivered_customer_date,
    o.delivered_customer_time,
    o.estimated_delivery_date,
    o.estimated_delivery_time,
    oi.product_id,
    p.product_category_name,
    oi.price,
    oi.freight_value,
    r.review_id,
    r.review_score,
    r.review_comment_title,
    r.review_comment_message,
    r.review_creation_date,
    r.review_answer_timestamp
FROM
    orders o
LEFT JOIN
    customers c ON o.customer_id = c.customer_id
LEFT JOIN
    order_items oi ON o.order_id = oi.order_id
LEFT JOIN
    products p ON oi.product_id = p.product_id
LEFT JOIN
    reviews r ON o.order_id = r.order_id

