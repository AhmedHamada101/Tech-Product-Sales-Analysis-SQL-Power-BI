-- 1. Cleaning, Deleting, and Adding some columns: -

-- Display all data of the products table:
SELECT * FROM Products;


-- Drop 'column1' from the table:
ALTER TABLE 
	Products 
DROP COLUMN 
	column1;


-- Display the table after dropping 'column1' from it:
SELECT * FROM Products;


-- Create new columns named Day_Name and Month_Name in the Products Table:
ALTER TABLE
	Products
ADD 
	Day_Name VARCHAR(5),
	Month_Name VARCHAR(15);


-- Insert the extracted day and month names in Day_Name and  Month_Name columns:
UPDATE
	Products
SET
	Day_Name = FORMAT(Order_Date, 'ddd'),
	Month_Name = DATENAME(mm, Order_Date);


-- Update the Month_Name column by replacing the full name of the month with the first three characters: 
UPDATE
	Products
SET
	Month_Name = SUBSTRING(Month_Name, 1, 3);


-- Display the table after adding two columns:
SELECT * FROM Products;


--------------------------------------------------------------------------------------------------------------------------------


-- 2. Some of the KPIs: -

-- 2.1. What are the total orders?
SELECT 
	COUNT(DISTINCT Order_ID) AS Total_Orders
FROM 
	Products;


-- 2.2. What is the total sales?
SELECT 
	ROUND(SUM(Sales), 2) AS Total_Sales
FROM 
	Products;


-- 2.3. What is the average price of the order?
SELECT
	ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS Avg_Order_Price
FROM 
	Products;


-- 2.4. What are the total products sold?
SELECT 
	SUM(Quantity_Ordered) AS Total_Products_Sold
FROM 
	Products;


-- 2.5. What is the average of products sold per order?
SELECT 
	ROUND(CAST(SUM(Quantity_Ordered) AS float) / CAST(COUNT(DISTINCT Order_ID) AS float), 2) AS Avg_Products_Per_Order
FROM 
	Products;


-- 2.6. How many types of products?
SELECT 
	COUNT(DISTINCT Product) AS Total_Types_Product
FROM 
	Products;


--------------------------------------------------------------------------------------------------------------------------------


-- 3. Exploratory Data Analysis: -

-- 3.1. What are total orders by daily trend?
SELECT
	Day_Name,
	COUNT(DISTINCT Order_ID) AS Total_Orders
FROM
	Products
GROUP BY
	Day_Name
ORDER BY
	Total_Orders DESC;


-- 3.2. What are total orders by monthly trend?
SELECT
	Month_Name,
	COUNT(DISTINCT Order_ID) AS Total_Orders
FROM
	Products
GROUP BY
	Month_Name
ORDER BY
	Total_Orders DESC;


-- 3.3. What are the total and ratio of orders in each hour?
SELECT
	Hour,
	COUNT(DISTINCT Order_ID) AS Total_Orders,
	ROUND(CAST(COUNT(DISTINCT Order_ID) * 100 AS FLOAT) / (SELECT COUNT(DISTINCT Order_ID) FROM Products), 2) AS PCT_Orders
FROM
	Products
GROUP BY
	Hour
ORDER BY
	Total_Orders DESC;


-- 3.4. What are the total and ratio of orders per city?
SELECT
	City,
	COUNT(DISTINCT Order_ID) AS Total_Orders,
	ROUND(CAST(COUNT(DISTINCT Order_ID) * 100 AS FLOAT) / (SELECT COUNT(DISTINCT Order_ID) FROM Products), 2) AS PCT_Orders
FROM
	Products
GROUP BY
	City
ORDER BY
	Total_Orders DESC;


-- 3.5. What are the total and ratio of products sold per product?
SELECT
	Product,
	SUM(Quantity_Ordered) AS Total_Quantity_Sold,
	ROUND(CAST(SUM(Quantity_Ordered) * 100 AS FLOAT) / (SELECT SUM(Quantity_Ordered) FROM Products), 2) AS PCT_Quantity_Sold
FROM 
	Products
GROUP BY
	Product
ORDER BY
	Total_Quantity_Sold DESC;


-- 3.6. What is the price of each product?
SELECT 
	DISTINCT Product,
	ROUND(Price_Each, 2) AS Price
FROM	
	Products
ORDER BY
	Price DESC;


-- 3.7. What are the total and ratio of sales per product?
SELECT
	Product,
	ROUND(SUM(Sales), 2) AS Total_Sales,
	ROUND(SUM(Sales) * 100  / (SELECT SUM(Sales) FROM Products), 2) AS PCT_Sales
FROM
	Products
GROUP BY
	Product
ORDER BY
	Total_Sales DESC;


-- 3.8. What are total sales by daily trend?
SELECT
	Day_Name,
	ROUND(SUM(Sales), 2) AS Total_Sales
FROM
	Products
GROUP BY
	Day_Name
ORDER BY
	Total_Sales DESC;


-- 3.9. What are total sales by monthly trend?
SELECT
	Month_Name,
	ROUND(SUM(Sales), 2) AS Total_Sales
FROM
	Products
GROUP BY
	Month_Name
ORDER BY
	Total_Sales DESC;


-- 3.10. What are the total sales in each hour?
SELECT
	Hour,
	ROUND(SUM(Sales), 2) AS Total_Sales
FROM
	Products
GROUP BY
	Hour
ORDER BY
	Total_Sales DESC;


-- 3.11. What are the total and ratio of sales per city?
SELECT
	City,
	ROUND(SUM(Sales), 2) AS Total_Sales,
	ROUND(SUM(Sales) * 100  / (SELECT SUM(Sales) FROM Products), 2) AS PCT_Sales
FROM
	Products
GROUP BY
	City
ORDER BY
	Total_Sales DESC;


-- 3.10. What are the total and ratio of sales per product?
SELECT
	Product,
	ROUND(SUM(Sales), 2) AS Total_Sales,
	ROUND(SUM(Sales) * 100  / (SELECT SUM(Sales) FROM Products), 2) AS PCT_Sales
FROM
	Products
GROUP BY
	Product
ORDER BY
	Total_Sales DESC;


-- 3.11 What are the 5 best-selling products by sales?
SELECT TOP 5
	Product,
	ROUND(SUM(Sales), 2) AS Total_Sales
FROM
	Products
GROUP BY
	Product
ORDER BY
	Total_Sales DESC;


-- 3.12 What are the 5 lowest-selling products by sales?
SELECT TOP 5
	Product,
	ROUND(SUM(Sales), 2) AS Total_Sales
FROM
	Products
GROUP BY
	Product
ORDER BY
	Total_Sales ASC;


-- 3.13. What are the 5 best-selling products by quantity?
SELECT TOP 5
	Product,
	SUM(Quantity_Ordered) AS Total_Quantity
FROM
	Products
GROUP BY
	Product
ORDER BY
	Total_Quantity DESC;


-- 3.14. What are the 5 lowest-selling products by quantity?
SELECT TOP 5
	Product,
	SUM(Quantity_Ordered) AS Total_Quantity
FROM
	Products
GROUP BY
	Product
ORDER BY
	Total_Quantity ASC;


-- 3.15. What are the 5 best-selling products by order?
SELECT TOP 5
	Product,
	COUNT(DISTINCT Order_ID) AS Total_Orders
FROM
	Products
GROUP BY
	Product
ORDER BY
	Total_Orders DESC;


-- 3.16. What are the 5 lowest-selling products by order?
SELECT TOP 5
	Product,
	COUNT(DISTINCT Order_ID) AS Total_Orders
FROM
	Products
GROUP BY
	Product
ORDER BY
	Total_Orders ASC;



