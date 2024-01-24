CREATE PROCEDURE `spLogRunTimeStartProcedure` (
  _ProcedureID INT64,
  _EmailListID INT64 = NULL,
  _Mailing INT64 = NULL,
  _ExternalUniqueID STRING = NULL
)
AS BEGIN
  DECLARE _ProcedureName STRING;

  SELECT
    _ProcedureName = Name
  FROM
    `tblplProcedures`
  WHERE
    ProcedureID = _ProcedureID;

  PRINT 'Starting ' + _ProcedureName;

  INSERT INTO
    `tblLogRunTime` (
      ProcedureName,
      ProcedureID,
      EmailListID,
      Mailing,
      StartedDatetime,
      FinishedDatetime,
      ExternalUniqueID
    )
  VALUES (
    _ProcedureName,
    _ProcedureID,
    _EmailListID,
    _Mailing,
    CURRENT_TIMESTAMP(),
    NULL,
    _ExternalUniqueID
  );

  SELECT
    _LogID = LAST_INSERT_ID();
END;