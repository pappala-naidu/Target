CREATE OR REPLACE PROCEDURE public.splogerror(IN _emaillistid integer, IN _mailing integer, IN _externaluniqueid uuid, IN _comment text, OUT _logid integer)
     LANGUAGE plpgsql
AS $procedure$
BEGIN
    BEGIN
        PERFORM public.spcreateexternaluniqueid(_externaluniqueid, _externaluniqueid);

        DECLARE _procedureid integer;

        SELECT
            TOP (1) _procedureid
        INTO _procedureid
        FROM
            public.tblplprocedures
        WHERE
            name = current_user;

        RAISE NOTICE ' %s - %s',
                    to_char(current_timestamp, 'YYYY-MM-DD HH24:MI:SS'),
                    pg_last_error();

        RAISE NOTICE '    in %s at line %d. Error # %d, state %d, severity %d.',
                    current_user,
                    pg_line_number(),
                    pg_error_message_detail(),
                    pg_error_state(),
                    pg_error_severity();

    END;

    BEGIN
        EXCEPTION
            WHEN others THEN
                RAISE NOTICE 'Error: %s', pg_last_error();
    END;

    INSERT INTO
        public.tbllogerror(
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
    VALUES
        (
            CURRENT_TIMESTAMP,
            pg_last_error(),
            current_user,
            pg_line_number(),
            pg_error_message_detail(),
            pg_error_severity(),
            pg_error_state(),
            _emaillistid,
            _mailing,
            _externaluniqueid,
            _procedureid,
            _comment
        );

    SELECT
        currval(pg_get_serial_sequence('public.tbllogerror', 'logid'))
        INTO _logid;

END
$procedure$
;