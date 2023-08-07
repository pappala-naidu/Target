
SELECT AVG(IF(weight is NULL
     OR height is NULL,
     NULL, height)) as avgy
FROM `regrtbl`;