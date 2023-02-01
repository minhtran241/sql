CREATE OR REPLACE FUNCTION fn_loop_test(max_num INT)
RETURNS INT AS
$body$
    DECLARE
        i INT DEFAULT 1;
        tot_sum INT DEFAULT 0;
    BEGIN
        LOOP
            tot_sum := tot_sum + i;
            i := i + 1;
            EXIT WHEN i > max_num;
        END LOOP;
        RETURN tot_sum;
    END;
$body$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_for_test(start_num INT, end_num INT, leap INT)
RETURNS INT AS
$body$
    DECLARE
        tot_sum INT DEFAULT 0;
    BEGIN
        FOR i IN start_num .. end_num BY leap
        LOOP
            tot_sum := tot_sum + i;
        END LOOP;
        RETURN tot_sum;
    END;
$body$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_for_test(start_num INT, end_num INT, leap INT)
RETURNS INT AS
$body$
    DECLARE
        tot_sum INT DEFAULT 0;
    BEGIN
        FOR i IN REVERSE end_num .. start_num BY leap
        LOOP
            tot_sum := tot_sum + i;
        END LOOP;
        RETURN tot_sum;
    END;
$body$
LANGUAGE plpgsql;