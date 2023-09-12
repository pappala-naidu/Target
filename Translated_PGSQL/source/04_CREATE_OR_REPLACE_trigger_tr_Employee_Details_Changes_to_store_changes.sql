CREATE OR REPLACE TRIGGER tr_employee_details_changes
    BEFORE INSERT OR DELETE OR UPDATE ON employee_details
    FOR EACH ROW
    ENABLE
    DECLARE
        v_date  varchar(30);
    BEGIN
        SELECT to_char(sysdate, 'DD/MON/YYYY HH24:MI:SS') INTO v_date  FROM dual;
        IF inserting THEN
            INSERT INTO employee_details_changes (new_name, old_name, entry_date, operation)
                VALUES(:new.emp_name, null, v_date, 'insert');
        ELSIF deleting THEN
            INSERT INTO employee_details_changes (new_name, old_name, entry_date, operation)
                VALUES(null, :old.emp_name, v_date, 'delete');
        ELSIF updating THEN
            INSERT INTO employee_details_changes (new_name, old_name, entry_date, operation)
                VALUES(:new.emp_name, :old.emp_name, v_date, 'update');
        END IF;
    END;
    /