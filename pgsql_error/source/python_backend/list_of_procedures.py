 
def get_all_procs():
    procs_list = [' fnIsTestActive', ' fnEmailListUsesFeature', ' fnGetCustomerAttributeBannerContentBlockIdentifier', ' fnGetMailingLibraComponents']
    return procs_list


get_all_procs()

In SQLServer to PostgreSQL conversion, convert 'ATN2' function to 'ATAN2' function.
In SQLServer to PostgreSQL conversion, convert 'UNICODE' function to 'ASCII' function.
In SQLServer to PostgreSQL conversion Do not use '  ' .
In SQLServer to PostgreSQL conversion, convert 'CHAR' function to 'CHR' function.
In SQLServer to PostgreSQL conversion, convert 'TOP' keyword to 'LIMIT' keyword.
In SQLServer to PostgreSQL conversion, convert 'CHARINDEX' function to 'POSITION' function .
In SQLServer to PostgreSQL conversion, convert '[database].[schema].[table]' formate of SQLServer to 'database.schema.table' formte of PostgreSQL.
In SQLServer to PostgreSQL conversion, use the same column names for PostgreSQL do not Replace it with anything.
In SQLServer to PostgreSQL conversion, convert 'LEN' function to 'LENGTH' function.
In SQLServer to PostgreSQL conversion, convert 'RAND' function to 'RANDOM' function.
In SQLServer to PostgreSQL conversion, convert 'TRANSLATE' function to 'TRANSLATE' function only.
In SQLServer to PostgreSQL conversion, convert 'NEXT VALUE FOR' to 'nextval()'.
In SQLServer to PostgreSQL conversion, convert 'MONTH()' function to 'EXTRACT(MONTH FROM TIMESTAMP value)'.
In SQLServer to PostgreSQL conversion, convert 'YEAR()' function to 'EXTRACT(YEAR FROM TIMESTAMP value)'.
In SQLServer to PostgreSQL conversion, convert 'DAY()' function to 'EXTRACT(DAY from TIMESTAMP value)'.
In SQLServer to PostgreSQL conversion, do not use 'EXTRACT()' if not required.
In SQLServer to PostgreSQL conversion, convert 'CREATE TABLE #NAME' to 'CREATE TEMP NAME'.
In PostgreSQL, the `_` character cannot be used in parameters and variables.
In SQLServer to PostgreSQL conversion, Do not use EXEC in PostgreSQL use CALL statement.
Insert $procedure$ in between AS and BEGIN.
Always use `plpgsql` LANGUAGE.
