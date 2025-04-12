create database salesanalysis;
SELECT * FROM SALES;

--================== PROJECT: ADVANCED SALES INSIGHTS - UNLOCKING DATA TRENDS ======================


-- Q1: FIND ALL ORDER SHIPPED VIA "ECONOMY" MADE WITH ATOTAL AMOUNT GREATER THAN 25000.

SELECT * FROM SALES 
WHERE SHIP_MODE = 'ECONOMY' AND TOTAL_AMOUNT > 25000;
.......................................................................................................................

-- Q2: Retrieve all sales data for 'Technology' category in 'Ireland' made after 2020-01-01.

SELECT * FROM SALES
WHERE CATEGORY = 'Technology' AND COUNTRY = 'IRELAND' AND ORDER_DATE > '2020-01-01'; 

.......................................................................................................
 
-- Q3: List the top 10 most profitable sales transactions in descending order.

SELECT TOP 10 * FROM SALES
ORDER BY Unit_Profit DESC;
........................................................................................................

-- Q4: Find all customers whose name starts with 'J' and ends with 'n'.

SELECT * FROM SALES
WHERE Customer_Name LIKE  'J%N';

................................................................................................................

-- Q5: Retrieve all product names that contain 'Acco' anywhere in the name.

SELECT * FROM SALES
WHERE Product_Name LIKE  '%ACCO%';

..................................................................................................................

-- 📌 Q6: Get the top 5 cities with the highest total sales amount.

SELECT TOP 5 CITY, SUM(TOTAL_AMOUNT) AS [TOTAL SALE AMOUNT] FROM SALES
GROUP BY City
ORDER BY SUM(TOTAL_AMOUNT) DESC ;

.....................................................................................................................

-- 📌 Q7: Display the second set of 10 records, including: Order_ID, City, Country, Region, Category, Total Amount
SELECT ORDER_ID, CITY, COUNTRY, REGION, CATEGORY, TOTAL_AMOUNT FROM SALES 
ORDER BY Order_ID
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

..........................................................................................................................

-- 📌 Q8: Find the total revenue, average unit cost, and total number of orders.

SELECT SUM(TOTAL_AMOUNT) AS [TOTAL REVENUE],
       AVG(UNIT_COST) AS [AVERAGE UNIT COST],
	   COUNT(ORDER_ID) AS [total number of order]
	   FROM SALES;																-- DESIRED COLUMN

..................................................................................................................

-- 📌 Q9: Get total sales per product category.

SELECT CATEGORY, SUM(TOTAL_AMOUNT) AS TOTAL_SALES
FROM SALES
GROUP BY Category
order by sum(TOTAL_AMOUNT) desc ;

...........................................................................................................................

--   Q10: Find the number of orders placed by each customer.
SELECT CUSTOMER_NAME, COUNT(ORDER_ID) AS ORDER_COUNT
FROM SALES
GROUP BY  CUSTOMER_NAME
ORDER BY order_count desc;

...........................................................................................................................

  -- Q11: Get customers who have placed orders worth more than ₹50,000 ?
SELECT CUSTOMER_NAME, SUM(TOTAL_AMOUNT) AS TOTAL_SPENT
FROM SALES
GROUP BY CUSTOMER_NAME
HAVING SUM(TOTAL_AMOUNT) > 50000
ORDER BY TOTAL_SPENT DESC;

..............................................................................................................................

--  🔹 Q12: Rank products based on total sales using RANK().
SELECT PRODUCT_NAME, SUM(TOTAL_AMOUNT) AS TOTAL_SALES,
	   RANK() OVER(ORDER BY SUM(TOTAL_AMOUNT) DESC) AS SALES_RANK
FROM SALES
GROUP BY Product_Name;

........................................................................................................................

  -- 🔹 Q13: Find the top 5 customers by sales revenue using DENSE_RANK().
SELECT TOP 5 PRODUCT_NAME, SUM(TOTAL_AMOUNT) AS TOTAL_SPENT,
	   DENSE_RANK() OVER(ORDER BY SUM(TOTAL_AMOUNT) DESC) AS TOP_RANK
FROM SALES
GROUP BY Product_Name
ORDER BY TOP_RANK;

........................................................................................................................

 -- 🔹 Q14: Use a CTE to find the top 3 most sold product categories.
WITH CATEGORYSALES AS 
(
SELECT CATEGORY, SUM(SOLD_QUANTITY) AS TOTAL_UNITS,
	   RANK() OVER (ORDER BY SUM(SOLD_QUANTITY) DESC) AS RANK
	   FROM SALES
	   GROUP BY CATEGORY
)
SELECT * FROM CATEGORYSALES WHERE RANK <3;

........................................................................................................................

  -- 🔹 Q15: Use a CTE to find the top-selling product in each category.
WITH  TOPPRODUCTS AS
(
	SELECT CATEGORY, PRODUCT_NAME, SUM(TOTAL_AMOUNT) AS TOTAL_SALES,
	RANK() OVER (PARTITION BY CATEGORY ORDER BY SUM(TOTAL_AMOUNT) DESC) AS RANK
	FROM SALES
	GROUP BY CATEGORY, PRODUCT_NAME 
)
SELECT * FROM TOPPRODUCTS WHERE RANK = 1;

.....................................................................................................

SELECT * FROM SALES;

 --  ======================== THE END =================================================================
