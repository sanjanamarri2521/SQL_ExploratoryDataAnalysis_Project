/*
Date Exploration: Using MIN, MAX, and DATEDIFF to analyze date ranges and customer age
*/
-- =====================================
-- Date Exploration
-- =====================================
-- Find the date of first and last order
SELECT MIN(order_date) AS first_order_date, MAX(order_date) AS last_order_date FROM gold.fact_sales

-- How many years of sales are available
SELECT DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_years FROM gold.fact_sales

-- How many months of sales are available
SELECT DATEDIFF(month, MIN(order_date), MAX(order_date)) AS order_range_months FROM gold.fact_sales

-- Find the youngest and oldest customer
SELECT 
MIN(birthdate) AS oldest_birthdate, 
DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
MAX(birthdate) AS youngest_birthdate,
DATEDIFF(year, max(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers
