-- Øvelse: tell opp antall menn og kvinner med norske betegnelser for kjønn 
-- med CASE WHEN og med underspørringer

-- med CASE WHEN
SELECT CASE WHEN gender='F' THEN 'Kvinner' 
WHEN gender='M' THEN 'Menn' ELSE 'Kjønn ikke satt' END AS Kjønn,
count(*) AS Antall
FROM employees
GROUP BY gender;

-- med Underspørringer
SELECT (SELECT count(*)
    FROM employees
    WHERE gender='M') AS Menn,
    (SELECT count(*)
    FROM employees
    WHERE gender='F') AS Kvinner
