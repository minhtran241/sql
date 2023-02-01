-- Active: 1674749813179@@127.0.0.1@3306@sql_intro
SHOW DATABASES;

USE sql_intro;

CREATE TABLE employees (
	Emp_Id INT NOT NULL AUTO_INCREMENT,
	Emp_name VARCHAR(25) NOT NULL,
	Age INT,
	Gender CHAR(1),
	Doj DATE DEFAULT(NOW ()),
	Dept VARCHAR(20),
	City VARCHAR(15),
	Salary FLOAT,
	PRIMARY KEY (Emp_Id)
);

ALTER TABLE
	employees AUTO_INCREMENT = 100;

DESCRIBE employees;

INSERT INTO
	employees (
		`Emp_name`,
		`Age`,
		`Gender`,
		`Doj`,
		`Dept`,
		`City`,
		`Salary`
	)
VALUES
	(
		"Jimmy",
		35,
		"M",
		"2005-05-30",
		"Tech",
		"Chicago",
		70000
	),
	(
		"Shane",
		30,
		"M",
		"1999-06-25",
		"Marketing",
		"Seattle",
		55000
	),
	(
		"Marry",
		28,
		"F",
		"2009-03-10",
		"Design",
		"Boston",
		62000
	),
	(
		"Dwayne",
		37,
		"M",
		"2011-07-12",
		"Logistics",
		"Austin",
		57000
	),
	(
		"Sara",
		32,
		"F",
		"2017-10-27",
		"Tech",
		"New York",
		72000
	),
	(
		"Ammy",
		35,
		"F",
		"2014-12-20",
		"Design",
		"Seattle",
		80000
	),
	(
		"John",
		23,
		"M",
		"2009-08-24",
		"Sales",
		"Allendale",
		80000
	),
	(
		"Katy",
		35,
		"F",
		"2004-01-18",
		"Sales",
		"Grand Rapids",
		52000
	),
	(
		"Ham",
		30,
		"M",
		"2010-10-03",
		"Tech",
		"California",
		71000
	),
	(
		"Mark",
		28,
		"M",
		"1998-05-11",
		"Logistics",
		"Chicago",
		69000
	),
	(
		"David",
		27,
		"M",
		"1999-02-23",
		"Marketing",
		"New York",
		90000
	);

SELECT
	*
From
	employees;

SELECT
	DISTINCT City
FROM
	employees;

SELECT
	DISTINCT Dept
FROM
	employees;

SELECT
	Dept,
	avg(Age) AS avg_age
FROM
	employees
GROUP BY
	Dept;

SELECT
	Dept,
	SUM(salary) AS total_salary
from
	employees
GROUP BY
	Dept;

SELECT
	COUNT(Emp_id),
	City
FROM
	employees
GROUP BY
	City
ORDER BY
	COUNT(Emp_Id) DESC;

SELECT
	YEAR(Doj) AS year,
	count(Emp_Id)
from
	employees
GROUP BY
	year(Doj);

CREATE Table sales (
	Product_Id INT NOT NULL,
	Sell_price FLOAT,
	Quantity INT,
	State VARCHAR(20)
);

INSERT INTO
	sales
VALUES
	(121, 320.0, 3, 'California'),
	(121, 320.0, 6, 'Michigan'),
	(121, 320.0, 4, 'Texas'),
	(122, 290.0, 2, 'New York'),
	(122, 320.0, 7, 'Ohio'),
	(123, 290.0, 4, 'Washington'),
	(123, 320.0, 2, 'Arizona'),
	(123, 290.0, 8, 'Colorado');

SELECT
	*
FROM
	sales;

SELECT
	Product_Id,
	sum(Sell_price * Quantity) AS revenue
FROM
	sales
GROUP BY
	Product_Id;

CREATE TABLE c_product (Product_Id INT NOT NULL, Cost_price FLOAT);

INSERT INTO
	c_product
VALUES
	(121, 270.0),
	(122, 250.0),
	(123, 250.0);

SELECT
	c.Product_Id,
	sum((s.Sell_price - c.Cost_price) * s.Quantity) AS profit
FROM
	sales AS s
	INNER JOIN c_product AS c ON s.Product_Id = c.Product_Id
GROUP BY
	c.Product_Id;

SELECT
	Dept,
	AVG(Salary)
FROM
	employees
GROUP BY
	Dept
HAVING
	AVG(Salary) > 45000;