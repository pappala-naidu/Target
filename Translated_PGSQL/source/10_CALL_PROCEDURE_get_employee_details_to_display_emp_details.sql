DECLARE
    v_employee_id integer := 1;
    v_employee_name varchar(100);
    v_salary numeric;
    v_hire_date date;
BEGIN
    CALL get_employee_details(v_employee_id, v_employee_name, v_salary, v_hire_date);
    RAISE NOTICE 'Employee Name: %', v_employee_name;
    RAISE NOTICE 'Salary: %', v_salary;
    RAISE NOTICE 'Hire Date: %', v_hire_date;
END;
/