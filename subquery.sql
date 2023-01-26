-- Active: 1674749813179@@127.0.0.1@3306@sql_intro
SHOW DATABASES;

USE sql_intro;

-- SELECT statement
SELECT
	Emp_name
FROM
	employees
WHERE
	Salary = (
		SELECT
			MAX(Salary)
		FROM
			employees
	);

SELECT
	Emp_name,
	Dept,
	Salary
FROM
	employees
WHERE
	Salary < (
		SELECT
			AVG(Salary)
		FROM
			employees
	);

-- INSERT statement
CREATE TABLE products (
	prod_id INT,
	item VARCHAR(30),
	sell_price FLOAT,
	product_type VARCHAR(30)
);

INSERT INTO
	products
VALUES
	(101, 'Jewellery', 1800, 'Luxury'),
	(102, 'T-Shirt', 100, 'Non-Luxury'),
	(103, 'Laptop', 1300, 'Luxury'),
	(104, 'Table', 400, 'Non-Luxury');

CREATE TABLE orders (
	order_id INT,
	product_sold VARCHAR(30),
	selling_price FLOAT
);

INSERT INTO
	orders
SELECT
	prod_id,
	item,
	sell_price
FROM
	products
WHERE
	prod_id IN (
		SELECT
			prod_id
		FROM
			products
		WHERE
			sell_price > 1000
	);

SELECT
	*
FROM
	orders;