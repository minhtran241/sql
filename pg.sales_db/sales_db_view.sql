CREATE VIEW purchase_order_overview AS
SELECT so.purchase_order_number, 
c.company AS customer_company,
p.supplier, p.name AS product_name, 
si.quantity, i.price,
CONCAT(sp.first_name, ' ', sp.last_name) AS sales_person_fullname
FROM sales_order AS so
JOIN sales_item AS si
ON so.id = si.sales_order_id
JOIN item AS i
ON i.id = si.item_id
JOIN customer AS c
ON c.id = so.customer_id
JOIN sales_person AS sp
ON sp.id = so.sales_person_id
JOIN product AS p
ON p.id = i.product_id
ORDER BY so.purchase_order_number;

SELECT *, (quantity * price) AS total_price
FROM purchase_order_overview;