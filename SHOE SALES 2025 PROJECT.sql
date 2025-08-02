-- CUSTOMERS DATA ON SHOE BUYING IN 2025


-- List all sales transactions along with the customer name and product brand.
SELECT s.sale_id, c.customer_name, p.brand, s.quantity, s.sale_date
FROM shoes.sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id; 

-- Find the total quantity sold for each product brand.
SELECT p.brand, SUM(s.quantity) AS total_sold
FROM shoes.sales s
JOIN sales.s ON s.product_id = p.product_id
GROUP BY p.brand;

-- Retrieve customers who bought more than 10 items in total.
SELECT c.customer_name, SUM(s.quantity) AS total_purchased
FROM shoes.sales s
JOIN customers c ON c.customer_id = s.customer_id
GROUP BY c.customer_name
HAVING total_purchased > 10;

-- Get the most popular product category by number of units sold.
SELECT category, SUM(s.quantity) AS total_sold
FROM shoes.sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY category
ORDER BY total_sold DESC
LIMIT 1;

-- Which region had the highest total sales revenue?
SELECT region, SUM(s.quantity * p.price) AS revenue
FROM shoes.sales s
JOIN customers c ON c.customer_id = s.customer_id
JOIN products p ON p.product_id = s.product_id
GROUP BY region
ORDER BY revenue DESC;

-- List customers who purchased products in more than one category.
SELECT c.customer_name
FROM shoes.sales s
JOIN customers c ON c.customer_id = s.customer_id
JOIN products p ON p.product_id = s.product_id
GROUP BY customer_name
HAVING COUNT(DISTINCT p.category) > 1;

-- Find the top 3 customers by total amount spent.
SELECT c.customer_name, SUM(s.quantity * p.price) AS total_spent
FROM shoes.sales s
JOIN customers c ON c.customer_id = s.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 3;

-- Show the daily total sales quantity.
SELECT sale_date, SUM(quantity) AS total_quantity
FROM shoes.sales s
GROUP BY sale_date
ORDER BY sale_date;

-- Which product generated the highest revenue?
SELECT p.product_id, p.brand, p.category, SUM(s.quantity * p.price) AS revenue
FROM shoes.sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_id
ORDER BY revenue DESC
LIMIT 1; 

-- Find the names of customers who did not buy anything in March 2025
SELECT c.customer_name
FROM customers c
WHERE c.customer_id NOT IN (
    SELECT customer_id FROM sales
    WHERE sale_date BETWEEN '2025-03-01' AND '2025-03-31'
);

