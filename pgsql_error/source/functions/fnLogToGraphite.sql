ALTER FUNCTION public.fnlogtographite(
    _data text,
    _host text = 'statsd.csnzoo.com',
    _port integer = 8125
) RETURNS boolean LANGUAGE C IMMUTABLE STRICT AS '
#include "graphite.h"

PG_FUNCTION_INFO_V1(fnlogtographite);

Datum
fnlogtographite(PG_FUNCTION_ARGS)
{
    text *data = PG_GETARG_TEXT_P(0);
    text *host = PG_GETARG_TEXT_P(1);
    int port = PG_GETARG_INT32(2);

    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) {
        ereport(ERROR,
                (errcode(ERRCODE_CONNECTION_FAILURE),
                 errmsg("Could not create socket: %m")));
    }

    struct sockaddr_in serv_addr;
    memset(&serv_addr, 0, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(port);
    inet_pton(AF_INET, host, &serv_addr.sin_addr);

    int n = sendto(sockfd, data, strlen(data), 0, (struct sockaddr *) &serv_addr, sizeof(serv_addr));
    if (n < 0) {
        ereport(ERROR,
                (errcode(ERRCODE_CONNECTION_FAILURE),
                 errmsg("Could not send data to Graphite: %m")));
    }

    close(sockfd);

    PG_RETURN_BOOL(true);
}
';