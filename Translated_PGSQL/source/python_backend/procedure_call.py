CREATE FUNCTION fnIsTestActive()
RETURNS BOOLEAN
LANGUAGE SQL
AS $$
BEGIN
  -- TODO: Implement the function body.
  RETURN TRUE;
END;
$$;

-- Calling the function
SELECT fnIsTestActive();