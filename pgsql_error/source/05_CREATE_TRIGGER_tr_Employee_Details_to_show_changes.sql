CREATE TRIGGER tr_Employee_Details
BEFORE INSERT OR DELETE OR UPDATE ON Employee_Details
FOR EACH ROW
ENABLE
BEGIN

  IF INSERTING THEN
    RAISE NOTICE 'one line inserted';
  ELSIF DELETING THEN
    RAISE NOTICE 'one line Deleted';
  ELSIF UPDATING THEN
    RAISE NOTICE 'one line Updated';
  END IF;
END;
/