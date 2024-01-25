CREATE FUNCTION fnGetTargetLibraComponents (EmailListID INT, Target INT)
RETURNS TABLE
AS
(
    WITH TargetComponents_CTE (UniqueID) AS (
        SELECT
            UniqueID
        FROM
            tblMapTargetInclude 
        WHERE
            EmailListID = EmailListID
            AND Target = Target
        UNION
        SELECT
            UniqueID
        FROM
            tblMapTargetExclude 
        WHERE
            EmailListID = EmailListID
            AND Target = Target
    )
    SELECT
        DISTINCT TestID,
        TestGroupID
    FROM
        csn_libra_dbo_tblTestGroup AS TestGroup 
        INNER JOIN TargetComponents_CTE AS TargetComponents ON (
            TestGroup.TestGroupGuid = TargetComponents.UniqueID
        )
);