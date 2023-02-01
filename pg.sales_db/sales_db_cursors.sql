-- CURSORS
DO
$body$
    DECLARE 
        msg TEXT DEFAULT '';
        rec_customer RECORD;
        cur_customers CURSOR FOR SELECT * FROM customer;
    BEGIN
        OPEN cur_customers;
        LOOP 
            FETCH cur_customers INTO rec_customer;
            EXIT WHEN NOT FOUND;
            msg := msg || rec_customer.first_name || ' ' || rec_customer.last_name;
        END LOOP;
        CLOSE cur_customers;
        RAISE NOTICE 'Customers: %', msg;
    END;
$body$

CREATE OR REPLACE FUNCTION fn_get_customers_by_state(c_state VARCHAR)
RETURNS TEXT
LANGUAGE plpgsql
AS
$body$
DECLARE
    cust_names TEXT DEFAULT '';
    rec_customer RECORD;
    cur_cust_by_state CURSOR (c_state VARCHAR)
    FOR
        SELECT first_name, last_name, state 
        FROM customer
        WHERE state = c_state;
    BEGIN
        OPEN cur_cust_by_state(c_state);
        LOOP
            FETCH cur_cust_by_state INTO rec_customer;
            EXIT WHEN NOT FOUND;
            cust_names := cust_names || rec_customer.first_name || rec_customer.last_name || ', ';
        END LOOP;
        CLOSE cur_cust_by_state;
        RETURN cust_names;
    END;
$body$

select fn_get_customers_by_state('CA')