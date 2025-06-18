-- ==============================================
-- Cumulative Analysis Exploration
-- ==============================================
-- Calculate the total sales per month and the running total of sales over time

SELECT
order_date,
total_sales,
SUM(total_sales) OVER (PARTITION BY YEAR(order_date) ORDER BY order_date) AS cummilative_sales
FROM (
SELECT 
DATETRUNC(month, order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
) t
-- Insight: There is huge drop in sales in the last year in the data i.e 2014 compared to the starting sales in other years.

-- Calculate the total sales per month and the moving average of price over time
SELECT
order_date,
avg_price,
AVG(avg_price) OVER (PARTITION BY YEAR(order_date) ORDER BY order_date) AS moving_avg_price
FROM (
SELECT 
DATETRUNC(month, order_date) AS order_date,
AVG(price) AS avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
) t
-- Insight: There is a drop in average price from 2012.
