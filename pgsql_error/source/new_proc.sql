CREATE PROCEDURE `sp_employee` (
  `name` STRING(20),
  `id` INT64,
  `dept_no` INT64,
  `dname` STRING(10),
  `errstr` STRING(30))
BEGIN
  SET errstr = 'Duplicate Row.';

  INSERT INTO `employee` (`emp_name`, `emp_no`, `dept_no`)
  VALUES (name, id, dept_no);

END;