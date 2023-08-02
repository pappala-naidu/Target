CREATE TABLE `DimAccount` (
  `AccountKey` INT64 NOT NULL,
  `ParentAccountKey` INT64,
  `AccountCodeAlternateKey` INT64,
  `ParentAccountCodeAlternateKey` INT64,
  `AccountDescription` STRING(50) CHARACTER SET 'UTF-8' NOT NULL,
  `AccountType` STRING(50) CHARACTER SET 'UTF-8',
  `"Operator"` STRING(50) CHARACTER SET 'UTF-8',
  `CustomMembers` STRING(300) CHARACTER SET 'UTF-8',
  `ValueType` STRING(50) CHARACTER SET 'UTF-8',
  `CustomMemberOptions` STRING(200) CHARACTER SET 'UTF-8'
)
