CREATE FUNCTION get_all_procs()
RETURNS ARRAY[VARCHAR(128)]
LANGUAGE SQL
AS
$$
SELECT procedure_name
FROM information_schema.routines
WHERE routine_type = 'FUNCTION';
$$;

-- Call the function to get the list of stored procedures.
SELECT * FROM get_all_procs();