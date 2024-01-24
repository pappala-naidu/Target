CREATE FUNCTION fnWeighSeedAndSalt(
    Seed UNIQUEIDENTIFIER,
    Salt UNIQUEIDENTIFIER = NULL
) RETURNS TABLE AS (
    SELECT
        CAST(
            CAST(
                CAST(
                    SUBSTR(
                        CAST(
                            MD5(CONCAT(Seed, Salt)) AS STRING
                        ),
                        3,
                        1
                    ),
                    AS BIGNUMERIC
                ) AS INT64
            ) AS INT64
        ) AS Weight
);