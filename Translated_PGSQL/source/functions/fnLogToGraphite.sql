ALTER FUNCTION public.fnlogtographite(
    _data VARCHAR(4000),
    _host VARCHAR(4000) = 'statsd.csnzoo.com',
    _port INTEGER = 8125
) RETURNS BIT
LANGUAGE C
AS '$libdir/graphite/graphite.so', 'LogToGraphite';