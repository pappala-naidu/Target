ALTER PROCEDURE spLogError(
  EmailListID INT64 = NULL,
  Mailing INT64 = NULL,
  ExternalUniqueID STRING = NULL,
  Comment STRING = NULL,
  OUT LogID INT64
) AS BEGIN
  SET
    NOCOUNT ON;
  BEGIN TRY
    EXECUTE spCreateExternalUniqueID(
      _InputUniqueID = ExternalUniqueID,
      _OutputUniqueID = ExternalUniqueID OUTPUT
    );
    DECLARE ProcedureID INT64;
    SELECT
      ProcedureID = ProcedureID
    FROM
      tblplProcedures WITH (NOLOCK)
    WHERE
      Name = ERROR_PROCEDURE();
    PRINT FORMATMESSAGE(
      '%s - %s',
      CAST(CURRENT_TIMESTAMP AS STRING),
      ERROR_MESSAGE()
    );
    PRINT FORMATMESSAGE(
      '    in %s at line %d. Error # %d, state %d, severity %d.',
      ERROR_PROCEDURE(),
      ERROR_LINE(),
      ERROR_NUMBER(),
      ERROR_STATE(),
      ERROR_SEVERITY()
    );
  END TRY
  BEGIN CATCH
  END CATCH;
  INSERT INTO
    tblLogError(
      ErrorDateTime,
      Message,
      ProcedureName,
      Line,
      ErrorNumber,
      Severity,
      State,
      EmailListID,
      Mailing,
      ExternalUniqueID,
      ProcedureID,
      Comment
    )
  VALUES(
    CURRENT_TIMESTAMP,
    ERROR_MESSAGE(),
    ERROR_PROCEDURE(),
    ERROR_LINE(),
    ERROR_NUMBER(),
    ERROR_SEVERITY(),
    ERROR_STATE(),
    EmailListID,
    Mailing,
    ExternalUniqueID,
    ProcedureID,
    Comment
  );
  SELECT
    LogID = LAST_INSERT_ID();
END;