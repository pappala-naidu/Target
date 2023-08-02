CREATE OR REPLACE PROCEDURE my_dataset.REMOVE_TEMP_TABLE(TEMP_TABLE_NAME STRING)
                            BEGIN
                            -- Declare a variable to track the success or failure.
                            DECLARE success INT64 DEFAULT 0;
                            
                            -- Attempt to drop the specified table.
                            BEGIN
                            EXECUTE IMMEDIATE CONCAT('DROP TABLE `your_project.your_dataset.', TEMP_TABLE_NAME, '`');
                            SET success = 1; -- Set success to 1 if the DROP TABLE statement executes successfully.
                            END;
                            
                            -- Check if the table was dropped successfully or not.
                            IF success = 1 THEN
                            -- Do nothing.
                            ELSE
                            -- Raise an error.
                            RAISE 'Failed to drop table: ' || TEMP_TABLE_NAME;
                            END IF;
                            END;