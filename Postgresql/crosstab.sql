table studenter;

select * from crosstab (  
  'select distinct
    student,
    fag,
    avg(karakter) as snittkarakter    
  from studenter
  group by
    student,
    fag
  order by student',

  'select distinct fag from studenter order by 1'
 )
 AS (
   Student character varying,
   fag character varying,
   snittkarakter float
 )
 ;