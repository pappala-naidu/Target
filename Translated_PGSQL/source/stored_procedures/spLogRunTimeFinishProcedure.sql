CREATE PROCEDURE [dbo].[spLogRunTimeFinishProcedure] (
  _LogID INT
) AS
BEGIN
  SET
    NOCOUNT ON; -- LOG FINISH

  UPDATE
    tblLogRunTime
  SET
    FinishedDatetime = CURRENT_TIMESTAMP
  WHERE
    LogID = _LogID;

  DECLARE
    _ProcedureName NVARCHAR(128);

  DECLARE
    _ProcedureStart DATETIME;

  DECLARE
    _ProcedureEnd DATETIME;

  SELECT
    _ProcedureName = p.Name,
    _ProcedureStart = r.StartedDatetime,
    _ProcedureEnd = r.FinishedDatetime
  FROM
    dbo.tblLogRunTime AS r WITH (NOLOCK)
    JOIN dbo.tblplProcedures AS p WITH (NOLOCK) ON r.ProcedureID = p.ProcedureID
  WHERE
    LogID = _LogID;

  PRINT 'Finished ' + _ProcedureName;