CREATE OR REPLACE PROCEDURE my_dataset.TRUNCATE_TABLE(TABLE_NAME STRING)
                            RETURNS  STRING
                            LANGUAGE js
                            OPTIONS(strict_mode=false)
                            BEGIN
                            -- Declare a variable to track the success or failure.
                            DECLARE success INT64 DEFAULT 0;
                            
                            -- Attempt to truncate the specified table.
                            BEGIN
                            EXECUTE IMMEDIATE CONCAT('TRUNCATE TABLE `your_project.your_dataset.', TABLE_NAME, '`');
                            SET success = 1; -- Set success to 1 if the TRUNCATE TABLE statement executes successfully.
                            END;
                            
                            -- Check if the table was truncated successfully or not.
                            IF success = 1 THEN
                            RETURN 'Table truncated';
                            ELSE
                            RETURN CONCAT('Failed to truncate table: ', TABLE_NAME);
                            END IF;
                            END;