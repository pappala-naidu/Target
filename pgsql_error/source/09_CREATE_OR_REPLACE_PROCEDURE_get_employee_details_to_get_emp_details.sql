CREATE OR REPLACE PROCEDURE get_employee_details(
    p_employee_id integer,
    p_employee_name OUT varchar,
    p_salary OUT integer,
    p_hire_date OUT date
)
AS
BEGIN
    SELECT emp_name, salary, hire_date
    INTO p_employee_name, p_salary, p_hire_date
    FROM employee_details
    WHERE employee_id = p_employee_id;
END;