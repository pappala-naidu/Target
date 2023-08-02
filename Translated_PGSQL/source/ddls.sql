CREATE PROCEDURE `hr.sp_employee`(
  IN name STRING(20),
  IN id INT64,
  IN dept_no INT64,
  OUT dname STRING(10),
  INOUT errstr STRING(30))
BEGIN
DECLARE CONTINUE HANDLER FOR SQLSTATE VALUE '23505'
SET errstr = 'Duplicate Row.';

CREATE PROCEDURE `insert_salary`(
  IN in_employee_no INT64,
  IN in_gross INT64,
  IN in_deduction INT64,
  IN in_net_pay INT64)
BEGIN
INSERT INTO `salary` (
  `employee_no`,
  `gross`,
  `deduction`,
  `net_pay`
)
VALUES (
  :in_employee_no,
  :in_gross,
  :in_deduction,
  :in_net_pay
);
END;

CALL `insert_salary`(105, 20000, 2000, 18000);

CREATE SET TABLE `orders` (
  `store_no` SMALLINT,
  `order_no` INT64,
  `order_date` DATE,
  `order_total` INT64
) PRIMARY INDEX(`order_no`) PARTITION BY RANGE_N (
  `order_date` BETWEEN DATE '2010-01-01' AND '2016-12-31' EACH INTERVAL '1' DAY
);

CREATE VIEW `employee_view` AS
SELECT `employee_no`,
  `first_name`,
  `last_name`
FROM `employee`;

REPLACE VIEW `employee_view` AS
SELECT `employee_no`,
  `first_name`,
  `birth_date`,
  `joined_date`,
  `department_no`
FROM `employee`;

DROP VIEW `employee_view`;

INSERT INTO `employee` (
  `employee_no`,
  `first_name`,
  `last_name`,
  `birth_date`,
  `joined_date`,
  `department_no`
)
VALUES (
  101,
  'Mike',
  'James',
  '1980-01-05',
  '2005-03-27',
  01
);

INSERT INTO `employee` (`emp_name`, `emp_no`, `dept_no`)
VALUES (name, id, dept_no);

UPDATE `employee`
SET `department_no` = 03
WHERE `employee_no` = 101;

DELETE FROM `employee`
WHERE `employee_no` = 101;

SELECT `department_no`, COUNT(*)
FROM `employee`
GROUP BY `department_no`;

SELECT `dept_name`
INTO `dname`
FROM `department`
WHERE `dept_no` = `dept`;

SELECT CONCAT('Tera', 'data')

SELECT `a`.`employee_no`, `a`.`department_no`, `b`.`net_pay`
FROM `employee` AS `a`
INNER JOIN `salary` AS `b`
ON (`a`.`employee_no` = `b`.`employee_no`);

SELECT `employee_no`, `first_name`, `last_name`
FROM `employee_view`;

SELECT EXTRACT(YEAR FROM CURRENT_DATE);

SELECT EXTRACT(YEAR FROM `date`);