-- Active: 1674749813179@@127.0.0.1@3306@sql_intro
SHOW DATABASES;

CREATE DATABASE sql_joins;

USE sql_joins;

CREATE TABLE cricket (
	cricket_id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL,
	PRIMARY KEY (cricket_id)
);

CREATE TABLE football (
	football_id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL,
	PRIMARY KEY (football_id)
);

INSERT INTO
	cricket (name)
VALUES
	('Stuart'),
	('Michael'),
	('Johnson'),
	('Hayden'),
	('Fleming');

INSERT INTO
	football (name)
VALUES
	('Stuart'),
	('Johnson'),
	('Hayden'),
	('Langer'),
	('Astle');

SELECT
	c.cricket_id,
	c.name,
	f.football_id,
	f.name
FROM
	cricket AS c
	INNER JOIN football AS f ON c.name = f.name;