CREATE OR REPLACE PROCEDURE create_table_with_sequence()
OPTIONS(strict_mode=false)
BEGIN

-- Step 1: Create the Sequence
CREATE SEQUENCE seq_example
START WITH 1
INCREMENT BY 1
NO CYCLE;

-- Step 2: Create the Table
CREATE TABLE your_table (
id_column INT64 AS IDENTITY,
);

-- Step 3: Insert Data into the Table using the Sequence
DECLARE
v_id INT64;
BEGIN
-- Insert first row
SELECT NEXT VALUE FOR seq_example INTO v_id;
INSERT INTO your_table (id_column) VALUES (v_id);

-- Insert second row
SELECT NEXT VALUE FOR seq_example INTO v_id;
INSERT INTO your_table (id_column) VALUES (v_id);

-- You can add more INSERT statements for additional rows as needed.
END;
END;