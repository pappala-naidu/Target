CREATE OR REPLACE FUNCTION public.fngetcustomerattributebannercontentblockidentifier(
    storeid integer,
    customerattributetypeid integer,
    customerattribute integer,
    daynumber integer)
    RETURNS TABLE(
        contentblockidentifier text
    )
    LANGUAGE plpgsql
AS $function$
BEGIN
    WITH latesttargetcustomerattribute_cte(
        customerattributebannerbundlecontentid,
        storeid,
        customerattributetypeid,
        customerattribute,
        daynumber
    ) AS (
        SELECT
            customerattributebannerbundlecontentid,
            storeid,
            customerattributetypeid,
            customerattribute,
            daynumber
        FROM public.vwlatestcustomerattributebannerbundlecontent
        WHERE storeid = $1
        AND customerattributetypeid = $2
        AND customerattribute = $3
        AND daynumber = $4
    )
    SELECT (
        REPLACE(COALESCE(emaillist.nameshorthand, 'MissingEmailListNameShorhand'), ' ', '')
        || '_'
        || REPLACE(
            REPLACE(COALESCE(customerattributetype.name, 'MissingCustomerAttributeTypeName'), ' ', ''),
            'InMarket',
            'IM'
        )
        || '_'
        || REPLACE(
            REPLACE(COALESCE(customerattributestore.name, 'MissingCustomerAttributeStoreName'), ' ', ''),
            'InMarket',
            'IM'
        )
        || '_'
        || COALESCE(SUBSTRING(weekdays.weekdayname, 1, 3), 'MissingWeekdayName')
        || '_'
        || CAST(bannercontent.customerattributebannerbundlecontentid AS text)
    ) AS contentblockidentifier
    FROM latesttargetcustomerattribute_cte AS bannercontent
    INNER JOIN public.csn_notif_batch_dbo_tblplemaillists AS emaillist ON (
        bannercontent.storeid = emaillist.storeid
    )
    INNER JOIN public.dbo_tblplcustomerattributetypes AS customerattributetype ON (
        bannercontent.customerattributetypeid = customerattributetype.customerattributetypeid
    )
    INNER JOIN public.dbo_tblcustomerattributestore AS customerattributestore ON (
        bannercontent.storeid = customerattributestore.storeid
        AND bannercontent.customerattributetypeid = customerattributestore.customerattributetypeid
        AND bannercontent.customerattribute = customerattributestore.customerattribute
    )
    INNER JOIN public.dbo_tblplweekday AS weekdays ON (
        bannercontent.daynumber = weekdays.weekdayid
    );
END;
$function$
;