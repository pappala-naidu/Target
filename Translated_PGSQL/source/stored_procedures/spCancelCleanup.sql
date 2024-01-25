CREATE PROCEDURE spCancelCleanup(EmailListID INT, Mailing INT, ExternalUniqueID UNIQUEIDENTIFIER = NULL)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE LogID INT = -1;

    DECLARE LogProcedureCleanup INT = 3001;

    EXECUTE spLogRunTimeStartProcedure(LogProcedureCleanup, EmailListID, Mailing, ExternalUniqueID, LogID OUTPUT);

    DECLARE CancelCleanupStatusCode INT = 2;

    UPDATE tblRegistryCleanup
    SET StatusCode = CancelCleanupStatusCode
    WHERE EmailListID = EmailListID
    AND Mailing = Mailing
    AND StartedDatetime IS NULL;

    EXECUTE spLogRunTimeFinishProcedure(LogID);
END;