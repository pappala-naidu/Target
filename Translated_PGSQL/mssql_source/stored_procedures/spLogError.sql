CREATE OR REPLACE PROCEDURE public.splogerror(
    IN _emaillistid integer,
    IN _mailing integer,
    IN _externaluniqueid uuid,
    IN _comment text,
    OUT _logid integer)
     LANGUAGE plpgsql
    AS $procedure$
        DECLARE
            _procedureid integer;
        BEGIN
            call spcreateexternaluniqueid(_externaluniqueid, _externaluniqueid);

            SELECT
                TOP (1) _procedureid
                INTO _procedureid
            FROM
                public.tblplprocedures
            WHERE
                name = current_user;

            RAISE NOTICE ' %s - %s',
                    to_char(current_timestamp, 'YYYY-MM-DD HH24:MI:SS'),
                    error_message();

            RAISE NOTICE '    in %s at line %d. Error # %d, state %d, severity %d.',
                    current_user,
                    error_line(),
                    error_number(),
                    error_state(),
                    error_severity();

        EXCEPTION
            WHEN others THEN
                RAISE NOTICE 'Error: %', sqlerrm();

        INSERT INTO public.tbllogerror(
            errordatetime,
            message,
            procedurename,
            line,
            errornumber,
            severity,
            state,
            emaillistid,
            mailing,
            externaluniqueid,
            procedureid,
            comment
        )
        VALUES (
            CURRENT_TIMESTAMP,
            error_message(),
            current_user,
            error_line(),
            error_number(),
            error_severity(),
            error_state(),
            _emaillistid,
            _mailing,
            _externaluniqueid,
            _procedureid,
            _comment
        );

        SELECT currval(pg_get_serial_sequence('tbllogerror', 'logid')) INTO _logid;
        END;
    $procedure$
    ;