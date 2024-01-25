CREATE PROCEDURE spCreateExternalUniqueID (
    _InputUniqueID UNIQUEIDENTIFIER = NULL,
    _OutputUniqueID UNIQUEIDENTIFIER OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE _ExternalUniqueID UNIQUEIDENTIFIER = _InputUniqueID;

    IF _ExternalUniqueID IS NULL
    AND CONTEXT_INFO() IS NULL
    THEN
        SET _ExternalUniqueID = NEWID();
    END;

    IF _ExternalUniqueID IS NOT NULL
    THEN
        SET CONTEXT_INFO(_ExternalUniqueID);
    ELSE IF CONTEXT_INFO() IS NOT NULL
    THEN
        SET _ExternalUniqueID = CAST(CONTEXT_INFO() AS UNIQUEIDENTIFIER);
    END;

    SET _OutputUniqueID = _ExternalUniqueID;
END;