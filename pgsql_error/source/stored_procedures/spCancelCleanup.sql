CREATE OR REPLACE PROCEDURE public.spcancelcleanup(
    emaillistid integer,
    mailing integer,
    externaluniqueid uuid)
     LANGUAGE plpgsql
    AS $procedure$
        DECLARE
            logid integer := -1;

            logprocedurecleanup integer := 3001;

        BEGIN
            CALL splogruntimestartprocedure(logprocedurecleanup, emaillistid, mailing, externaluniqueid, logid);

            DECLARE cancelcleanupstatuscode integer := 2;

            UPDATE
                dbo.tblregistrycleanup
            SET
                statuscode = cancelcleanupstatuscode
            WHERE
                emaillistid = emaillistid
                AND mailing = mailing
                AND starteddatetime IS NULL;

            CALL splogruntimefinishprocedure(logid);

        END;
    $procedure$
    ;