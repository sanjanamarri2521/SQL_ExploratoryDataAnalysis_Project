# Exploratory Data Analysis on Cleaned Sales Data from Data Warehouse Project

This project presents a focused **Exploratory Data Analysis (EDA)** using SQL on the cleaned datasets from the [Data Warehouse Project](https://github.com/sanjanamarri2521/SQL_DataWarehouse_Project). The primary goal is to extract early business insights and understand data distribution, customer patterns, and product performance.

---

## Datasets

All cleaned datasets used in this EDA are available in the [`datasets/`](https://github.com/sanjanamarri2521/SQL_ExploratoryDataAnalysis_Project/tree/main/datasets) folder of the original data warehouse repository.

---

## Objectives

This analysis explores multiple dimensions of the dataset to answer relevant business questions using SQL queries.

---

##  Areas of Exploration
### 1. Database Exploration
- Explored all tables and columns to understand database structure and metadata
- Key SQL functions used:
  - `INFORMATION_SCHEMA.TABLES` – List all database tables and views
  - `INFORMATION_SCHEMA.COLUMNS` – List columns and details for specific tables

**Sample Insight**:
- Verified table structures to guide further data queries and analysis

### 2. Dimensions Exploration
- Identified unique values in key dimension fields like countries and product categories
- Key SQL functions used:
  - `DISTINCT` – Extract unique entries in columns for categorical analysis

**Sample Insight**:
- Found diverse customer origins and detailed product classifications to support segmentation

### 3. Date Exploration
- Analyzed order date ranges and customer ages to understand time coverage and demographics
- Key SQL functions used:
  - `MIN()`, `MAX()` – Identify earliest and latest dates
  - `DATEDIFF()` – Calculate difference in years and months
  - `GETDATE()` – Current date for age calculation

**Sample Insight**:
- Confirmed sales data spans multiple years and identified the age range of customers

### 4. Measures Exploration
- Calculated key performance metrics like total sales, items sold, average price, orders, and customer/product counts
- Key SQL functions used:
  - Aggregations: `SUM()`, `AVG()`, `COUNT(DISTINCT)`

**Sample Insight**:
- Provides a summary of overall sales volume, pricing, and customer engagement metrics

### 5. Magnitude Exploration
- Measured totals and averages by key divisions such as country, gender, and product category
- Assessed revenue and sales distribution across dimensions
- Key SQL functions used:
  - Aggregations: `COUNT()`, `COUNT(DISTINCT)`, `SUM()`, `AVG()`
  - `GROUP BY` and `ORDER BY` for segmentation and ranking

**Sample Insight**:
- Identified leading countries and categories by customer count and revenue, highlighting core markets and products

### 6. Ranking Exploration
- Identified top and bottom performers among products and customers by revenue and order counts
- Key SQL clauses/functions used:
  - `TOP` for limiting results
  - Aggregations: `SUM()`, `COUNT(DISTINCT)`
  - `GROUP BY` and `ORDER BY` for ranking

**Sample Insight**:
- Highlighted best-selling and underperforming products
- Revealed highest revenue-generating customers and those with minimal orders





### 7. Change Over Time Analysis
- Sales trends analyzed by **year**, **month**, and **custom formats** to uncover seasonality and performance shifts
- Identified annual and monthly performance highs and lows
- Key SQL functions used:
  - `YEAR()`, `MONTH()` – Extract date parts for grouping
  - `DATETRUNC()` – Monthly truncation for timeline grouping
  - `FORMAT()` – Display `yyyy-MMM` format for reporting
  - Aggregations: `SUM()`, `COUNT(DISTINCT)`

**Sample Insights**:
- *2013* had the highest total sales, customers, and items sold
- *December* consistently showed peak performance, suggesting seasonal effects (e.g., holidays)

### 8. Cumulative Analysis
- Analyzed **running totals** and **moving averages** to observe sales progression and pricing trends over time
- Cumulative sales calculated per month within each year
- Moving average of prices computed to identify long-term pricing trends

**Key SQL functions used**:
- `SUM(...) OVER (PARTITION BY ... ORDER BY ...)` – Running total of sales
- `AVG(...) OVER (PARTITION BY ... ORDER BY ...)` – Moving average of price
- `DATETRUNC()` – For monthly aggregation

**Sample Insights**:
-  Sales dropped significantly in the final year (*2014*) compared to earlier years
-  Average price steadily declined after *2012*, indicating possible discounting or market shift

### 9. Performance Analysis
- Compared yearly sales of each product against their historical average and previous year’s sales
- Helps identify products that are improving, declining, or staying consistent in performance

**Key SQL functions used**:
- `AVG(...) OVER (PARTITION BY ...)` – To compute product's average yearly sales
- `LAG(...) OVER (PARTITION BY ... ORDER BY ...)` – To compare with previous year’s sales
- `CASE WHEN` – For classifying changes (e.g., Increase, Decrease, Above/Below Average)

**Sample Insights**:
-  Some products showed consistent **year-over-year growth**
-  Others dropped **below their average** or declined compared to previous years

### 10. Part-to-Whole Analysis
- Evaluated the contribution of each product category to overall sales
- Helps in identifying dominant product lines and revenue concentration

**Key SQL functions used**:
- `SUM(...) OVER ()` – Total across entire result set
- `ROUND(...)`, `CAST(...)` – For percentage calculation
- `CONCAT(...)` – To format percentage values

**Sample Insight**:
-  The **Bikes** category accounted for **96%** of total sales, indicating a highly skewed product portfolio

### 11. Data Segmentation
- Categorized products into cost-based segments and grouped customers by spending and longevity

**Key SQL functions used**:
- `CASE WHEN` – For defining segmentation logic
- `DATEDIFF(...)` – To calculate customer lifespan
- `GROUP BY`, `COUNT(...)` – For frequency distribution of segments

**Sample Insights**:
-  Most products fall in the **“Below 100”** cost segment
-  Majority of customers are **“New”**, indicating limited long-term customer retention

### 12. Reporting

- Developed two consolidated reports: one for customers and one for products
- Created using SQL views for scalable, reusable reporting logic

####  Customer Report
- Aggregates customer behavior and demographics
- Includes:
  - Total orders, quantity, sales, lifespan
  - Customer segments (VIP, Regular, New)
  - Age grouping, recency, average order value (AOV), and average monthly spend

####  Product Report
- Summarizes product performance and engagement
- Includes:
  - Total customers, orders, quantity sold, sales, lifespan
  - Product segments (High Performer, Mid Range, Low Performer)
  - Recency, average order revenue (AOR), and average monthly revenue

**Key SQL Techniques**:
- `CASE WHEN` for segmentation logic
- `DATEDIFF(...)`, `AVG(...)`, `SUM(...)` for KPIs
- SQL Views (`CREATE VIEW`) for modularized reporting


---

##  Tools Used

- SQL Server Express
- SQL Server Management Studio (SSMS)
- Cleaned SQL tables from the Gold Layer of the Data Warehouse project
- GitHub for version control and documentation

---

##  Acknowledgment

Special thanks to **Baraa Khatib Salkini** (YouTube: *Data with Baraa*) whose guidance through the tutorial *“SQL Exploratory Data Analysis (EDA) Project | Full Hands-On Portfolio Project”* helped shape this analysis approach.

---

##  Related Project

- [Data Warehouse Project](https://github.com/sanjanamarri2521/SQL_DataWarehouse_Project)

## Acknowledgments

Special thanks to **Baraa Khatib Salkini**, an IT professional and YouTuber with channel [Data with Baraa](https://www.youtube.com/@DatawithBaraa), whose video tutorials [**"SQL Exploratory Data Analysis (EDA) Project | Full Hands-On Portfolio Project"**](https://www.youtube.com/watch?v=6cJ5Ji8zSDg&list=PLNcg_FV9n7qZ4Ym8ZriYT6WF8TaC2e_R7&index=4) and [**"SQL Data Analyst Portfolio Project | Like I Do in My Real Projects"**](https://www.youtube.com/watch?v=2jGhQpbzHes) provided valuable guidance throughout the development of this project.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
