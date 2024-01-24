CREATE FUNCTION `fnEmailListUsesFeature` (
  _EmailListID INT64,
  _FeatureName STRING(30)
) AS (
  SELECT f.EmailListFeatureFlagId AS UsesFeature
  FROM `database.schema.csn_notif_batch_dbo_tblplEmailLists` l
  CROSS JOIN `database.schema.tblplEmailLists_tblplEmailListFeatureFlags` f
  WHERE f.FeatureName = _FeatureName
    AND l.EmailListID = _EmailListID
);