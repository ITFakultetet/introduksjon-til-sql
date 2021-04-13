create or replace function insert_user(text,text,text,date,date)
returns void as 
$$ 
insert into employees (emp_no,first_name,last_name,gender,birth_date,hire_date)
values ((select max(emp_no)+1 from employees),$1,$2,$3,$4,$5);
$$

LANGUAGE 'sql';
