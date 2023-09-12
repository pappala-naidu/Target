CREATE OR REPLACE FUNCTION tr_Employee_Details_Changes() RETURNS TRIGGER AS
$$
DECLARE
  v_date  varchar(30);
BEGIN
  SELECT TO_CHAR(CURRENT_TIMESTAMP, 'DD/MON/YYYY HH24:MI:SS') INTO v_date  FROM dual;
  IF (TG_OP = 'INSERT') THEN
    INSERT INTO Employee_Details_Changes (new_name,old_name, entry_date, operation) 
    VALUES(NEW.emp_name, Null , v_date, 'Insert');  
  ELSIF (TG_OP = 'DELETE') THEN
    INSERT INTO Employee_Details_Changes (new_name,old_name, entry_date, operation)
    VALUES(NULL,:OLD.emp_name, v_date, 'Delete');
  ELSIF (TG_OP = 'UPDATE') THEN
    INSERT INTO Employee_Details_Changes (new_name,old_name, entry_date, operation) 
    VALUES(:NEW.emp_name, :OLD.emp_name, v_date,'Update');
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_Employee_Details_Changes
BEFORE INSERT OR DELETE OR UPDATE ON Employee_Details
FOR EACH ROW
EXECUTE PROCEDURE tr_Employee_Details_Changes();