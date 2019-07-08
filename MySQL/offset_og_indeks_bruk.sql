explain SELECT e.emp_no, CONCAT(first_name,' ',last_name) as Name,
cast(e.birth_date as date) birth_date ,salary  from employees e 
INNER JOIN salaries s ON e.emp_no = s.emp_no
WHERE extract(year from s.to_date) = 9999
ORDER BY last_name desc
limit 3709,10