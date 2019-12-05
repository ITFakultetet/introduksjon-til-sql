-- Øvelse: list opp ansatte med lønn, snittlønn for alle ansatte og avstand til snittlønn
-- med en vindusfunksjon

SELECT TOP 1000 
    first_name,
    last_name,
    hire_date,
    salary,
    round(avg(cast(salary as float)) over (),2) as snitt,
    round(salary- avg(cast(salary as float)) over (),2) as avstand
    FROM employees e
    INNER JOIN salaries s ON e.emp_no = s.emp_no
WHERE to_date = '01-01-9999'
