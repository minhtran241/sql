SELECT DISTINCT item_id, price
FROM item AS i INNER JOIN sales_item AS si
ON i.id = si.item_id AND price > 120.00
ORDER BY item_id;

SELECT so.id, si.quantity, i.price, 
(si.quantity * i.price) AS total_price
FROM sales_order AS so
JOIN sales_item AS si
ON si.sales_order_id = so.id
JOIN item AS i
ON si.item_id = i.id
ORDER BY so.id;

SELECT p.id, p.name, p.supplier, i.price
FROM product AS p LEFT JOIN item AS i
ON p.id = i.product_id
ORDER BY p.name;

SELECT si.sales_order_id, si.quantity, i.product_id
FROM sales_item AS si CROSS JOIN item AS i
ORDER BY i.product_id;

SELECT first_name, last_name, street, city, zip, birth_date
FROM customer
WHERE EXTRACT(MONTH FROM birth_date) = 12
UNION
SELECT first_name, last_name, street, city, zip, birth_date
FROM sales_person
WHERE EXTRACT(MONTH FROM birth_date) = 12
ORDER BY birth_date;