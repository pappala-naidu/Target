CREATE OR REPLACE PROCEDURE public.spsetcustomerattributebanne(integer, integer, integer, integer, character varying, character varying, character varying, character varying, boolean, character varying)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
	_now TIMESTAMP WITH TIME ZONE := CAST(GETDATE() AS TIMESTAMP WITH TIME ZONE);
BEGIN
	IF _isactive = false THEN
		UPDATE
			tblrulescustomerattributebanner
		SET
			isactive = _isactive,
			lastupdatedby = _username,
			datetimechanged = _now
		WHERE
			storeid = _storeid
			AND customerattributetypeid = _customerattributetypeid
			AND customerattribute = _customerattribute
			AND daynumber = _daynumber;
	ELSE
		IF NOT EXISTS (
			SELECT
				1
			FROM
				vwlatestcustomerattributebannerbundlecontent
			WHERE
				storeid = _storeid
				AND customerattributetypeid = _customerattributetypeid
				AND customerattribute = _customerattribute
				AND daynumber = _daynumber
				AND launchurl = _launchurl
				AND imageurl = _imageurl -- Perform a case-sensitive comparison
				AND CONVERT(VARBINARY(256), LTRIM(RTRIM(alttext))) = CONVERT(VARBINARY(256), LTRIM(RTRIM(_alttext)))
		) THEN
			INSERT INTO
				tblcustomerattributebannerbundlecontent (
					storeid,
					customerattributetypeid,
					customerattribute,
					daynumber,
					launchurl,
					imageurl,
					alttext,
					username,
					datetimestarted,
					subjectline
				)
			VALUES (
				_storeid,
				_customerattributetypeid,
				_customerattribute,
				_daynumber,
				_launchurl,
				_imageurl,
				_alttext,
				_username,
				_now,
				_subjectline
			);
		END IF;
		DECLARE
			_contentblockidentifier VARCHAR(256);
		BEGIN
			SELECT
				contentblockidentifier
			INTO
				_contentblockidentifier
			FROM
				fnGetCustomerAttributeBannerContentBlockIdentifier(
					_storeid,
					_customerattributetypeid,
					_customerattribute,
					_daynumber
				);
			UPDATE
				tblrulescustomerattributebanner
			SET
				contentblock = _contentblockidentifier,
				subjectline = _subjectline,
				isactive = _isactive,
				lastupdatedby = _username,
				datetimechanged = _now
			WHERE
				storeid = _storeid
				AND customerattributetypeid = _customerattributetypeid
				AND customerattribute = _customerattribute
				AND daynumber = _daynumber;
		END;
	END IF;
END;
$procedure$
;