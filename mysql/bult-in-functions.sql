-- Active: 1674749813179@@127.0.0.1@3306
SHOW DATABASES;

CREATE DATABASE sql_intro;

USE sql_intro;

CREATE TABLE emp_details (
	name VARCHAR(25),
	age INT,
	sex CHAR(1),
	doj DATE,
	city VARCHAR(15),
	salary FLOAT
);

DESCRIBE emp_details;

INSERT INTO
	emp_details
VALUES
	("Jimmy", 35, "M", "2005-05-30", "Chicago", 70000),
	("Shane", 30, "M", "1999-06-25", "Seattle", 55000),
	("Marry", 28, "F", "2009-03-10", "Boston", 62000),
	("Dwayne", 37, "M", "2011-07-12", "Austin", 57000),
	("Sara", 32, "F", "2017-10-27", "New York", 72000),
	("Ammy", 35, "F", "2014-12-20", "Seattle", 80000);

SELECT
	*
FROM
	emp_details;

SELECT
	DISTINCT city
FROM
	emp_details;

SELECT
	COUNT(NAME) AS count_name
FROM
	emp_details;

SELECT
	SUM(salary) AS sum_salary
FROM
	emp_details;

SELECT
	AVG(salary) AS avg_salary
FROM
	emp_details;

SELECT
	name,
	age,
	city
FROM
	emp_details;

SELECT
	*
FROM
	emp_details
WHERE
	age > 30;

SELECT
	name,
	sex,
	city
FROM
	emp_details
WHERE
	sex = 'F';

SELECT
	*
FROM
	emp_details
WHERE
	city = 'Chicago'
	OR city = 'Austin';

SELECT
	*
FROM
	emp_details
WHERE
	city IN ('Chicago', 'Austin');

SELECT
	*
FROM
	emp_details
WHERE
	doj BETWEEN '2000-01-01'
	AND '2010-12-31';

SELECT
	*
FROM
	emp_details
WHERE
	age > 30
	AND sex = 'M';

-- GROUP BY
SELECT
	sex,
	SUM(salary) AS sum_salary
FROM
	emp_details
GROUP BY
	sex;

-- ORDER BY
SELECT
	*
FROM
	emp_details
ORDER BY
	salary DESC;

SELECT
	(10 + 20) AS addition;

SELECT
	LENGTH('Vietnam') AS lenght_function;

SELECT
	CHARACTER_LENGTH('Vietnam') AS character_length_function;

SELECT
	name,
	CHAR_LENGTH(name) AS total_len
FROM
	emp_details;

select
	REPEAT('@', 10) AS repeat_function;

SELECT
	UPPER('Vietnam') AS upper_function;

SELECT
	LOWER('VIETNAM') AS lower_function;

SELECT
	LCASE('VIETNAM') AS lcase_function;

SELECT
	CONCAT('Vietnam', ' is ', 'in Asia') AS concat_function;

SELECT
	name,
	CONCAT(name, " ", city) AS name_city
FROM
	emp_details;

SELECT
	REVERSE('Vietnam') AS reverse_function;

SELECT
	REVERSE(name) AS reversed_name
FROM
	emp_details;

SELECT
	REPLACE('Vietnam is in Asia', 'Vietnam', 'China');

SELECT
	LENGTH('   Vietnam   '),
	LENGTH(LTRIM('   Vietnam   '));

SELECT
	LENGTH('   Vietnam   '),
	LENGTH(RTRIM('   Vietnam   '));

SELECT
	LENGTH('   Vietnam   '),
	LENGTH(TRIM('   Vietnam   '));

SELECT
	POSITION("e" in "Vietnam") AS e;

SELECT
	ASCII('a');

SELECT
	CURDATE();

SELECT
	DAY(CURDATE());

SELECT
	now();