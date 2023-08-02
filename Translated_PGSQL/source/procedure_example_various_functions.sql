CREATE OR REPLACE PROCEDURE ExampleProcedure(
in_empid INT64,
in_empfname STRING(50),
in_emplname STRING(50),
in_department STRING(50),
in_project STRING(50),
in_address STRING(100),
in_dob DATETIME,
in_gender STRING(20),
in_empposition STRING(50),
in_dateofjoining DATE,
in_salary INT64
)
BEGIN
DECLARE nand_result INT64;
DECLARE dob_day INT64;
DECLARE joined_date DATE;

-- Calculate the intNand of the salary
SET nand_result = in_salary & in_empid;

-- Check if address is NULL and replace with a default value
SET in_dob = IFNULL(in_dob, CURRENT_DATETIME);

-- Extract the day of the year from the Date of Birth
SET dob_day = Extract(DAYOFYEAR FROM in_dob);

-- Add 3 months to the Date of Joining
SET joined_date = DATE_ADD(in_dateofjoining, INTERVAL 3 MONTH);

-- Insert into EmployeeInfo table with NVL function
INSERT INTO `your_project.your_dataset.EmployeeInfo` (EmpID, EmpFname, EmpLname, Department, Project, Address, DOB, Gender)
VALUES (in_empid, in_empfname, in_emplname, in_department, in_project, IFNULL(in_address, 'No Address'), in_dob, in_gender);

-- Insert into EmployeePosition table
INSERT INTO `your_project.your_dataset.EmployeePosition` (EmpID, EmpPosition, DateOfJoining, Salary)
VALUES (in_empid, in_empposition, in_dateofjoining, in_salary);

-- SELECT NOW() as current_timestamp;

-- COMMIT;
END;