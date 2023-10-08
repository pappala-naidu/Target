CREATE FUNCTION fnIsTestActive(
    _TestID INT,
    _Date DATE = NULL
) RETURNS TABLE AS
$$
BEGIN
WITH Date_CTE AS (
    SELECT
        CAST(
            COALESCE(_Date, CAST(CURRENT_TIMESTAMP AS DATE)) AS TIMESTAMP
        ) AS InputDate
),
IsActive_CTE AS (
    SELECT
        1
    FROM
        csn_libra_dbo_tblTest AS Test
        CROSS JOIN Date_CTE
    WHERE
        Test.TestId = _TestId
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
$$ LANGUAGE plpgsql;