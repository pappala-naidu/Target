CREATE OR REPLACE PROCEDURE public.splogruntimefinishprocedure(IN _logid integer)
                     LANGUAGE plpgsql
                    AS $procedure$
                       DECLARE _procedurename VARCHAR(128);
                       DECLARE _procedurestart TIMESTAMP;
                       DECLARE _procedureend TIMESTAMP;
                    BEGIN
                       UPDATE tblLogRunTime
                       SET FinishedDatetime = CURRENT_TIMESTAMP
                       WHERE LogID = _logid;

                       SELECT p.Name, r.StartedDatetime, r.FinishedDatetime
                       INTO _procedurename, _procedurestart, _procedureend
                       FROM tblLogRunTime AS r
                       JOIN tblplProcedures AS p ON r.ProcedureID = p.ProcedureID
                       WHERE LogID = _logid;

                       RAISE NOTICE 'Finished %', _procedurename;
                    END
                    $procedure$
                    ;