SELECT first_name, last_name, dept_name, salary, 
rank() OVER (PARTITION BY dept_name ORDER BY salary desc) AS num 
FROM employees e  
INNER JOIN dept_emp de ON e.emp_no = de.emp_no  
INNER JOIN departments d ON d.dept_no = de.dept_no  
INNER JOIN salaries s ON s.emp_no = de.emp_no  
WHERE extract(year from s.to_date) = 9999  AND extract(year from de.to_date) = 9999 
AND salary > 140000 ORDER BY dept_name, num;