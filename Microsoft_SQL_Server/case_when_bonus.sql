-- Øvelse: bruk CASE WHEN til å regne ut en bonus på 10% 
-- for alle som ble ansatt før 1. januar 1990 og 5% for de som ble ansatt etter 1. januar 1990

SELECT TOP 1000
    first_name,
    last_name,
    hire_date,
    salary,
    CASE
       WHEN hire_date < '01-01-1990' THEN salary*10/100
       ELSE salary*5/100
    END AS bonus
FROM employees e
    INNER JOIN salaries s ON e.emp_no = s.emp_no
WHERE to_date = '01-01-9999'
