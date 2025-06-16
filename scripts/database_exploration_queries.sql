/*
Database Exploration: Using INFORMATION_SCHEMA to list all tables and columns
*/
-- =====================================
-- Database Exploration
-- =====================================

-- Explore All Objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Explore All Columns in the Databse
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'

