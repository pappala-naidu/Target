ALTER FUNCTION fnLogToGraphite(
    data VARCHAR(4000),
    host VARCHAR(4000) = 'statsd.csnzoo.com',
    port INTEGER = 8125
)
RETURNS BOOLEAN
EXTERNAL NAME 'Graphite.Graphite.Graphite.LogToGraphite';