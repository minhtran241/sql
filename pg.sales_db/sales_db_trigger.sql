CREATE TRIGGER tr_dist_name_changed
    BEFORE UPDATE
    ON distributor
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_dist_name_change();

UPDATE distributor
SET name = 'Asian Clothing'
WHERE id = 2;

CREATE TRIGGER tr_block_weekend_changes
    BEFORE UPDATE OR INSERT OR DELETE OR TRUNCATE
    ON distributor
    FOR EACH STATEMENT
    WHEN (EXTRACT('DOW' FROM CURRENT_TIMESTAMP) BETWEEN 6 AND 7)
    EXECUTE PROCEDURE fn_block_weekend_changes();
    
DROP TRIGGER tr_block_weekend_changes ON distributor;