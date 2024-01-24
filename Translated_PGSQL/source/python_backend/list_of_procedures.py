CREATE FUNCTION get_all_procs()
RETURNS text[]
LANGUAGE sql
AS $$
SELECT procedure_name
FROM information_schema.routines
WHERE routine_type = 'PROCEDURE';
$$;

-- Call the function to get the list of stored procedures.
SELECT * FROM get_all_procs();