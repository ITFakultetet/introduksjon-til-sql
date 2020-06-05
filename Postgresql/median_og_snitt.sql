/*
Finn median og snittlønn per stillingskategori
*/

SELECT title, percentile_disc(0.5) WITHIN GROUP (ORDER BY salary) AS median, 
round(avg(salary)) AS snitt
FROM titles t INNER JOIN salaries s ON t.emp_no=s.emp_no
WHERE t.to_date = '9999-01-01' AND s.to_date='9999-01-01' 
GROUP BY title ORDER BY title;

/*
Resultat

      title        | median | snitt 
--------------------+--------+-------
 Assistant Engineer |  54775 | 57318
 Engineer           |  57050 | 59603
 Manager            |  74510 | 77724
 Senior Engineer    |  69498 | 70823
 Senior Staff       |  78674 | 80706
 Staff              |  65114 | 67331
 Technique Leader   |  66381 | 67507

*/