CREATE FUNCTION public.fn_weigh_seed_and_salt(
    _seed uuid,
    _salt uuid = NULL
) RETURNS TABLE AS
RETURN (
    SELECT
        (
            CAST(
                INT8,
                CAST(
                    VARBINARY(16),
                    SUBSTRING(
                        CAST(
                            VARCHAR(32),
                            HASHBYTES(
                                'MD5',
                                CONCAT(_seed, _salt)
                            )
                        ),
                        2
                    )
                ),
                2
            )
        ) AS weight
);