CREATE PROCEDURE spCancelCleanup(
  EmailListID INT,
  Mailing INT,
  ExternalUniqueID UNIQUEIDENTIFIER)
AS
BEGIN
  SET
    NOCOUNT ON;

  DECLARE LogID INT;

  DECLARE LogProcedureCleanup INT;

  EXEC spLogRunTimeStartProcedure(
    LogProcedureCleanup,
    EmailListID,
    Mailing,
    ExternalUniqueID,
    LogID OUTPUT);

  DECLARE CancelCleanupStatusCode INT;

  UPDATE
    tblRegistryCleanup
  SET
    StatusCode = CancelCleanupStatusCode
  WHERE
    EmailListID = EmailListID
    AND Mailing = Mailing
    AND StartedDatetime IS NULL;

  EXEC spLogRunTimeFinishProcedure(LogID);

END;

;