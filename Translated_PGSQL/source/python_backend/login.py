CREATE FUNCTION login()
RETURNS VARCHAR(255)
LANGUAGE SQL
BEGIN
  RETURN 'Logged in';
END;

-- Call the login function
CALL login();

-- Replace TOP with LIMIT
SELECT * FROM table_name
LIMIT 10;

-- Use CASE statement instead of IIF()
SELECT CASE WHEN condition THEN true_value ELSE false_value END AS result;

-- Use database.schema.table format
SELECT * FROM database.schema.table_name;

-- Use ASCII() instead of UNICODE()
SELECT ASCII('A') AS ascii_value;

-- Use CHR() instead of CHAR()
SELECT CHR(65) AS char_value;

-- Use POSITION instead of CHARINDEX
SELECT POSITION('A' IN 'ABCDEFG') AS position_value;

-- Use || to concatenate strings
SELECT 'A' || 'B' || 'C' AS concatenated_string;

-- Use ATAN2() instead of ATN2()
SELECT ATAN2(y, x) AS angle_value;

-- Use CURRENT_TIMESTAMP instead of GETDATE()
SELECT CURRENT_TIMESTAMP AS current_timestamp;

-- Use EXTRACT(MONTH FROM TIMESTAMP value) instead of MONTH()
SELECT EXTRACT(MONTH FROM TIMESTAMP '2023-03-08 12:34:56') AS month_value;

-- Use EXTRACT(YEAR FROM TIMESTAMP value) instead of YEAR()
SELECT EXTRACT(YEAR FROM TIMESTAMP '2023-03-08 12:34:56') AS year_value;

-- Use EXTRACT(DAY FROM TIMESTAMP value) instead of DAY()
SELECT EXTRACT(DAY FROM TIMESTAMP '2023-03-08 12:34:56') AS day_value;

-- Do not declare variables with _
DECLARE variable VARCHAR(255);

-- Do not use AS $function$ for PostgreSQL, use AS $$
CREATE FUNCTION my_function()
RETURNS VARCHAR(255)
LANGUAGE SQL
AS $$
  RETURN 'Hello, world!';
$$;

-- FUNCTION in PostgreSQL must end with END;$$
CREATE FUNCTION my_function()
RETURNS VARCHAR(255)
LANGUAGE SQL
AS $$
  RETURN 'Hello, world!';
END;$$

-- Do not use # in PostgreSQL in table names
CREATE TABLE table_name (
  id INT NOT NULL,
  name VARCHAR(255) NOT NULL
);

-- Do not use #temptable in PostgreSQL, use only TEMP TABLE
CREATE TEMP TABLE temp_table (
  id INT NOT NULL,
  name VARCHAR(255) NOT NULL
);