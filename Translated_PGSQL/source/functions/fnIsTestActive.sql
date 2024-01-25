CREATE FUNCTION fnIsTestActive (TestID INT, Date DATE = NULL)
RETURNS TABLE (IsActive BIT)
AS
BEGIN
    WITH Date_CTE (InputDate) AS (
        SELECT
            CAST(
                COALESCE(Date, CAST(CURRENT_TIMESTAMP AS DATE)) AS DATETIME2
            ) AS InputDate
    ),
    IsActive_CTE (IsActive) AS (
        SELECT
            LIMIT 1 1
        FROM
            csn_libra_dbo_tblTest AS Test 
            CROSS JOIN Date_CTE
        WHERE
            Test.TestId = TestID
            AND Test.TestLaunched IS NOT NULL
            AND Test.TestCancelled IS NULL
            AND Date_CTE.InputDate BETWEEN Test.TestStart
            AND Test.TestEnd
    )
    SELECT
        CAST(COUNT(*) AS BIT) AS IsActive
    FROM
        IsActive_CTE;
END;