CREATE PROCEDURE sp_lock_async_list_build (
  _email_list_id INT,
  _procedure_name NVARCHAR(256),
  _external_unique_id UNIQUEIDENTIFIER = NULL,
  _lock_id INT = -1 OUTPUT
) AS
BEGIN
  SET
    NOCOUNT ON;

  -- LOCK TYPES
  DECLARE _lock_type_list_build INT = 1;

  DECLARE _lock_type_async_process INT = 2;

  -- IS LOCKED
  DECLARE _is_locked_async_proc BIT = 1;

  BEGIN TRANSACTION;

  -- CHECK LOCKED
  EXEC _is_locked_async_proc = sp_is_locked(_email_list_id,
                                                _lock_type_async_process);

  IF _is_locked_async_proc = 0
  BEGIN
    -- ASYNC PROCESS LOCK
    EXEC _lock_id = sp_lock(_email_list_id,
                             _lock_type_list_build,
                             N'sp_async_list_build',
                             _external_unique_id);
  END;

  COMMIT;

  RETURN _lock_id;

END;