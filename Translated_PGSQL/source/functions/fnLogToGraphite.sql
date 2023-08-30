CREATE FUNCTION fnLogToGraphite(
    _data nvarchar(4000),
    _host nvarchar(4000) = N'statsd.csnzoo.com',
    _port int = 8125
) RETURNS bit AS $$
BEGIN
    RETURN 1;
END;
$$ LANGUAGE plpgsql;