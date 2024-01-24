CREATE FUNCTION fnGetCustomerAttributeBannerContentBlockIdentifier (
    StoreID INT64,
    CustomerAttributeTypeID INT64,
    CustomerAttribute INT64,
    DayNumber INT64
)
RETURNS TABLE (
    ContentBlockIdentifier STRING
)
AS $$
WITH LatestTargetCustomerAttribute_CTE AS (
    SELECT
        CustomerAttributeBannerBundleContentID,
        StoreID,
        CustomerAttributeTypeID,
        CustomerAttribute,
        DayNumber
    FROM
        vwLatestCustomerAttributeBannerBundleContent
    WHERE
        StoreID = StoreID
        AND CustomerAttributeTypeID = CustomerAttributeTypeID
        AND CustomerAttribute = CustomerAttribute
        AND DayNumber = DayNumber
)

SELECT
    REPLACE(
        COALESCE(EmailList.NameShorthand, 'MissingEmailListNameShorhand'),
        ' ',
        ''
    ) || '_' ||
    REPLACE(
        REPLACE(
            COALESCE(CustomerAttributeType.Name, 'MissingCustomerAttributeTypeName'),
            ' ',
            ''
        ),
        'InMarket',
        'IM'
    ) || '_' ||
    REPLACE(
        REPLACE(
            COALESCE(CustomerAttributeStore.Name, 'MissingCustomerAttributeStoreName'),
            ' ',
            ''
        ),
        'InMarket',
        'IM'
    ) || '_' ||
    COALESCE(SUBSTR(Weekdays.WeekdayName, 1, 3), 'MissingWeekdayName') || '_' ||
    CAST(BannerContent.CustomerAttributeBannerBundleContentID AS STRING) AS ContentBlockIdentifier

FROM
    LatestTargetCustomerAttribute_CTE AS BannerContent

INNER JOIN
    csn_notif_batch_dbo_tblplEmailLists AS EmailList
ON
    BannerContent.StoreID = EmailList.StoreID

INNER JOIN
    dbo_tblplCustomerAttributeTypes AS CustomerAttributeType
ON
    BannerContent.CustomerAttributeTypeID = CustomerAttributeType.CustomerAttributeTypeID

INNER JOIN
    dbo_tblCustomerAttributeStore AS CustomerAttributeStore
ON
    BannerContent.StoreID = CustomerAttributeStore.StoreID
    AND BannerContent.CustomerAttributeTypeID = CustomerAttributeStore.CustomerAttributeTypeID
    AND BannerContent.CustomerAttribute = CustomerAttributeStore.CustomerAttribute

INNER JOIN
    dbo_tblplWeekday AS Weekdays
ON
    BannerContent.DayNumber = Weekdays.WeekdayID;
$$;