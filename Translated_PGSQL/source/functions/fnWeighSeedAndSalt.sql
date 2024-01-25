CREATE FUNCTION fnWeighSeedAndSalt(
    Seed UNIQUEIDENTIFIER,
    Salt UNIQUEIDENTIFIER = NULL
)
RETURNS TABLE AS
BEGIN
    RETURN (
        SELECT
            CAST(
                CAST(
                    CAST(
                        SUBSTRING(
                            CAST(
                                HASHBYTES(
                                    'MD5',
                                    CONCAT(Seed, Salt)
                                ) AS NVARCHAR(32)
                            ),
                            2,
                            4
                        ) AS VARBINARY
                    ) AS INT
                ) AS BIGNUMERIC
            ) AS INT
        ) AS Weight
    );
END;