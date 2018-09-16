-- Lag en tabell med data for personer
CREATE TABLE personer (id varchar(10) primary key, fornavn varchar(30), etternavn varchar(30), tel varchar(10)) ;

-- Sett inn noen rader i tabellen
INSERT ALL 
INTO personer (id,fornavn,etternavn,tel) values ('1001','Ola','Normann','12345678') 
INTO personer (id,fornavn,etternavn,tel) values ('1002','Kari','Normann','12345678') 
INTO personer (id,fornavn,etternavn,tel) values ('1003','Petter','Normann','87654321') 
INTO personer (id,fornavn,etternavn,tel) values ('1004','Eva','Normann','98765432') 
select 1 from dual;

-- Lag en tabell til på samme format som tabellen <person>
create table personer_ny as select * from personer; 

-- Sett inn en rad i tabellen
insert INTO personer_ny (id,fornavn,etternavn,tel) values ('1005','Krister','Petterson','11223344') ;

-- Endre et felt i raden
update personer_ny set tel='22222222' where id='1002';

-- Sjekk hvordan tabellene ser ut nå 
select * from personer; 
select * from personer_ny; 


-- Bruk MERGE til å flette tabellene sammen
MERGE into personer p USING personer_ny ny
ON (p.id = ny.id)
WHEN MATCHED THEN UPDATE SET p.fornavn = ny.fornavn, p.etternavn = ny.etternavn, p.tel = ny.tel
WHEN NOT MATCHED THEN INSERT (id,fornavn,etternavn,tel)  
VALUES (ny.id, ny.fornavn, ny.etternavn, ny.tel); 

