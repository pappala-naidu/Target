CREATE OR REPLACE PROCEDURE public.splockasynclistbuild(
    IN _emaillistid integer,
    IN _procedurename character varying,
    IN _externaluniqueid uuid,
    OUT _lockid integer)
     LANGUAGE plpgsql
    AS $procedure$
        DECLARE
            _locktypelistbuild integer := 1;
            _locktypeasyncprocess integer := 2;
            _islockedasyncproc boolean := true;
        BEGIN
            BEGIN;
                -- CHECK LOCKED
                SELECT _islockedasyncproc INTO _islockedasyncproc
                FROM public.spislocked(_emaillistid, _locktypeasyncprocess);

                IF _islockedasyncproc = false THEN
                    -- ASYNC PROCESS LOCK
                    SELECT _lockid INTO _lockid
                    FROM public.splock(_emaillistid, _locktypelistbuild, _procedurename, _externaluniqueid);
                END IF;

            COMMIT;
            RETURN _lockid;
        END;
    $procedure$
    ;