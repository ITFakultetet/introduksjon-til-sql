-- Ikke-rekursiv CTE

WITH topplønnede as
-- Finn de 10 ansatte med høyest lønn idag
(SELECT top 10 e.emp_no, concat(first_name , ' ' ,last_name) as ansatt, salary as lønn 
from employees e inner JOIN salaries s on e.emp_no = s.emp_no
where year(to_date) = 9999
order by salary desc),
bonustabell as
-- beregn 16% bonus
(SELECT emp_no, (salary*16/100) as bonus from salaries where year(to_date)=9999)
-- sett tabellene sammen til ett resultat
select ansatt, lønn, bonus from topplønnede t inner join bonustabell b on t.emp_no = b.emp_no;
