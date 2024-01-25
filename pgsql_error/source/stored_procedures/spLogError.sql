ALTER PROCEDURE public.splogerror(IN _emaillistid integer, IN _mailing integer, IN _externaluniqueid uuid, IN _comment VARCHAR(256), OUT _logid integer)
                     LANGUAGE plpgsql
                    AS $procedure$
                       DECLARE _procedureid integer;
                    BEGIN
                       call spCreateExternalUniqueID(_externaluniqueid, _externaluniqueid);


                       SELECT procedureid 
                        INTO _procedureid 
                        FROM tblplprocedures 
                        WHERE name = ERROR_PROCEDURE() 
                        LIMIT 1;
                        RAISE NOTICE '% - %', CONVERT(VARCHAR(100), GETDATE(), 21),
                        ERROR_MESSAGE();

                        RAISE NOTICE '    in %s at line %d. Error # %d, state %d, severity %d.',
                        ERROR_PROCEDURE(),
                        ERROR_LINE(),
                        ERROR_NUMBER(),
                        ERROR_STATE(),
                        ERROR_SEVERITY();

                        INSERT INTO tbllogerror(
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
                        )VALUES(
                            CURRENT_TIMESTAMP,
                            ERROR_MESSAGE(),
                            ERROR_PROCEDURE(),
                            ERROR_LINE(),
                            ERROR_NUMBER(),
                            ERROR_SEVERITY(),
                            ERROR_STATE(),
                            _emaillistid,
                            _mailing,
                            _externaluniqueid,
                            _procedureid,
                            _comment
                        );



                    SELECT currval(pg_get_serial_sequence('tblLogError', 'logid')) INTO _logid;
                    END
                    $procedure$
                    ;