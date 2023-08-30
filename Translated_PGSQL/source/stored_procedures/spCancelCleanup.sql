CREATE PROCEDURE sp_cancel_cleanup(
  email_list_id INT,
  mailing INT,
  external_unique_id UNIQUEIDENTIFIER)
AS
BEGIN
  SET
    NOCOUNT ON;

  DECLARE log_id INT;

  DECLARE log_procedure_cleanup INT;

  EXEC sp_log_run_time_start_procedure(
    log_procedure_cleanup,
    email_list_id,
    mailing,
    external_unique_id,
    log_id OUTPUT);

  DECLARE cancel_cleanup_status_code INT;

  UPDATE
    tbl_registry_cleanup
  SET
    status_code = cancel_cleanup_status_code
  WHERE
    email_list_id = email_list_id
    AND mailing = mailing
    AND started_datetime IS NULL;

  EXEC sp_log_run_time_finish_procedure(log_id);

END;