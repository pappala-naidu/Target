CREATE TABLE `DimAccount` (
  `AccountKey` INT64 NOT NULL,
  `ParentAccountKey` INT64,
  `AccountCodeAlternateKey` INT64,
  `ParentAccountCodeAlternateKey` INT64,
  `AccountDescription` STRING(50) CHARACTER SET 'latin' NOT CASESPECIFIC NOT NULL,
  `AccountType` STRING(50) CHARACTER SET 'latin' NOT CASESPECIFIC,
  `"Operator"` STRING(50) CHARACTER SET 'latin' NOT CASESPECIFIC,
  `CustomMembers` STRING(300) CHARACTER SET 'latin' NOT CASESPECIFIC,
  `ValueType` STRING(50) CHARACTER SET 'latin' NOT CASESPECIFIC,
  `CustomMemberOptions` STRING(200) CHARACTER SET 'latin' NOT CASESPECIFIC
);