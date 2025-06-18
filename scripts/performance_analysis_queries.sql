-- ==============================================
-- Performance Analysis Exploration
-- ==============================================
-- Analyse the yearly performance of products by comparing their sales to both the average sales performance of the product and the previous year's sales
WITH yearly_product_sales AS (
SELECT 
YEAR(s.order_date) AS order_year,
p.product_name,
SUM(s.sales_amount) AS current_sales
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
WHERE s.order_date IS NOT NULL
GROUP BY YEAR(s.order_date), p.product_name
)

SELECT 
order_year,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Average'
	 WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Average'
	 ELSE 'Average'
END AS avg_change,
-- Year over year analysis
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS prev_sales,
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_prev,
CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
	 WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
	 ELSE 'No Change'
END AS prev_change
FROM yearly_product_sales
ORDER BY product_name, order_year
--Insights: Observe change in average sales for a product in year and also comparing the change with previous year sales
