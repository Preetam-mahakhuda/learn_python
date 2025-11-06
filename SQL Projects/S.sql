
select * from pizzas;
select* from pizza_types;
select*from order_details;
select*from orders;

-- Retrieve the total number of orders placed
SELECT COUNT(*) FROM orders;

-- Calculate the total revenue generated from pizza sales
SELECT 
    SUM(price * quantity) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id;

--  Identify the highest-priced pizza.
SELECT pt.name, price 
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY price DESC
LIMIT 1;

--  Identify the most common pizza size ordered.
SELECT p.size, COUNT(*) AS total_orders
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_orders DESC
LIMIT 1;

--  List the top 5 most ordered pizza types along with their quantities.
SELECT pt.name, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;

--  Total quantity of each pizza category ordered
SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity DESC;

 -- Determine the distribution of orders by hour of the day.
SELECT HOUR(o.time) AS order_hour, COUNT(*) AS total_orders
FROM orders o
GROUP BY order_hour
ORDER BY order_hour;
-- join relevant tables to find the category-wise distribution of pizzas.
SELECT pt.category, COUNT(DISTINCT p.pizza_id) AS total_pizzas
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_pizzas DESC;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT o.date, SUM(od.quantity) AS total_pizzas
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.date;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT pt.name, ROUND(SUM(price * od.quantity), 2) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;
