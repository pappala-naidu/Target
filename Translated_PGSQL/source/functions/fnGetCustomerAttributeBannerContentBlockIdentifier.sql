CREATE OR REPLACE FUNCTION public.fngetcustomerattributebannercontentblockidentifier(
    storeid integer,
    customerattributetypeid integer,
    customerattribute integer,
    daynumber integer)
    RETURNS TABLE(contentblockidentifier text)
    LANGUAGE plpgsql
AS $function$
BEGIN
    WITH latesttargetcustomerattribute_cte(customerattributebannerbundlecontentid, storeid, customerattributetypeid, customerattribute, daynumber) AS (
        SELECT customerattributebannerbundlecontentid, storeid, customerattributetypeid, customerattribute, daynumber
        FROM dbo.vwlatestcustomerattributebannerbundlecontent
        WHERE storeid = $1
        AND customerattributetypeid = $2
        AND customerattribute = $3
        AND daynumber = $4
    )
    SELECT (
            REPLACE(COALESCE(emaillist.nameshorthand, 'MissingEmailListNameShorhand'), ' ', '') + '_' +
            REPLACE(REPLACE(COALESCE(customerattributetype.name, 'MissingCustomerAttributeTypeName'), ' ', ''), 'InMarket', 'IM') + '_' +
            REPLACE(REPLACE(COALESCE(customerattributestore.name, 'MissingCustomerAttributeStoreName'), ' ', ''), 'InMarket', 'IM') + '_' +
            COALESCE(SUBSTRING(weekdays.weekdayname, 1, 3), 'MissingWeekdayName') + '_' +
            CAST(bannercontent.customerattributebannerbundlecontentid AS NVARCHAR)
        ) AS contentblockidentifier
    FROM latesttargetcustomerattribute_cte AS bannercontent
    INNER JOIN dbo.csn_notif_batch_dbo_tblplemaillists AS emaillist (NOLOCK)
    ON (bannercontent.storeid = emaillist.storeid)
    INNER JOIN dbo.dbo_tblplcustomerattributetypes AS customerattributetype (NOLOCK)
    ON (bannercontent.customerattributetypeid = customerattributetype.customerattributetypeid)
    INNER JOIN dbo.dbo_tblcustomerattributestore AS customerattributestore (NOLOCK)
    ON (bannercontent.storeid = customerattributestore.storeid
        AND bannercontent.customerattributetypeid = customerattributestore.customerattributetypeid
        AND bannercontent.customerattribute = customerattributestore.customerattribute)
    INNER JOIN dbo.dbo_tblplweekday AS weekdays
    ON (bannercontent.daynumber = weekdays.weekdayid)
END;
$function$
;