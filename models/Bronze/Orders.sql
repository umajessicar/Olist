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
 FROM `olist-428220.OlistCustomers.Orders`
