CREATE OR REPLACE PROCEDURE pr_debt_paid(
    past_due_id INT,
    payment NUMERIC(6,2)
)
AS
$body$
    BEGIN
        UPDATE past_due
        SET balance = balance - payment
        WHERE id = past_due_id;
        COMMIT;
    END;
$body$
LANGUAGE plpgsql;