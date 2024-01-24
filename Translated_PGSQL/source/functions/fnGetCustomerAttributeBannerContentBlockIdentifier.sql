CREATE OR REPLACE FUNCTION public.fngetcustomerattributebannercontentblockidentifier(integer, integer, integer, integer)
 RETURNS TABLE(contentblockidentifier text)
 LANGUAGE plpgsql
AS $function$
WITH LatestTargetCustomerAttribute_CTE (customerattributebannerbundlecontentid, storeid, customerattributetypeid, customerattribute, daynumber) 
    AS 
    ( 
        SELECT customerattributebannerbundlecontentid, storeid, customerattributetypeid, customerattribute, daynumber 
        FROM vwlatestcustomerattributebannerbundlecontent 
        WHERE storeid = $1 
        AND customerattributetypeid = $2 
        AND customerattribute = $3 
        AND daynumber = $4 
    ) 
    SELECT ( 
            REPLACE(COALESCE(emailist.nameshorthand, 'MissingEmailListNameShorhand'), ' ', '') || '_' || 
            REPLACE(REPLACE(COALESCE(customerattributetype.name, 'MissingCustomerAttributeTypeName'), ' ', ''), 'InMarket', 'IM') || '_' || 
            REPLACE(REPLACE(COALESCE(customerattributestorestore.name, 'MissingCustomerAttributeStoreName'), ' ', ''), 'InMarket', 'IM') || '_' || 
            COALESCE(SUBSTRING(weekdays.weekdayname, 1, 3), 'MissingWeekdayName') || '_' || 
            CAST(bannercontent.customerattributebannerbundlecontentid AS VARCHAR) 
        ) AS contentblockidentifier 
 
    FROM LatestTargetCustomerAttribute_CTE AS bannercontent 
 
    INNER JOIN csn_notif_batch_dbo_tblplemaillists AS emailist ON (bannercontent.storeid = emailist.storeid) 
 
    INNER JOIN dbo_tblplcustomerattributetypes AS customerattributetype ON (bannercontent.customerattributetypeid = customerattributetype.customerattributetypeid) 
 
    INNER JOIN dbo_tblcustomerattributestorestore AS customerattributestorestore ON (bannercontent.storeid = customerattributestorestore.storeid 
    AND bannercontent.customerattributetypeid = customerattributestorestore.customerattributetypeid 
    AND bannercontent.customerattribute = customerattributestorestore.customerattribute) 
 
    INNER JOIN dbo_tblplweekday AS weekdays ON (bannercontent.daynumber = weekdays.weekdayid) 
;$function$
;