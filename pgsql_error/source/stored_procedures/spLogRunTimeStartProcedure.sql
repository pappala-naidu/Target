CREATE PROCEDURE [dbo].[spLogRunTimeStartProcedure] (
  _ProcedureID INT,
  _EmailListID INT = NULL,
  _Mailing INT = NULL,
  _ExternalUniqueID UNIQUEIDENTIFIER = NULL,
  _LogID INT OUTPUT
) AS
BEGIN
  SET
    NOCOUNT ON;

  EXEC spCreateExternalUniqueID(
    _InputUniqueID = _ExternalUniqueID,
    _OutputUniqueID = _ExternalUniqueID OUTPUT
  );

  DECLARE _ProcedureName NVARCHAR(256);

  SELECT
    TOP 1 _ProcedureName = Name
  FROM
    tblplProcedures WITH (NOLOCK)
  WHERE
    ProcedureID = _ProcedureID;

  PRINT 'Starting ' + CAST(_ProcedureName AS VARCHAR(128));

  INSERT INTO
    tblLogRunTime (
      ProcedureName,
      ProcedureID,
      EmailListID,
      Mailing,
      StartedDatetime,
      FinishedDatetime,
      ExternalUniqueID
    )
  VALUES
    (
      _ProcedureName,
      _ProcedureID,
      _EmailListID,
      _Mailing,
      CURRENT_TIMESTAMP,
      NULL,
      _ExternalUniqueID
    );

  SELECT
    _LogID = SCOPE_IDENTITY();