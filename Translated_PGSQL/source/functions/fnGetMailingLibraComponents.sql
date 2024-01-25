CREATE FUNCTION fnGetMailingLibraComponents (EmailListID INT, Mailing INT) 
RETURNS TABLE (
     TestID INT,
     TestGroupID INT
)
AS 
$$
WITH MailingComponents_CTE (EmailListID, Mailing, TargetID) AS (
          SELECT
               EmailListID,
               Mailing,
               Target
          FROM
               csn_notif_batch_dbo_tblMailing 
          UNION
          SELECT
               EmailListID,
               Mailing,
               HoldoutTarget
          FROM
               csn_notif_batch_dbo_tblMailing 
          UNION
          SELECT
               EmailListID,
               Mailing,
               Target
          FROM
               csn_marketingemail_dbo_tblMapTargetMailingBatch 
          UNION
          SELECT
               EmailListID,
               Mailing,
               Target
          FROM
               csn_marketingemail_dbo_tblMapTargetMailingVariation 
          UNION
          SELECT
               MailingVariation.EmailListID,
               MailingVariation.Mailing,
               EventTreatments.Target
          FROM
               csn_notif_batch_dbo_tblMailingVariation AS MailingVariation 
               INNER JOIN csn_marketingemail_dbo_tblEventContentStrategyTreatment AS EventTreatments  ON ISNULL(MailingVariation.EventContentStrategy, 1) = EventTreatments.EventContentStrategy
               AND MailingVariation.EmailListID = EventTreatments.EmailListID
          WHERE
               EventTreatments.Target IS NOT NULL
          UNION
          SELECT
               MailingVariation.EmailListID,
               MailingVariation.Mailing,
               SkuTreatments.Target
          FROM
               csn_notif_batch_dbo_tblMailingVariation AS MailingVariation 
               INNER JOIN csn_marketingemail_dbo_tblSKUContentStrategyTreatment AS SkuTreatments  ON ISNULL(MailingVariation.SKUContentStrategy, 1) = SkuTreatments.SKUContentStrategy
               AND MailingVari ation.EmailListID = SkuTreatments.EmailListID
          WHERE
               SkuTreatments.Target IS NOT NULL
          UNION
          SELECT
               MailingVariation.EmailListID,
               MailingVariation.Mailing,
               ArbContentTreatments.Target
          FROM
               csn_notif_batch_dbo_tblMailingVariation AS MailingVa riation 
               INNER JOIN csn_marketingemail_dbo_tblArbitraryContentStrategyTreatment AS ArbContentTreatments  ON ISNULL(MailingVariation.ArbitraryContentStrategy, 1) = ArbContentTreatments.ArbitraryContentStrategy
               AND MailingVariation.EmailListID = ArbContentTreatments.EmailListID
          WHERE
               ArbContentTreatments.Target IS NOT NULL
     ),
     InputMailingComponents_CTE (TargetID) AS (
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
          CROSS APPLY fnGetTargetLibraComponents(EmailListID, TargetID)
$$
LANGUAGE plpgsql;