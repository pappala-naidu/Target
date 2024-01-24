CREATE FUNCTION fnGetMailingLibraComponents(EmailListID INT64, Mailing INT64)
RETURNS TABLE (
  TestID INT64,
  TestGroupID INT64
)
AS $$
WITH MailingComponents_CTE AS (
  SELECT
    EmailListID,
    Mailing,
    Target
  FROM
    `database.schema.csn_notif_batch_dbo_tblMailing`
  UNION
  SELECT
    EmailListID,
    Mailing,
    HoldoutTarget
  FROM
    `database.schema.csn_notif_batch_dbo_tblMailing`
  UNION
  SELECT
    EmailListID,
    Mailing,
    Target
  FROM
    `database.schema.csn_marketingemail_dbo_tblMapTargetMailingBatch`
  UNION
  SELECT
    EmailListID,
    Mailing,
    Target
  FROM
    `database.schema.csn_marketingemail_dbo_tblMapTargetMailingVariation`
  UNION
  SELECT
    MailingVariation.EmailListID,
    MailingVariation.Mailing,
    EventTreatments.Target
  FROM
    `database.schema.csn_notif_batch_dbo_tblMailingVariation` AS MailingVariation
    INNER JOIN `database.schema.csn_marketingemail_dbo_tblEventContentStrategyTreatment` AS EventTreatments 
    ON MailingVariation.EventContentStrategy = EventTreatments.EventContentStrategy
    AND MailingVariation.EmailListID = EventTreatments.EmailListID
  WHERE
    EventTreatments.Target IS NOT NULL
  UNION
  SELECT
    MailingVariation.EmailListID,
    MailingVariation.Mailing,
    SkuTreatments.Target
  FROM
    `database.schema.csn_notif_batch_dbo_tblMailingVariation` AS MailingVariation
    INNER JOIN `database.schema.csn_marketingemail_dbo_tblSKUContentStrategyTreatment` AS SkuTreatments 
    ON MailingVariation.SKUContentStrategy = SkuTreatments.SKUContentStrategy
    AND MailingVariation.EmailListID = SkuTreatments.EmailListID
  WHERE
    SkuTreatments.Target IS NOT NULL
  UNION
  SELECT
    MailingVariation.EmailListID,
    MailingVariation.Mailing,
    ArbContentTreatments.Target
  FROM
    `database.schema.csn_notif_batch_dbo_tblMailingVariation` AS MailingVariation
    INNER JOIN `database.schema.csn_marketingemail_dbo_tblArbitraryContentStrategyTreatment` AS ArbContentTreatments 
    ON MailingVariation.ArbitraryContentStrategy = ArbContentTreatments.ArbitraryContentStrategy
    AND MailingVariation.EmailListID = ArbContentTreatments.EmailListID
  WHERE
    ArbContentTreatments.Target IS NOT NULL
),
InputMailingComponents_CTE AS (
  SELECT
    TargetID
  FROM
    MailingComponents_CTE
  WHERE
    EmailListID = EmailListID
    AND Mailing = Mailing
)
SELECT
  DISTINCT TestID,
  TestGroupID
FROM
  InputMailingComponents_CTE
  CROSS JOIN fnGetTargetLibraComponents(EmailListID, TargetID);
$$;