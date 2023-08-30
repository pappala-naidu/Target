ALTER PROCEDURE [dbo].[spLogError] _EmailListID INT = NULL,
  _Mailing INT = NULL,
  _ExternalUniqueID UNIQUEIDENTIFIER = NULL,
  _Comment VARCHAR(256) = NULL,
  _LogID INT = NULL OUTPUT AS BEGIN
SET
  NOCOUNT ON BEGIN TRY EXEC spCreateExternalUniqueID _InputUniqueID = _ExternalUniqueID,
  _OutputUniqueID = _ExternalUniqueID OUTPUT;

DECLARE _ProcedureID INT = NULL;

SELECT
  TOP (1) _ProcedureID = ProcedureID
FROM
  tblplProcedures WITH (NOLOCK)
WHERE
  Name = ERROR_PROCEDURE();

PRINT FORMATMESSAGE(
  '%s - %s',
  CONVERT(VARCHAR(100), GETDATE(), 21),
  ERROR_MESSAGE()
);

PRINT FORMATMESSAGE(
  '    in %s at line %d. Error # %d, state %d, severity %d.',
  ERROR_PROCEDURE(),
  ERROR_LINE(),
  ERROR_NUMBER(),
  ERROR_STATE(),
  ERROR_SEVERITY()
);

END TRY BEGIN CATCH
END CATCH;

INSERT INTO
  tblLogError(
    ErrorDateTime,
    Message,
    ProcedureName,
    Line,
    ErrorNumber,
    Severity,
    State,
    EmailListID,
    Mailing,
    ExternalUniqueID,
    ProcedureID,
    Comment
  )
VALUES
  (
    CURRENT_TIMESTAMP,
    ERROR_MESSAGE(),
    ERROR_PROCEDURE(),
    ERROR_LINE(),
    ERROR_NUMBER(),
    ERROR_SEVERITY(),
    ERROR_STATE(),
    _EmailListID,
    _Mailing,
    _ExternalUniqueID,
    _ProcedureID,
    _Comment
  );

SELECT
  _LogID = SCOPE_IDENTITY();