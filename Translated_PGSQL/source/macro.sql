CREATE PROCEDURE Get_Emp() AS 
BEGIN 
  SELECT 
  EmployeeNo, 
  FirstName, 
  LastName 
  FROM  
  employee 
  ORDER BY EmployeeNo; 
END;