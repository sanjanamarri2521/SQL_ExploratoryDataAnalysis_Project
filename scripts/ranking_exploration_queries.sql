/*
Ranking Exploration: Using TOP (e.g., TOP 5, TOP 10) to identify best and worst performers
*/
-- =====================================
-- Ranking Exploration
-- =====================================
-- Which 5 products generate highest revenue
SELECT TOP 5 p.product_name, SUM(s.sales_amount) AS total_revenue 
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

-- What are the 5 worst performing products in terms of sales
SELECT TOP 5 p.product_name, SUM(s.sales_amount) AS total_revenue 
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.product_name
ORDER BY total_revenue

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10 c.customer_key, c.first_name, c.last_name, SUM(s.sales_amount) AS total_revenue 
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON c.customer_key = s.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_revenue DESC

-- 3 customers with the fewest orders placed
SELECT TOP 3 c.customer_key, c.first_name, c.last_name, COUNT(DISTINCT s.order_number) AS total_orders
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON c.customer_key = s.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_orders 
