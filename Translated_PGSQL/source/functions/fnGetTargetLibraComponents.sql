CREATE FUNCTION fnGetTargetLibraComponents(EmailListID INT64, Target INT64)
RETURNS TABLE (
  TestID INT64,
  TestGroupID INT64
)
AS $$
WITH TargetComponents_CTE AS (
  SELECT
    UniqueID
  FROM
    database.schema.tblMapTargetInclude
  WHERE
    EmailListID = EmailListID
    AND Target = Target
  UNION
  SELECT
    UniqueID
  FROM
    database.schema.tblMapTargetExclude
  WHERE
    EmailListID = EmailListID
    AND Target = Target
)
SELECT
  DISTINCT TestID,
  TestGroupID
FROM
  database.schema.csn_libra_dbo_tblTestGroup AS TestGroup
JOIN TargetComponents_CTE AS TargetComponents ON (
  TestGroup.TestGroupGuid = TargetComponents.UniqueID
);
$$;