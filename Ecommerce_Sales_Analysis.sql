
-- ==================================================
-- E-COMMERCE SALES ANALYSIS PROJECT
-- Database: ecommerce_analysis
-- ==================================================


-- 1. DATABASE CREATION
-- Question: How do we create the project database?

CREATE DATABASE IF NOT EXISTS ecommerce_analysis;


-- 2. SELECT DATABASE
-- Question: How do we select the database?

USE ecommerce_analysis;


-- 3. CREATE CUSTOMERS TABLE
-- Question: How do we store customer information?

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);


-- 4. INSERT CUSTOMER DATA
-- Question: How do we add customer records?

INSERT IGNORE INTO customers
(customer_id, customer_name, city, age, gender)
VALUES
(1, 'Rahul Sharma', 'Delhi', 25, 'Male'),
(2, 'Priya Singh', 'Noida', 28, 'Female'),
(3, 'Aman Gupta', 'Ghaziabad', 24, 'Male'),
(4, 'Neha Verma', 'Delhi', 30, 'Female'),
(5, 'Rohit Kumar', 'Noida', 27, 'Male'),
(6, 'Anjali Yadav', 'Lucknow', 26, 'Female'),
(7, 'Vikas Singh', 'Kanpur', 32, 'Male'),
(8, 'Pooja Gupta', 'Agra', 29, 'Female'),
(9, 'Karan Mehta', 'Delhi', 35, 'Male'),
(10, 'Sneha Sharma', 'Noida', 23, 'Female');


-- 5. VIEW CUSTOMERS DATA
-- Question: How do we display customer records?

SELECT * FROM customers;


-- 6. CHECK CUSTOMERS TABLE STRUCTURE
-- Question: What columns are present in the customers table?

DESCRIBE customers;


-- 7. CREATE PRODUCTS TABLE
-- Question: How do we store product information?

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);


-- 8. INSERT PRODUCT DATA
-- Question: How do we add product records?

INSERT IGNORE INTO products
(product_id, product_name, category, price)
VALUES
(1, 'Laptop', 'Electronics', 55000),
(2, 'Smartphone', 'Electronics', 25000),
(3, 'Headphones', 'Electronics', 2000),
(4, 'Office Chair', 'Furniture', 8000),
(5, 'Study Table', 'Furniture', 6000),
(6, 'Backpack', 'Accessories', 1500),
(7, 'Watch', 'Accessories', 3000),
(8, 'Keyboard', 'Electronics', 2500),
(9, 'Shoes', 'Fashion', 3500),
(10, 'T-Shirt', 'Fashion', 1200);


-- 9. VIEW PRODUCTS DATA
-- Question: How do we display all products?

SELECT * FROM products;


-- 10. CREATE ORDERS TABLE
-- Question: How do we store customer orders?

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


-- 11. INSERT ORDER DATA
-- Question: How do we add order records?

INSERT IGNORE INTO orders
(order_id, customer_id, product_id, quantity, order_date)
VALUES
(1, 1, 1, 1, '2026-01-05'),
(2, 2, 2, 2, '2026-01-08'),
(3, 3, 4, 1, '2026-01-12'),
(4, 4, 3, 2, '2026-01-15'),
(5, 5, 5, 1, '2026-01-20'),
(6, 6, 6, 3, '2026-01-25'),
(7, 7, 7, 1, '2026-02-02'),
(8, 8, 8, 2, '2026-02-10'),
(9, 9, 9, 1, '2026-02-15'),
(10, 10, 10, 3, '2026-02-20'),
(11, 1, 2, 1, '2026-02-25'),
(12, 3, 3, 2, '2026-03-03'),
(13, 5, 1, 1, '2026-03-08'),
(14, 7, 5, 2, '2026-03-15'),
(15, 9, 4, 1, '2026-03-20');


-- 12. VIEW ORDERS DATA
-- Question: How do we display all order records?

SELECT * FROM orders;


-- 13. CHECK DATABASE TABLES
-- Question: Which tables exist in the database?

SHOW TABLES;


-- 14. TOTAL ORDERS ANALYSIS
-- Question: How many orders were placed?

SELECT COUNT(*) AS total_orders
FROM orders;


-- 15. TOTAL CUSTOMERS ANALYSIS
-- Question: How many customers are registered?

SELECT COUNT(*) AS total_customers
FROM customers;


-- 16. TOTAL REVENUE ANALYSIS
-- Question: What is the total revenue generated?

SELECT
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;


-- 17. AVERAGE ORDER VALUE ANALYSIS
-- Question: What is the average revenue per order?

SELECT
    AVG(o.quantity * p.price) AS average_order_value
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;


-- 18. BEST-SELLING PRODUCT BY QUANTITY
-- Question: Which product sold the highest quantity?

SELECT
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;


-- 19. HIGHEST REVENUE PRODUCT
-- Question: Which product generated the highest revenue?

SELECT
    p.product_name,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 1;


-- 20. CITY-WISE CUSTOMER ANALYSIS
-- Question: How many customers belong to each city?

SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;


-- 21. CATEGORY-WISE REVENUE ANALYSIS
-- Question: Which product category generates the most revenue?

SELECT
    p.category,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;


-- 22. CITY-WISE REVENUE ANALYSIS
-- Question: Which city generates the most revenue?

SELECT
    c.city,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.city
ORDER BY total_revenue DESC;


-- 23. MONTH-WISE REVENUE ANALYSIS
-- Question: How much revenue was generated each month?

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY order_month;


-- 24. Gender-wise Customer Analysis
-- Question: How many customers belong to each gender?

SELECT
    gender,
    COUNT(*) AS total_customers
FROM customers
GROUP BY gender
ORDER BY total_customers DESC;


-- 25. Category-wise Average Product Price
-- Question: What is the average product price in each category?

SELECT
    category,
    ROUND(AVG(price), 2) AS average_product_price
FROM products
GROUP BY category
ORDER BY average_product_price DESC;


-- 26. Customer-wise Spending Analysis
-- Question: How much revenue did each customer generate?

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC;


-- 27. Month-wise Order Analysis
-- Question: How many orders were placed each month?

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;


-- 28. Category-wise Product Analysis
-- Question: How many products are available in each category?

SELECT
    category,
    COUNT(*) AS total_products
FROM products
GROUP BY category
ORDER BY total_products DESC;


-- 29. High-Value Order Analysis
-- Question: Which orders have a total value above 10000?

SELECT
    o.order_id,
    p.product_name,
    o.quantity,
    p.price,
    (o.quantity * p.price) AS order_value
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
WHERE (o.quantity * p.price) > 10000
ORDER BY order_value DESC;


-- 30. Customer Order Frequency Analysis
-- Question: How many orders has each customer placed?

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;



