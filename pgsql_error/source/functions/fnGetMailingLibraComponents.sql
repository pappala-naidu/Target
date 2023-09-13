CREATE OR REPLACE FUNCTION public.fngetmailinglibracomponents(integer, integer)
     RETURNS TABLE(testid integer, testgroupid integer)
     LANGUAGE plpgsql
    AS $function$
    BEGIN
         WITH mailingcomponents_cte (emaillistid, mailing, targetid) AS (
             SELECT
                 emaillistid,
                 mailing,
                 target
             FROM
                 public.csn_notif_batch_dbo_tblmailing
                 WITH (NOLOCK)
             UNION
             SELECT
                 emaillistid,
                 mailing,
                 holdouttarget
             FROM
                 public.csn_notif_batch_dbo_tblmailing
                 WITH (NOLOCK)
             UNION
             SELECT
                 emaillistid,
                 mailing,
                 target
             FROM
                 public.csn_marketingemail_dbo_tblmaptargetmailingbatch
                 WITH (NOLOCK)
             UNION
             SELECT
                 emaillistid,
                 mailing,
                 target
             FROM
                 public.csn_marketingemail_dbo_tblmaptargetmailingvariation
                 WITH (NOLOCK)
             UNION
             SELECT
                 mailingvariation.emaillistid,
                 mailingvariation.mailing,
                 eventtreatments.target
             FROM
                 public.csn_notif_batch_dbo_tblmailingvariation AS mailingvariation
                 WITH (NOLOCK)
                 INNER JOIN public.csn_marketingemail_dbo_tbleventcontentstrategytreatment AS eventtreatments
                 WITH (NOLOCK) ON isnull(mailingvariation.eventcontentstrategy, 1) = eventtreatments.eventcontentstrategy
                 AND mailingvariation.emaillistid = eventtreatments.emaillistid
             WHERE
                 eventtreatments.target IS NOT NULL
             UNION
             SELECT
                 mailingvariation.emaillistid,
                 mailingvariation.mailing,
                 skutreatments.target
             FROM
                 public.csn_notif_batch_dbo_tblmailingvariation AS mailingvariation
                 WITH (NOLOCK)
                 INNER JOIN public.csn_marketingemail_dbo_tblskucontentstrategytreatment AS skutreatments
                 WITH (NOLOCK) ON isnull(mailingvariation.skucontentstrategy, 1) = skutreatments.skucontentstrategy
                 AND mailingvariation.emaillistid = skutreatments.emaillistid
             WHERE
                 skutreatments.target IS NOT NULL
             UNION
             SELECT
                 mailingvariation.emaillistid,
                 mailingvariation.mailing,
                 arbcontenttreatments.target
             FROM
                 public.csn_notif_batch_dbo_tblmailingvariation AS mailingvariation
                 WITH (NOLOCK)
                 INNER JOIN public.csn_marketingemail_dbo_tblarbitrarycontentstrategytreatment AS arbcontenttreatments
                 WITH (NOLOCK) ON isnull(mailingvariation.arbitrarycontentstrategy, 1) = arbcontenttreatments.arbitrarycontentstrategy
                 AND mailingvariation.emaillistid = arbcontenttreatments.emaillistid
             WHERE
                 arbcontenttreatments.target IS NOT NULL
         ),
         inputmailingcomponents_cte (targetid) AS (
             SELECT
                 targetid
             FROM
                 mailingcomponents_cte
             WHERE
                 emaillistid = $1
                 AND mailing = $2
         )
         SELECT
             DISTINCT testid,
             testgroupid
         FROM
             inputmailingcomponents_cte
             CROSS APPLY public.fngettargetlibracomponents($1, targetid)
    END;
    $function$
    ;