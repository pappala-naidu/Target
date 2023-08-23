CREATE FUNCTION public.fn_weigh_seed_and_salt(
    _seed uuid,
    _salt uuid = NULL
) RETURNS TABLE AS
RETURN (
    SELECT
        (
            CAST(
                INT,
                CAST(
                    VARBINARY,
                    SUBSTRING(
                        CAST(
                            NVARCHAR(32),
                            HASHBYTES(
                                'MD5',
                                CONCAT(_seed, _salt)
                            ) -- end HASHBYTES
                        ,
                            2
                        ) -- end CONVERT
                    ,
                        1,
                        4
                    ) -- end SUBSTRING
                ,
                    2
                ) -- end CONVERT
            ) -- end CONVERT
        ) AS weight
);