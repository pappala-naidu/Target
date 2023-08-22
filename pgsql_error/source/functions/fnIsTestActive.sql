CREATE OR REPLACE FUNCTION public.fnistestactive(testid integer, date date DEFAULT NULL)
     RETURNS TABLE(isactive boolean)
     LANGUAGE plpgsql
    AS $function$
    BEGIN
         WITH date_cte(inputdate) AS (
             SELECT
                 CAST(
                     COALESCE(date, CAST(CURRENT_TIMESTAMP AS DATE)) AS TIMESTAMP
                 ) AS inputdate
         ),
         isActive_cte(isactive) AS (
             SELECT
                 TOP 1 1
             FROM
                 public.csn_libra_dbo_tbltest AS test
                 CROSS JOIN date_cte
             WHERE
                 test.testid = testid
                 AND test.testlaunched IS NOT NULL
                 AND test.testcancelled IS NULL
                 AND date_cte.inputdate BETWEEN test.teststart
                 AND test.testend
         )
         SELECT
             CAST(COUNT(*) AS BOOLEAN) AS isactive
         FROM
             isActive_cte;
    END;
    $function$
    ;