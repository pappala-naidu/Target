CREATE OR REPLACE FUNCTION public.fnisactive(integer, DATE)
 RETURNS TABLE(isactive boolean)
 LANGUAGE plpgsql
AS $function$
WITH Date_CTE (InputDate) AS (
    SELECT
        CAST(
            COALESCE($2, CAST(CURRENT_DATE AS DATE)) AS TIMESTAMP
        ) AS InputDate
),
IsActive_CTE (IsActive) AS (
    SELECT
        1
    FROM
        public.csn_libra_dbo_tbltest AS Test
        CROSS JOIN Date_CTE
    WHERE
        Test.testid = $1
        AND Test.testlaunched IS NOT NULL
        AND Test.testcancelled IS NULL
        AND Date_CTE.InputDate BETWEEN Test.teststart
        AND Test.testend
)
SELECT
    CAST(COUNT(*) AS BOOLEAN) AS IsActive
FROM
    IsActive_CTE;
$function$;