CREATE OR REPLACE PROCEDURE public.splockasynclistbuild(IN _emaillistid integer, IN _procedurename VARCHAR(256), IN _externaluniqueid uuid, OUT _lockid integer)
                     LANGUAGE plpgsql
                    AS $procedure$
                       DECLARE _locktypelistid INT = 1;
                       DECLARE _locktypeasyncprocess INT = 2;
                       DECLARE _islockedasyncproc BOOLEAN = true;
                    BEGIN
                       BEGIN TRANSACTION;
                       SELECT spislocked(_emaillistid, _locktypeasyncprocess) INTO _islockedasyncproc;
                       IF _islockedasyncproc = false THEN
                           SELECT splock(_emaillistid, _locktypelistid, 'spasynclistbuild', _externaluniqueid) INTO _lockid;
                       END IF;
                       COMMIT;
                       RETURN _lockid;
                    END
                    $procedure$
                    ;