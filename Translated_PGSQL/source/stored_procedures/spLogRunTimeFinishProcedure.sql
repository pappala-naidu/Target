CREATE PROCEDURE spLogRunTimeFinishProcedure(LogID INT)
AS
BEGIN
    -- LOG FINISH
    UPDATE tblLogRunTime
    SET FinishedDatetime = CURRENT_TIMESTAMP
    WHERE LogID = LogID;

    DECLARE ProcedureName VARCHAR(128);
    DECLARE ProcedureStart TIMESTAMP;
    DECLARE ProcedureEnd TIMESTAMP;

    SELECT
        ProcedureName = p.Name,
        ProcedureStart = r.StartedDatetime,
        ProcedureEnd = r.FinishedDatetime
    FROM
        tblLogRunTime AS r
    JOIN tblplProcedures AS p ON r.ProcedureID = p.ProcedureID
    WHERE LogID = LogID;

    RAISE NOTICE 'Finished %', ProcedureName;
END;