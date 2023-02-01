SELECT *
FROM sales_item
WHERE discount > .15;

SELECT time_order_taken, customer_id
FROM sales_order
WHERE time_order_taken > '2018-12-01' AND time_order_taken < '2018-12-31';

SELECT *
FROM sales_item
WHERE discount > .15
ORDER BY discount DESC
LIMIT 5;

SELECT CONCAT(first_name, ' ', last_name) AS full_name, phone, state
FROM customer
WHERE state = 'TX';

SELECT product_id, SUM(price) AS total_price
FROM item
WHERE product_id = 1
GROUP BY product_id;

SELECT DISTINCT state
FROM customer
ORDER BY state;

SELECT DISTINCT si.item_id, i.price
FROM item AS i, sales_item AS si
WHERE i.id = si.item_id
AND i.price > 120.00
ORDER BY si.item_id;

SELECT product_id, price
FROM item
WHERE price IS NULL;

SELECT first_name, last_name
FROM customer
WHERE first_name SIMILAR TO 'M%';

SELECT first_name, last_name
FROM customer
WHERE first_name LIKE 'D%' OR last_name LIKE '%n';

SELECT first_name, last_name
FROM customer
WHERE first_name ~ '^Ma';

SELECT first_name, last_name
FROM customer
WHERE last_name ~ 'ez|son';

SELECT first_name, last_name
FROM customer
WHERE last_name ~ '[w-z]';

SELECT EXTRACT(MONTH FROM birth_date) AS birth_month, COUNT(id) AS num_customer
FROM customer
GROUP BY birth_month
ORDER BY birth_month;

SELECT EXTRACT(MONTH FROM birth_date) AS birth_month, COUNT(*) AS num_customer
FROM customer
GROUP BY birth_month
HAVING COUNT(*) > 1
ORDER BY birth_month;

SELECT 
COUNT(*) AS items, SUM(price) AS value, 
ROUND(AVG(price), 2) AS average,
MIN(price) AS min, MAX(price) AS max
FROM item;