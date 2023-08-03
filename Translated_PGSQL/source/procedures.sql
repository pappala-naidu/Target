CREATE PROCEDURE InsertSalary(
  IN in_EmployeeNo INT64,
  IN in_Gross INT64,
  IN in_Deduction INT64,
  IN in_NetPay INT64
)
BEGIN
  INSERT INTO Salary(
    EmployeeNo,
    Gross,
    Deduction,
    NetPay
  )
  VALUES(
    in_EmployeeNo,
    in_Gross,
    in_Deduction,
    in_NetPay
  );
END;