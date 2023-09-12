CREATE PROCEDURE get_employee_details(
    p_employee_id IN INTEGER,
    p_employee_name OUT VARCHAR,
    p_salary OUT INTEGER,
    p_hire_date OUT DATE
)
AS
BEGIN
    SELECT emp_name, salary, hire_date
    INTO p_employee_name, p_salary, p_hire_date
    FROM employee_details
    WHERE employee_id = p_employee_id;
END;