CREATE OR REPLACE PROCEDURE public.spcancelcleanup(
    emaillistid integer,
    mailing integer,
    externaluniqueid uuid)
     LANGUAGE plpgsql
    AS $procedure$
        DECLARE
            logid integer;

        BEGIN
            logid := -1;

            DECLARE logprocedurecleanup integer := 3001;

            CALL public.splogruntimestartprocedure(logprocedurecleanup, emaillistid, mailing, externaluniqueid, logid);

            DECLARE cancelcleanupstatuscode integer := 2;

            UPDATE public.tblregistrycleanup
                SET
                    statuscode = cancelcleanupstatuscode
                WHERE
                    emaillistid = emaillistid
                    AND mailing = mailing
                    AND starteddatetime IS NULL;

            CALL public.splogruntimefinishprocedure(logid);

        END;
    $procedure$
    ;