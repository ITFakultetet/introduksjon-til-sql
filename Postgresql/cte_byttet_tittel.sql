-- Øvelse: Finn hvor mange ansatte som har byttet tittel minst én gang:

-- Med en underspørring som lister alle som har byttet tittel, dvs. alle som har mer enn én rad i titles-tabellen:
SELECT COUNT(*) as "Byttet tittel" from (select emp_no,  count(*) as antall from titles group by emp_no having count(*)>1) as byttet;

-- Med en CTE (with-setning):
 WITH byttet as (select emp_no, count(*) from titles group by emp_no having count(*)>3) SELECT count(*) as "Byttet tittel" from byttet;