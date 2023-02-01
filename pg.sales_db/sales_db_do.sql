DO
$body$
    DECLARE
        rec RECORD;
    BEGIN
        FOR rec IN
            SELECT first_name, last_name
            FROM sales_person
            LIMIT 5
        LOOP
            RAISE NOTICE '% %', rec.first_name, rec.last_name;
        END LOOP;
     END;
$body$
LANGUAGE plpgsql;

DO
$body$
    DECLARE
        arr1 INT[] := ARRAY[1,2,3];
        i INT;
    BEGIN
        FOREACH i IN ARRAY arr1
        LOOP
            RAISE NOTICE '%', i;
        END LOOP;
    END;      
$body$
LANGUAGE plpgsql;

DO
$body$
    DECLARE
        j INT DEFAULT 1;
        tot_sum INT DEFAULT 0;
    BEGIN
        WHILE j <= 10
        LOOP 
            tot_sum := tot_sum + j;
            j := j + 1;
        END LOOP;
        RAISE NOTICE '%', tot_sum;
    END;
$body$
LANGUAGE plpgsql;

DO
$body$
    DECLARE
        i INT DEFAULT 1;
    BEGIN
        LOOP 
            i := i + 1;
        EXIT WHEN i > 10;
        CONTINUE WHEN MOD(i, 2) = 0;
        RAISE NOTICE 'Num: %', i;
        END LOOP;
    END;
$body$
LANGUAGE plpgsql;