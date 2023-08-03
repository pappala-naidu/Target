CREATE OR REPLACE PROCEDURE public.spsetcustomerattributestoredynamicbannerdata(
    storeid integer,
    customerattributetypeid integer,
    customerattribute integer,
    daynumber integer,
    launchurl character varying(3000),
    imageurl character varying(3000),
    alttext character varying(256),
    subjectline character varying(128),
    istask bit,
    username character varying(64))
    LANGUAGE plpgsql
AS $procedure$
DECLARE
    now timestamp with time zone := cast(current_timestamp as timestamp with time zone);
BEGIN
    IF istask = 0 THEN
        UPDATE
            tblrulescustomerattributebanner
        SET
            istask = istask,
            lastupdatedby = username,
            datetimechanged = now
        WHERE
            storeid = storeid
            AND customerattributetypeid = customerattributetypeid
            AND customerattribute = customerattribute
            AND daynumber = daynumber;
    END IF;
    ELSE
        IF NOT EXISTS (
            SELECT
                top 1 1
            FROM
                vwlatestcustomerattributebannerbundlecontent
            WHERE
                storeid = storeid
                AND customerattributetypeid = customerattributetypeid
                AND customerattribute = customerattribute
                AND daynumber = daynumber
                AND launchurl = launchurl
                AND imageurl = imageurl
                -- Perform a case-sensitive comparison
                AND convert(varbinary(256), ltrim(rtrim(alttext))) = convert(varbinary(256), ltrim(rtrim(alttext)))
        ) THEN
            INSERT INTO
                tblcustomerattributebannerbundlecontent (
                    storeid,
                    customerattributetypeid,
                    customerattribute,
                    daynumber,
                    launchurl,
                    imageurl,
                    alttext,
                    username,
                    datetimeadded,
                    subjectline
                )
            VALUES
                (
                    storeid,
                    customerattributetypeid,
                    customerattribute,
                    daynumber,
                    launchurl,
                    imageurl,
                    alttext,
                    username,
                    now,
                    subjectline
                );
        END IF;
        SELECT
            contentblockidentifier
        INTO
            contentblockidentifier
        FROM
            fngetcustomerattributebannercontentblockidentifier(
                storeid,
                customerattributetypeid,
                customerattribute,
                daynumber
            );
        UPDATE
            tblrulescustomerattributebanner
        SET
            contentblock = contentblockidentifier,
            subjectline = subjectline,
            istask = istask,
            lastupdatedby = username,
            datetimechanged = now
        WHERE
            storeid = storeid
            AND customerattributetypeid = customerattributetypeid
            AND customerattribute = customerattribute
            AND daynumber = daynumber;
    END IF;
END;
$procedure$
;