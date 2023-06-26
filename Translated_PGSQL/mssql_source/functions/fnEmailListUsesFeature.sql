CREATE   FUNCTION public.fn_email_list_uses_feature(
    email_list_id integer,
    feature_name text)
RETURNS TABLE(
    uses_feature integer
)
AS
$$
BEGIN
    RETURN QUERY
    SELECT f.email_list_feature_flag_id AS uses_feature
    FROM public.csn_notif_batch_dbo_tblpl_email_lists l
    CROSS JOIN public.tblpl_email_lists_tblpl_email_list_feature_flags f
    WHERE f.feature_name = feature_name
      AND l.email_list_id = email_list_id;
END;
$$
LANGUAGE plpgsql;