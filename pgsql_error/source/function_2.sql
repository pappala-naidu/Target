CREATE OR REPLACE FUNCTION fibonacci_function(n INT64)
RETURNS INT64
LANGUAGE js AS
"""
BEGIN_PROC
DECLARE
result INT64;
BEGIN
IF n < 0 THEN
RAISE EXCEPTION 'The input must be a non-negative integer.';
ELSIF n = 0 THEN
result := 0;
ELSIF n = 1 THEN
result := 1;
ELSE
result := fibonacci_function(n - 1) + fibonacci_function(n - 2);
END IF;
RETURN result;
END;
END_PROC""";