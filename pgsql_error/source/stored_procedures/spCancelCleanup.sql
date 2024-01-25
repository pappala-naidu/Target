CREATE OR REPLACE PROCEDURE public.spcancelcleanup(IN _emaillistid integer, IN _mailing integer, IN _externaluniqueid uuid)
                     LANGUAGE plpgsql
                    AS $procedure$
                       DECLARE _logid integer;
                       DECLARE _logprocedurecleanup integer := 3001;
                       DECLARE _cancelcleanupstatuscode integer := 2;
                    BEGIN
                       call splogruntimestartprocedure(_logprocedurecleanup, _emaillistid, _mailing, _externaluniqueid, _logid);
                       UPDATE dbo.tblregistrycleanup
                       SET
                          statuscode = _cancelcleanupstatuscode
                       WHERE
                          emaillistid = _emaillistid
                          AND mailing = _mailing
                          AND starteddatetime IS NULL;
                       call splogruntimefinishprocedure(_logid);
                    END
                    $procedure$
                    ;