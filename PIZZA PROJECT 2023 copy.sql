SELECT * FROM Tochi.pizza_sales;

-- Total Revenue
SELECT SUM(total_price) AS total_revenue
FROM Tochi.pizza_sales; 

-- Average order value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS average_order_value FROM Tochi.pizza_sales; 

-- Total Pizza Sold
SELECT SUM(quantity) AS Total_pizza_sold
FROM Tochi.pizza_sales; 

-- Total Order placed
SELECT COUNT(DISTINCT order_id) AS total_order_placed 
FROM Tochi.pizza_sales; 

-- Average Pizzas per order
SELECT SUM(quantity) / COUNT(DISTINCT order_id) AS average_pizza_per_order
FROM Tochi.pizza_sales; 


-- Daily trend for total orders
SELECT DAYNAME(order_date) as order_day, COUNT(DISTINCT order_id) as Total_orders
FROM Tochi.pizza_sales
GROUP BY DAYNAME(order_date);

-- Hourly trend for total orders
SELECT HOUR(order_time) as order_hours, COUNT(DISTINCT order_id) as Total_orders
FROM Tochi.pizza_sales
GROUP BY HOUR(order_time);

-- Percentage of sales by Pizza Category  (the where clause is for checking which month of the year)
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 6) AS Percentage_sales
FROM Tochi.pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

-- Percentage of sales by Pizza size  (the where clause is for checking which month of the year)
SELECT pizza_size, 
ROUND(SUM(total_price), 2) AS total_sales, 
ROUND (SUM(total_price) * 100 / (
	SELECT SUM(total_price) FROM Tochi.pizza_sales WHERE QUARTER(order_date) = 1) , 2) AS Percentage_sales
FROM Tochi.pizza_sales
WHERE QUARTER(order_date) = 1
GROUP BY pizza_size
ORDER BY percentage_sales DESC; 

-- Total pizzas sold by pizza category
SELECT pizza_category, SUM(quantity) AS Total_pizzas_sold
FROM Tochi.pizza_sales
GROUP BY pizza_category; 

-- Top 5 best sellers
SELECT pizza_name, SUM(quantity) AS Total_pizzas_sold
FROM Tochi.pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC
LIMIT 5;

-- Bottom 5 best sellers
SELECT pizza_name, SUM(quantity) AS Total_pizzas_sold
FROM Tochi.pizza_sales
WHERE MONTH(order_date) = 8
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC
LIMIT 5;


    
    