CREATE OR REPLACE FUNCTION fn_total_price(NUMERIC(6,2),INT)
RETURNS NUMERIC(6,2) AS
$body$
    SELECT $1 * $2;
$body$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION fn_update_employee_state(sales_person_id INT,state_name CHAR(2))
RETURNS VOID AS
$body$
    UPDATE sales_person
    SET state = state_name
    WHERE id = sales_person_id;
$body$
LANGUAGE SQL;

SELECT fn_update_employee_state(1,'MI');

CREATE OR REPLACE FUNCTION fn_max_product_price()
RETURNS NUMERIC(6,2) AS
$body$
    SELECT MAX(price)
    FROM item;
$body$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION fn_get_value_inventory()
RETURNS NUMERIC(6,2) AS
$body$
    SELECT SUM(price)
    FROM item;
$body$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION fn_number_customers()
RETURNS INTEGER AS
$body$
    SELECT COUNT(*)
    FROM customer;
$body$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION fn_number_customes_no_phone()
RETURNS INTEGER AS
$body$
    SELECT COUNT(*)
    FROM customer
    WHERE phone IS NULL;
$body$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION fn_get_number_customes_from_state(state_name CHAR(2))
RETURNS INTEGER AS
$body$
    SELECT COUNT(*)
    FROM customer
    WHERE state = state_name;
$body$
LANGUAGE SQL;

SELECT fn_get_number_customes_from_state('TX');

CREATE OR REPLACE FUNCTION fn_get_number_orders_from_customer(cus_fname VARCHAR(30),cus_lname VARCHAR(30))
RETURNS INTEGER AS
$body$
    SELECT COUNT(*)
    FROM sales_order AS so
    NATURAL JOIN customer AS c
    WHERE c.first_name = cus_fname AND c.last_name = cus_lname;
$body$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION fn_get_last_orders()
RETURNS sales_order AS
$body$
    SELECT *
    FROM sales_order
    ORDER BY time_order_taken DESC
    LIMIT 1;
$body$
LANGUAGE SQL;

SELECT (fn_get_last_orders()).*;

CREATE OR REPLACE FUNCTION fn_get_employees_state(state_name CHAR(2))
RETURNS SETOF sales_person AS
$body$
    SELECT *
    FROM sales_person
    WHERE state = state_name;
$body$
LANGUAGE SQL;

SELECT first_name, last_name, phone
FROM fn_get_employees_state('CA');

CREATE OR REPLACE FUNCTION fn_get_price_product_name(prod_name VARCHAR(30))
RETURNS NUMERIC(6,2) AS
$body$
    BEGIN
        RETURN i.price
        FROM item AS i
        NATURAL JOIN product AS p
        WHERE p.name = prod_name;
    END;
$body$
LANGUAGE plpgsql;

SELECT fn_get_price_product_name('Grandview');

CREATE OR REPLACE FUNCTION fn_get_sum(val1 INT, val2 INT)
RETURNS INT AS
$body$
    DECLARE
        ans INT;
    BEGIN
        ans := val1 + val2;
        RETURN ans;
    END;
$body$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_get_random_number(min_val INT, max_val INT)
RETURNS INT AS
$body$
    DECLARE
        rand INT;
    BEGIN
        SELECT RANDOM() * (max_val - min_val) + min_val INTO rand;
        RETURN rand;
    END;
$body$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_get_random_salesperson()
RETURNS VARCHAR AS
$body$
    DECLARE
        rand INT;
        num_rows INT;
        emp RECORD;
    BEGIN
        SELECT COUNT(*)
        FROM sales_person
        INTO num_rows;
        SELECT RANDOM() * (num_rows - 1) + 1 INTO rand;
        SELECT *
        FROM sales_person
        INTO emp
        WHERE id = rand;
        RETURN CONCAT(emp.first_name, ' ', emp.last_name);
    END;
$body$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_get_sum_2(IN v1 INT, IN v2 INT, OUT ans INT)
AS
$body$
    BEGIN
        ans := v1 + v2;
    END;
$body$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_get_cust_birthday(IN the_month INT, OUT bd_month INT, OUT bd_day INT,
                                               OUT f_name VARCHAR, OUT l_name VARCHAR)
AS
$body$
    BEGIN
        SELECT EXTRACT(MONTH FROM birth_date), EXTRACT(DAY FROM birth_date),
        first_name, last_name
        INTO bd_month, bd_day, f_name, l_name
        FROM customer
        WHERE EXTRACT(MONTH FROM birth_date) = the_month
        LIMIT 1;
    END
$body$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_get_sales_people()
RETURNS SETOF sales_person AS
$body$
    BEGIN
        RETURN QUERY
        SELECT * 
        FROM sales_person;
    END;
$body$
LANGUAGE plpgsql;

SELECT (fn_get_sales_people()).street;

-- Multiple tables
CREATE OR REPLACE FUNCTION fn_get_top_10_expensive_prods()
RETURNS TABLE (
    name VARCHAR(30),
    supplier VARCHAR(30),
    price NUMERIC(6,2)
) AS
$body$
    BEGIN
        RETURN QUERY
        SELECT p.name, p.supplier, i.price
        FROM product AS p
        NATURAL JOIN item AS i
        ORDER BY i.price DESC
        LIMIT 10;
    END;
$body$
LANGUAGE plpgsql;

SELECT (fn_get_top_10_expensive_prods()).*;

CREATE OR REPLACE FUNCTION fn_check_month_orders(the_month INT)
RETURNS VARCHAR AS
$body$
    DECLARE
        total_orders INT;
    BEGIN
        SELECT COUNT(purchase_order_number)
        INTO total_orders
        FROM sales_order
        WHERE EXTRACT(MONTH FROM time_order_taken) = the_month;
        IF total_orders > 50 THEN
            RETURN CONCAT(total_orders, ' Orders: Doing Good');
        ELSEIF total_orders < 50 THEN
            RETURN CONCAT(total_orders, ' Orders: Doing Bad');
        ELSE
            RETURN CONCAT(total_orders, ' Orders: On Target');
        END IF;
    END;
$body$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_check_month_orders(the_month INT)
RETURNS VARCHAR AS
$body$
    DECLARE
        total_orders INT;
    BEGIN
        SELECT COUNT(purchase_order_number)
        INTO total_orders
        FROM sales_order
        WHERE EXTRACT(MONTH FROM time_order_taken) = the_month;
        CASE
            WHEN total_orders < 1 THEN
                RETURN CONCAT(total_orders, ' Orders: Doing Terrible');
            WHEN total_orders > 1 AND total_orders < 5 THEN
                RETURN CONCAT(total_orders, ' Orders: ON Target');
            ELSE
                RETURN CONCAT(total_orders, ' Orders: Doing Good');
        END CASE;
    END;
$body$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_get_supplier_value(the_supplier VARCHAR)
RETURNS VARCHAR AS
$body$
    DECLARE
        supplier_name VARCHAR(30);
        price_sum NUMERIC;
    BEGIN
        SELECT p.supplier, SUM(i.price)
        INTO supplier_name, price_sum
        FROM product AS p
        JOIN item AS i
        ON p.id = i.product_id
        WHERE p.supplier = the_supplier
        GROUP BY p.supplier;
        RETURN CONCAT(supplier_name, ' Inventory Value: $', price_sum);
    END;
$body$
LANGUAGE plpgsql;