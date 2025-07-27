SELECT * FROM sports.`nike_sales_uncleaned (1)`;

-- Total Revenue Generated 
SELECT SUM(Revenue) AS Total_Revenue_Generated
FROM sports.`nike_sales_uncleaned (1)`;

-- Number of Orders by Gender Category
SELECT Gender_Category, COUNT(*) AS Total_orders 
FROM sports.`nike_sales_uncleaned (1)` 
GROUP BY Gender_Category; 

-- Average Discount by Product Line
SELECT Product_Line, AVG(Discount_Applied) AS Average_Discount
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Product_Line;

-- Top 5 Products by Units Sold
SELECT Product_Name, SUM(Units_Sold) AS Products_Units_Sold
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Product_Name
ORDER BY Products_Units_Sold DESC
LIMIT 5; 

-- Total Profit by Region
SELECT Region, SUM(Profit) AS Total_Profit_by_Region
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Region;

-- Monthly Sales Trend
SELECT 
	DATE_FORMAT(STR_TO_DATE(Order_Date, '%d/%m/%Y'), '%Y-%m') AS Month,
	SUM(Revenue) AS Monthly_Revenue
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Month
ORDER BY Month;

-- Top performing sales channel
SELECT Sales_Channel, SUM(Revenue) AS Total_Revenue_by_Channel
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Sales_Channel
ORDER BY Total_Revenue_by_Channel DESC; 

-- Products Sold Without Discount
SELECT Product_Name, Discount_Applied, COUNT(*) AS Orders_without_discount
FROM sports.`nike_sales_uncleaned (1)`
WHERE Discount_Applied = 0
GROUP BY Product_Name; 

-- Average Profit per Unit Sold (for fully available data only)
SELECT Product_Name, SUM(Profit) / SUM(Units_Sold) AS Average_Profit_per_unit
FROM sports.`nike_sales_uncleaned (1)`
WHERE Units_Sold IS NOT NULL AND Profit IS NOT NULL
GROUP BY Product_Name;

-- Regions with Negative Profit
SELECT Region, SUM(Profit) AS Total_Profit
FROM sports.`nike_sales_uncleaned (1)`
WHERE Total_Profit < 0 
GROUP BY Region;

SELECT 
  Gender_Category,
  Sales_Channel,
  ROUND(AVG(Discount_Applied), 2) AS Avg_Discount
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Gender_Category, Sales_Channel;

-- Profit Margin by Product Line
SELECT 
  Product_Line,
  ROUND(SUM(Profit) / NULLIF(SUM(Revenue), 0), 4) AS Profit_Margin
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Product_Line
ORDER BY Profit_Margin DESC;

-- Month-over-Month Revenue Growth
SELECT 
  DATE_FORMAT(STR_TO_DATE(Order_Date, '%d/%m/%Y'), '%Y-%m') AS Month,
  SUM(Revenue) AS Monthly_Revenue,
  LAG(SUM(Revenue)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(Order_Date, '%d/%m/%Y'), '%Y-%m')) AS Previous_Month_Revenue,
  ROUND(
    (SUM(Revenue) - LAG(SUM(Revenue)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(Order_Date, '%d/%m/%Y'), '%Y-%m')))
    / NULLIF(LAG(SUM(Revenue)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(Order_Date, '%d/%m/%Y'), '%Y-%m')), 0) * 100, 2
  ) AS Revenue_Growth_Percent
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Month;

-- Identify Loss-Making Products
SELECT Product_Name, SUM(Profit) AS Total_Profit
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Product_Name
HAVING Total_Profit < 0
ORDER BY Total_Profit ASC;

-- Top 3 Products by Revenue in Each Region
SELECT *
FROM (
  SELECT 
    Region,
    Product_Name,
    SUM(Revenue) AS Total_Revenue,
    RANK() OVER (PARTITION BY Region ORDER BY SUM(Revenue) DESC) AS rnk
  FROM sports.`nike_sales_uncleaned (1)`
  GROUP BY Region, Product_Name
) ranked
WHERE rnk <= 3;

-- Average Discount by Gender and Sales Channel
SELECT 
  Gender_Category,
  Sales_Channel,
  ROUND(AVG(Discount_Applied), 2) AS Avg_Discount
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Gender_Category, Sales_Channel;

-- Cumulative Revenue by Month
SELECT 
  DATE_FORMAT(STR_TO_DATE(Order_Date, '%d/%m/%Y'), '%Y-%m') AS Month,
  SUM(Revenue) AS Monthly_Revenue,
  SUM(SUM(Revenue)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(Order_Date, '%d/%m/%Y'), '%Y-%m')) AS Cumulative_Revenue
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Month;

-- Most Common Size Sold per Product Line
SELECT Product_Line, Size, COUNT(*) AS Count
FROM (
  SELECT 
    Product_Line, 
    Size, 
    RANK() OVER (PARTITION BY Product_Line ORDER BY COUNT(*) DESC) AS rnk
  FROM sports.`nike_sales_uncleaned (1)`
  GROUP BY Product_Line, Size
) ranked_sizes
WHERE rnk = 1;

-- High Discount, Low Profit Products
SELECT Product_Name, AVG(Discount_Applied) AS Avg_Discount, SUM(Profit) AS Total_Profit
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Product_Name
HAVING Avg_Discount > 0.4 AND Total_Profit < 1000
ORDER BY Avg_Discount DESC;

-- Repeat Orders for Same Product
SELECT Product_Name, COUNT(DISTINCT Order_ID) AS Order_Count
FROM sports.`nike_sales_uncleaned (1)`
GROUP BY Product_Name
HAVING Order_Count > 1
ORDER BY Order_Count DESC;

-- Channel Contribution to Regional Revenue
SELECT 
  Region,
  Sales_Channel,
  ROUND(SUM(Revenue) / 
    (SELECT SUM(Revenue) FROM sports.`nike_sales_uncleaned (1)` r2 WHERE r2.Region = r1.Region)
  * 100, 2) AS Channel_Contribution_Percent
FROM sports.`nike_sales_uncleaned (1)` r1
GROUP BY Region, Sales_Channel;

