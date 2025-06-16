/*
Dimensions Exploration: Using DISTINCT to explore unique categorical values
*/
-- =====================================
-- Dimensions Exploration
-- =====================================
-- Explore all the countries the customers come from
SELECT DISTINCT country FROM gold.dim_customers

-- Explore all the categories "The major divisions"
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1,2,3
