CREATE FUNCTION fnEmailListUsesFeature(EmailListID INT, FeatureName VARCHAR(30))
RETURNS TABLE
AS
BEGIN
    RETURN (
        SELECT f.EmailListFeatureFlagId AS UsesFeature
        FROM csn_notif_batch_dbo_tblplEmailLists l 
        CROSS JOIN tblplEmailLists_tblplEmailListFeatureFlags f 
        WHERE f.FeatureName = FeatureName 
          AND l.EmailListID = EmailListID 
    );
END;