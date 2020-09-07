/*
Finn median og snittlønn per stillingskategori
*/

SELECT distinct title, percentile_disc(0.5) WITHIN GROUP (ORDER BY salary) OVER (PARTITION BY title) AS median
FROM titles t INNER JOIN salaries s ON t.emp_no=s.emp_no
WHERE year(t.to_date) = 9999 AND year(s.to_date) = 9999
ORDER BY title;

/*
Resultat

      title         | median | 
--------------------+--------+
 Assistant Engineer |  54775 | 
 Engineer           |  57050 | 
 Manager            |  74510 | 
 Senior Engineer    |  69498 | 
 Senior Staff       |  78674 | 
 Staff              |  65114 | 
 Technique Leader   |  66381 | 

*/