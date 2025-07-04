-- ==============================================
-- Reporting
-- ==============================================

-- ==============================================
-- Customer Report
-- ============================================== 
-- Purpose:
--	- This report consolidated key customer metrics and behaviours

-- Highlights:
--	1. Gather essential fields such as names, ages, and transaction details.
--	2. Segment customers into categories (VIP, Regular, New) and age groups.
--	3. Aggregates customer-level metrics:
--		- total orders
--		- total sales
--		- total quantity purchased
--		- total products
--		- lifespan (in months)
--	4. Calculates valuable KPIs:
--		- recency (months since last order)
--		- average order value
--		- average monthly spend
-- ==============================================
IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO
CREATE VIEW gold.report_customers AS
WITH base_query AS (
-- 1. Base query to retrive core columns from the tables
SELECT 
s.product_key,
s.order_number,
s.order_date,
s.sales_amount,
s.quantity,
c.customer_key,
c.customer_number,
CONCAT(c.first_name,' ', c.last_name) AS customer_name,
DATEDIFF(year, c.birthdate, GETDATE()) AS age
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
WHERE order_date IS NOT NULL
),

customer_aggregation AS (
-- 2. Customer aggregations: Summarizes key metrics at the customer level
SELECT 
customer_key,
customer_number,
customer_name,
age,
COUNT(DISTINCT product_key) AS total_products,
COUNT(DISTINCT order_number) AS total_orders,
MAX(order_date) AS last_order,
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity
FROM base_query
GROUP BY customer_key,
customer_number,
customer_name,
age
)

SELECT 
customer_key,
customer_number,
customer_name,
age,
CASE WHEN age < 20 THEN 'Under 20'
	 WHEN age BETWEEN 20 AND 29 THEN '20-29'
	 WHEN age BETWEEN 30 AND 39 THEN '30-39'
	 WHEN age BETWEEN 40 AND 49 THEN '40-49'
	 ELSE '50 and Above'
END AS age_group,
total_products,
total_orders,
lifespan,
total_sales,
total_quantity,
last_order,
CASE WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
	 WHEN lifespan >= 12 AND total_sales < 5000 THEN 'Regular'
	 ELSE 'New'
END AS customer_segment,
DATEDIFF(month, last_order, GETDATE()) AS recency,
-- Compute average order value (AOV)
CASE WHEN total_sales = 0 THEN 0
	 ELSE total_sales/total_orders
END AS average_order_value,
-- Compute average monthly spend
CASE WHEN lifespan = 0 THEN total_sales
	 ELSE total_sales/lifespan
END AS average_montly_spend
FROM customer_aggregation



