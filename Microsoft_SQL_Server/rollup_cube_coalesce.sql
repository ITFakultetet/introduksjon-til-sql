-- Øvelse: list opp lønnskostnader gruppert etter stilling og kjønn
-- med rolliup og cube

-- med ROLLUP
SELECT 
coalesce(title,'Alle stillinger') as Stilling, coalesce(gender,'Begge kjønn') as Kjønn, sum(cast (salary as bigint)) as Lønnskostnad
from titles t 
inner join salaries s on t.emp_no = s.emp_no
inner join employees e on e.emp_no = t.emp_no
WHERE s.to_date = '01-01-9999' and t.to_date = '01-01-9999'
GROUP BY ROLLUP(title, gender) 
order by title, gender;

-- Med CUBE
SELECT 
coalesce(title,'Alle stillinger') as Stilling, coalesce(gender,'Begge kjønn') as Kjønn, sum(cast (salary as bigint)) as Lønnskostnad
from titles t 
inner join salaries s on t.emp_no = s.emp_no
inner join employees e on e.emp_no = t.emp_no
WHERE s.to_date = '01-01-9999' and t.to_date = '01-01-9999'
GROUP BY CUBE(title, gender) 
order by title, gender;
