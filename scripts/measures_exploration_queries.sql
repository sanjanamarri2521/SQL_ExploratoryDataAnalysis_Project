/*
Measures Exploration: Using SUM, AVG, and COUNT to compute overall sales metrics
*/
-- =====================================
-- Measures Exploration
-- =====================================
-- Find the Total Sales
SELECT SUM(sales_amount) AS total_sales
FROM gold.fact_sales 

-- Find how may items are sold
SELECT SUM(quantity) AS total_items_sold
FROM gold.fact_sales 

-- Find the average selling price
SELECT AVG(price) AS average_selling_price 
FROM gold.fact_sales

-- Find the Total number of orders
SELECT  COUNT(DISTINCT order_number) AS total_orders 
FROM gold.fact_sales

-- Find the total number of products
SELECT  COUNT(DISTINCT product_key) AS total_products 
FROM gold.dim_products

-- Find the total number of customers
SELECT  COUNT(DISTINCT customer_key) AS total_customers
FROM gold.dim_customers

-- Find the total number of customers that has placed an order
SELECT  COUNT(DISTINCT customer_key) AS total_customers_placed_order
FROM gold.fact_sales

-- Report that shows all key metrics
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT 'Total Items Sold' AS measure_name, SUM(quantity) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT 'Average Selling Price' AS measure_name, AVG(price) AS measure_value 
FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT 'Total Products' AS measure_name, COUNT(DISTINCT product_key) AS measure_value 
FROM gold.dim_products
UNION ALL
SELECT 'Total Customers' AS measure_name, COUNT(DISTINCT customer_key) AS measure_value
FROM gold.dim_customers
UNION ALL
SELECT 'Total Customers that placed order' AS measure_name, COUNT(DISTINCT customer_key) AS measure_value
FROM gold.fact_sales
