CREATE TABLE `HR.Employees` (
  `GlobalID` INT64,
  `FirstName` STRING(30),
  `LastName` STRING(30),
  `DateOfBirth` DATE,
  `JoinedDate` DATE,
  `DepartmentCode` INT64,
  `aa` DECIMAL,
  `num` NUMERIC,
  `fl` FLOAT64,
  `t1` TIMESTAMP,
  `t2` TIME
) PRIMARY KEY (`GlobalID`);