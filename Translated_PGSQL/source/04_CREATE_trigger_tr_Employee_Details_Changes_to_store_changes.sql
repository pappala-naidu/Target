CREATE TRIGGER tr_Employee_Details_Changes
BEFORE INSERT OR DELETE OR UPDATE ON Employee_Details
FOR EACH ROW
ENABLE
DECLARE
  v_date  varchar(30);
BEGIN
  SELECT TO_CHAR(CURRENT_TIMESTAMP, 'DD/MON/YYYY HH24:MI:SS') INTO v_date  FROM dual;
  IF INSERTING THEN
    INSERT INTO Employee_Details_Changes (new_name,old_name, entry_date, operation) 
    VALUES(:NEW.emp_name, Null , v_date, 'Insert');  
  ELSIF DELETING THEN
    INSERT INTO Employee_Details_Changes (new_name,old_name, entry_date, operation)
    VALUES(NULL,:OLD.emp_name, v_date, 'Delete');
  ELSIF UPDATING THEN
    INSERT INTO Employee_Details_Changes (new_name,old_name, entry_date, operation) 
    VALUES(:NEW.emp_name, :OLD.emp_name, v_date,'Update');
  END IF;
END;
/