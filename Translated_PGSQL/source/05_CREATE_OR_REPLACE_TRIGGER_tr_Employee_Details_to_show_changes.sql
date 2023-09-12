CREATE OR REPLACE TRIGGER tr_employee_details
    BEFORE INSERT OR DELETE OR UPDATE ON employee_details
    FOR EACH ROW
    ENABLE
BEGIN

  IF (TG_OP = 'INSERT') THEN
    RAISE NOTICE 'one line inserted';
  ELSIF (TG_OP = 'DELETE') THEN
    RAISE NOTICE 'one line Deleted';
  ELSIF (TG_OP = 'UPDATE') THEN
    RAISE NOTICE 'one line Updated';
  END IF;
END;
/