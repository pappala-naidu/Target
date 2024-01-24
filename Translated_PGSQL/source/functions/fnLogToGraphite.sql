CREATE FUNCTION fnLogToGraphite(
  data STRING(4000),
  host STRING(4000) = 'statsd.csnzoo.com',
  port INT64 = 8125
) RETURNS BOOL
LANGUAGE js AS """
  const {Graphite} = require('graphite');
  const graphite = new Graphite({host, port});
  return graphite.log(data);
""";