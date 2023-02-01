-- Active: 1674749813179@@127.0.0.1@3306@sql_intro
SHOW DATABASES;

USE sql_intro;

SELECT
	Dept,
	AVG(Salary) AS avg_salary
FROM
	employees
GROUP BY
	Dept
HAVING
	AVG(Salary) > 70000
ORDER BY
	avg_salary DESC;

SELECT
	City,
	SUM(Salary) AS total_salary
FROM
	employees
GROUP BY
	City
HAVING
	SUM(Salary) > 100000;

SELECT
	Dept,
	COUNT(*) AS emp_count
FROM
	employees
GROUP BY
	Dept
Having
	COUNT(*) > 2;

SELECT
	City,
	COUNT(*) AS emp_count
FROM
	employees
WHERE
	city != 'Chicago'
GROUP BY
	City
HAVING
	COUNT(*) > 1;

SELECT
	Dept,
	COUNT(*) AS emp_count
FROM
	employees
GROUP BY
	Dept
HAVING
	AVG(Salary) > 70000;