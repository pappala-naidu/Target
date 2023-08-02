CREATE FUNCTION InsertSalary(
  in_EmployeeNo INT64,
  in_Gross INT64,
  in_Deduction INT64,
  in_NetPay INT64
)
AS (
  INSERT INTO Salary (
    EmployeeNo,
    Gross,
    Deduction,
    NetPay
  )
  VALUES (
    in_EmployeeNo,
    in_Gross,
    in_Deduction,
    in_NetPay
  )
);