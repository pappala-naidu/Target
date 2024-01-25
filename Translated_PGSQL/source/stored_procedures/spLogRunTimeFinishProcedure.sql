CREATE PROCEDURE spLogRunTimeFinishProcedure(LogID INT)
BEGIN
    -- LOG FINISH
    UPDATE tblLogRunTime
    SET FinishedDatetime = CURRENT_TIMESTAMP
    WHERE LogID = LogID;

    DECLARE ProcedureName NVARCHAR(128);
    DECLARE ProcedureStart DATETIME;
    DECLARE ProcedureEnd DATETIME;

    SELECT ProcedureName = p.Name, ProcedureStart = r.StartedDatetime, ProcedureEnd = r.FinishedDatetime
    FROM tblLogRunTime AS r WITH (NOLOCK)
    JOIN tblplProcedures AS p WITH (NOLOCK) ON r.ProcedureID = p.ProcedureID
    WHERE LogID = LogID;

    PRINT 'Finished ' || ProcedureName;
END;