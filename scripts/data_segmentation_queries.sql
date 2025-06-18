-- ==============================================
-- Data Segmentation Analysis Exploration
-- ==============================================
-- Segment products into cost ranges and count how many products fall into each segment
WITH product_segments AS (
SELECT 
product_key,
product_name,
cost,
CASE WHEN cost < 100 THEN 'Below 100'
	 WHEN cost BETWEEN 100 AND 500 THEN '100-500'
	 WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
	 ELSE 'Above 1000'
END AS cost_range
FROM gold.dim_products
)

SELECT 
cost_range,
COUNT(product_key) AS count_products
FROM product_segments
GROUP BY cost_range
ORDER BY COUNT(product_key) DESC
-- Insight: The number of products below the cost of 100 is highest

-- Group customers into three segments base don spending behaviour
-- VIP: Atleat 12 months of history and spending more than 5000
-- Regular: Atleast 12 months of history and spending less than 5000
-- New: Lifespan less than 12 months

WITH customer_segments AS (
SELECT 
c.customer_key,
SUM(s.sales_amount) AS total_spending,
MIN(s.order_date) AS first_order,
MAX(s.order_date) AS last_order,
DATEDIFF (month, MIN(s.order_date),MAX(s.order_date)) AS lifespan
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY c.customer_key
),

cust_seg AS (
SELECT 
customer_key,
CASE WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
	 WHEN lifespan >= 12 AND total_spending < 5000 THEN 'Regular'
	 ELSE 'New'
END AS membership
FROM customer_segments
)

SELECT 
membership,
COUNT(customer_key)
FROM cust_seg
GROUP BY membership
ORDER BY COUNT(customer_key) DESC
-- Insight: There are many 'New' customers who have life span of less than 12 months. Lesser loyal/returning customers.




