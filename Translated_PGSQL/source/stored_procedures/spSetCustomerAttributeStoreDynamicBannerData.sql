CREATE OR REPLACE PROCEDURE `spSetCustomerAttributeStoreDynamicBannerData`
(
  _StoreID INT64,
  _CustomerAttributeTypeID INT64,
  _CustomerAttribute INT64,
  _DayNumber INT64,
  _LaunchURL STRING,
  _ImageURL STRING,
  _AltText STRING,
  _SubjectLine STRING,
  _IsActive BOOL,
  _Username STRING
)
AS $$
BEGIN
  SET NOCOUNT ON;
  DECLARE Now TIMESTAMP = CURRENT_TIMESTAMP;

  IF _IsActive = FALSE THEN
    UPDATE `tblRulesCustomerAttributeBanner`
    SET
      IsActive = _IsActive,
      LastUpdatedBy = _Username,
      DatetimeChanged = Now
    WHERE
      StoreID = _StoreID
      AND CustomerAttributeTypeID = _CustomerAttributeTypeID
      AND CustomerAttribute = _CustomerAttribute
      AND DayNumber = _DayNumber;
  ELSE
    IF NOT EXISTS (
      SELECT 1
      FROM `vwLatestCustomerAttributeBannerBundleContent`
      WHERE
        StoreID = _StoreID
        AND CustomerAttributeTypeID = _CustomerAttributeTypeID
        AND CustomerAttribute = _CustomerAttribute
        AND DayNumber = _DayNumber
        AND LaunchURL = _LaunchURL
        AND ImageURL = _ImageURL
        AND AltText = _AltText
    ) THEN
      INSERT INTO `tblCustomerAttributeBannerBundleContent` (
        StoreID,
        CustomerAttributeTypeID,
        CustomerAttribute,
        DayNumber,
        LaunchURL,
        ImageURL,
        AltText,
        Username,
        DatetimeAdded,
        SubjectLine
      )
      VALUES (
        _StoreID,
        _CustomerAttributeTypeID,
        _CustomerAttribute,
        _DayNumber,
        _LaunchURL,
        _ImageURL,
        _AltText,
        _Username,
        Now,
        _SubjectLine
      );
    END IF;
    DECLARE ContentBlockIdentifier STRING;

    SELECT ContentBlockIdentifier
    INTO ContentBlockIdentifier
    FROM `fnGetCustomerAttributeBannerContentBlockIdentifier`(
      _StoreID,
      _CustomerAttributeTypeID,
      _CustomerAttribute,
      _DayNumber
    );
    UPDATE `tblRulesCustomerAttributeBanner`
    SET
      ContentBlock = ContentBlockIdentifier,
      Subjectline = _SubjectLine,
      IsActive = _IsActive,
      LastUpdatedBy = _Username,
      DatetimeChanged = Now
    WHERE
      StoreID = _StoreID
      AND CustomerAttributeTypeID = _CustomerAttributeTypeID
      AND CustomerAttribute = _CustomerAttribute
      AND DayNumber = _DayNumber;
  END IF;
END;