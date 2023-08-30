CREATE PROCEDURE sp_log_run_time_finish_procedure(
  _log_id int
) AS
BEGIN
  SET
    NOCOUNT ON; -- LOG FINISH

  UPDATE
    tbl_log_run_time
  SET
    FinishedDatetime = CURRENT_TIMESTAMP
  WHERE
    LogID = _log_id;

  DECLARE
    _procedure_name nvarchar(128);

  DECLARE
    _procedure_start datetime;

  DECLARE
    _procedure_end datetime;

  SELECT
    _procedure_name = p.name,
    _procedure_start = r.started_datetime,
    _procedure_end = r.finished_datetime
  FROM
    tbl_log_run_time AS r
      JOIN tbl_pl_procedures AS p ON r.procedure_id = p.procedure_id
  WHERE
    LogID = _log_id;

  PRINT 'Finished ' + _procedure_name;

END;