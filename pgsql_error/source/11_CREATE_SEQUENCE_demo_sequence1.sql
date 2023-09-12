CREATE SEQUENCE demo_sequence1
INCREMENT BY -1
START WITH 100
MAXVALUE 100
MINVALUE 95
CYCLE
CACHE 2
ORDER;

-- SEQUENCE queries conversion rules

-- Comment lines with keywords 'NOCACHE', 'ORDER' and 'NOORDER' using ('--').

-- Replace 'NOMAXVALUE' 'NOMINVALUE' and 'NOCYCLE' keywords with 'NO MAXVALUE', 'NO MINVALUE' and 'NO CYCLE' keywords.

CREATE SEQUENCE demo_sequence1
INCREMENT BY -1
START WITH 100
MAXVALUE 100
MINVALUE 95
CYCLE
CACHE 2
ORDER;

-- SEQUENCE queries conversion rules end