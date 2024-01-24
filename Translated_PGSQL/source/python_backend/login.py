CREATE FUNCTION login()
RETURNS VOID
AS $$
BEGIN
  -- Print a message indicating that the user has logged in.
  RAISE NOTICE 'Logged in';
END;
$$
LANGUAGE plpgsql;

-- Call the login function.
SELECT login();