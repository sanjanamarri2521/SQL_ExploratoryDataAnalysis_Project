-- ==============================================
-- Reporting
-- ==============================================

-- ==============================================
-- Product Report
-- ============================================== 
-- Purpose:
--	- This report consolidates key product metrics and behaviours

-- Highlights:
--	1. Gather essential fields such as product name, category, subcategory and cost.
--	2. Segments prodcuts by revenue to identify High-Performers, Mid-Range, or Low-Performers.
--	3. Aggregates product-level metrics:
--		- total orders
--		- total sales
--		- total quantity sold
--		- total customers
--		- lifespan (in months)
--	4. Calculates valuable KPIs:
--		- recency (months since last order)
--		- average order value (AOR)
--		- average monthly spend
-- ==============================================
IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
    DROP VIEW gold.report_products;
GO
CREATE VIEW gold.report_products AS
WITH base_query AS (
-- 1. Base query to retrive core columns from the tables
SELECT 
s.customer_key,
s.order_number,
s.order_date,
s.sales_amount,
s.quantity,
p.product_key,
p.product_number,
p.product_name,
p.category,
p.subcategory,
p.cost
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
),

product_aggregate AS (
-- 2. Customer aggregations: Summarizes key metrics at the product level
SELECT 
product_key,
product_number,
product_name,
category,
subcategory,
cost,
MAX(order_date) AS last_order,
COUNT(DISTINCT customer_key) AS total_customers,
COUNT(DISTINCT order_number) AS total_orders,
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity
FROM base_query
GROUP BY product_key,
product_number,
product_name,
category,
subcategory,
cost
)

SELECT 
product_key,
product_number,
product_name,
category,
subcategory,
cost,
total_customers,
total_orders,
lifespan,
total_sales,
total_quantity,
CASE WHEN total_sales > 50000 THEN 'High Performer'
	 WHEN total_sales BETWEEN 10000 AND 50000 THEN 'Mid Range'
	 ELSE 'Low Performer'
END AS product_segment,
DATEDIFF(month, last_order, GETDATE()) AS recency,
-- Compute average order revenue (AOR)
CASE WHEN total_sales = 0 THEN 0
	 ELSE total_sales/total_orders
END AS average_order_revenue,
-- Compute average monthly revenue
CASE WHEN lifespan = 0 THEN total_sales
	 ELSE total_sales/lifespan
END AS average_montly_revenue
FROM product_aggregate

