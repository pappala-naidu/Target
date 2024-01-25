CREATE PROCEDURE spSetCustomerAttributeStoreDynamicBannerData (
    IN StoreID INTEGER,
    IN CustomerAttributeTypeID INTEGER,
    IN CustomerAttribute INTEGER,
    IN DayNumber INTEGER,
    IN LaunchURL VARCHAR(3000),
    IN ImageURL VARCHAR(3000),
    IN AltText VARCHAR(256),
    IN SubjectLine VARCHAR(128),
    IN IsActive BOOLEAN,
    IN Username VARCHAR(64)
)
BEGIN
    SET NOCOUNT ON;
    DECLARE Now TIMESTAMP(6) = CAST(CURRENT_TIMESTAMP AS TIMESTAMP(6));

    IF IsActive = FALSE THEN
        UPDATE tblRulesCustomerAttributeBanner
        SET IsActive = IsActive,
            LastUpdatedBy = Username,
            DatetimeChanged = Now
        WHERE StoreID = StoreID
            AND CustomerAttributeTypeID = CustomerAttributeTypeID
            AND CustomerAttribute = CustomerAttribute
            AND DayNumber = DayNumber;
    ELSE
        IF NOT EXISTS (
            SELECT 1
            FROM vwLatestCustomerAttributeBannerBundleContent
            WHERE StoreID = StoreID
                AND CustomerAttributeTypeID = CustomerAttributeTypeID
                AND CustomerAttribute = CustomerAttribute
                AND DayNumber = DayNumber
                AND LaunchURL = LaunchURL
                AND ImageURL = ImageURL -- Perform a case-sensitive comparison
                AND AltText = AltText
        ) THEN
            INSERT INTO tblCustomerAttributeBannerBundleContent (
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
                StoreID,
                CustomerAttributeTypeID,
                CustomerAttribute,
                DayNumber,
                LaunchURL,
                ImageURL,
                AltText,
                Username,
                Now,
                SubjectLine
            );
        END;

        DECLARE ContentBlockIdentifier VARCHAR(256);

        SELECT ContentBlockIdentifier
        FROM fnGetCustomerAttributeBannerContentBlockIdentifier(
            StoreID,
            CustomerAttributeTypeID,
            CustomerAttribute,
            DayNumber
        )
        INTO ContentBlockIdentifier;

        UPDATE tblRulesCustomerAttributeBanner
        SET ContentBlock = ContentBlockIdentifier,
            Subjectline = SubjectLine,
            IsActive = IsActive,
            LastUpdatedBy = Username,
            DatetimeChanged = Now
        WHERE StoreID = StoreID
            AND CustomerAttributeTypeID = CustomerAttributeTypeID
            AND CustomerAttribute = CustomerAttribute
            AND DayNumber = DayNumber;
    END;
END;