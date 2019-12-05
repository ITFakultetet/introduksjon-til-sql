-- Øvelse: bruk CASE WHEN til å regne ut en bonus på 10% 
-- for alle som ble ansatt før 1. januar 1990 og 5% for de som ble ansatt etter 1. januar 1990

select first_name,
       last_name,
       hire_date,
       salary,
       case
           when hire_date < '01-01-1990' then salary*10/100
           else salary*5/100
       end as bonus
from employees e
inner join salaries s on e.emp_no = s.emp_no
where to_date = '01-01-9999'
limit 1000;