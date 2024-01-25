CREATE PROCEDURE spLogRunTimeStartProcedure (
    ProcedureID INT,
    EmailListID INT = NULL,
    Mailing INT = NULL,
    ExternalUniqueID UNIQUEIDENTIFIER = NULL
)
BEGIN
    SET NOCOUNT ON;
    CALL spCreateExternalUniqueID (
        _InputUniqueID = _ExternalUniqueID,
        _OutputUniqueID = _ExternalUniqueID OUTPUT
    );

    DECLARE ProcedureName NVARCHAR(256);

    SELECT
        TOP 1 ProcedureName = Name
    FROM
        tblplProcedures 
    WHERE
        ProcedureID = _ProcedureID;

    PRINT 'Starting ' + CAST(ProcedureName AS VARCHAR(128));

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
    VALUES (
        ProcedureName,
        ProcedureID,
        EmailListID,
        Mailing,
        CURRENT_TIMESTAMP,
        NULL,
        _ExternalUniqueID
    );

    SELECT
        _LogID = LAST_INSERT_ID();
END;