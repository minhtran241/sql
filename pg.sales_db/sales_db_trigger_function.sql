CREATE OR REPLACE FUNCTION fn_log_dist_name_change()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$body$
    BEGIN
        IF NEW.name <> OLD.name THEN
            INSERT INTO distributor_audit
            (dist_id, old_name, new_name, edit_date)
            VALUES
            (OLD.id, OLD.name, NEW.name, NOW());
        END IF;
        RAISE NOTICE 'Trigger Name: %', TG_NAME;
        RAISE NOTICE 'Table Name: %', TG_TABLE_NAME;
        RAISE NOTICE 'Operation: %', TG_OP;
        RAISE NOTICE 'When Executed: %', TG_WHEN;
        RAISE NOTICE 'Table Schema: %', TG_TABLE_SCHEMA;
        RETURN NEW;
    END;
$body$

CREATE OR REPLACE FUNCTION fn_block_weekend_changes()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$body$
    BEGIN
        RAISE NOTICE 'No Database Changes Allowed On The Weekend';
        RETURN NULL;
    END;
$body$;