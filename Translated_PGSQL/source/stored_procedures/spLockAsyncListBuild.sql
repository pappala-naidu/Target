CREATE PROCEDURE spLockAsyncListBuild (
    _EmailListID INT,
    _ProcedureName NVARCHAR (256),
    _ExternalUniqueID UNIQUEIDENTIFIER = NULL,
    _LockID INT = -1 OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON; -- LOCK TYPES
    DECLARE _LockTypeListBuild INT = 1;
    DECLARE _LockTypeAsyncProcess INT = 2;
    -- IS LOCKED
    DECLARE _IsLockedAsyncProc BIT = 1;
    BEGIN TRANSACTION; -- CHECK LOCKED
    EXECUTE _IsLockedAsyncProc = spIsLocked _EmailListID, _LockTypeAsyncProcess;
    IF _IsLockedAsyncProc = 0 THEN
        -- ASYNC PROCESS LOCK
        EXECUTE _LockID = spLock _EmailListID, _LockTypeListBuild, 'spAsyncListBuild', _ExternalUniqueID;
    END;
    COMMIT;
    RETURN _LockID;
END;