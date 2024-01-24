CREATE FUNCTION fnIsTestActive(TestID INT64, Date DATE) RETURNS BOOL AS (
  WITH Date_CTE AS (
    SELECT
      CAST(
        COALESCE(Date, CAST(CURRENT_TIMESTAMP AS DATE)) AS DATETIME
      ) AS InputDate
  ),
  IsActive_CTE AS (
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
    CAST(COUNT(*) AS BOOL) AS IsActive
  FROM
    IsActive_CTE
);