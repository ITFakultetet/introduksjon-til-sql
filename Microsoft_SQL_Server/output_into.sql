-- Øvelse hvor vi oppretter en tabell (ansatte) og setter inn tre rader i den. 
-- Så oppretter vi en tabell til (ansatte2).
-- Ved bruk av nøkkelordene OUTPUT ... INTO sletter vi ansatte med lønn over 
-- 500 000 fra ansatte og setter dem inn i tabellen ansatte2 i én operasjon 


-- Først sletter vi tabellene (hvis de finnes allerede)
drop table if exists ansatte;
drop table if exists ansatte2;
GO

-- Så oppretter vi tabellen ansatte, med 4 felt, id, fornavn, etternavn og lonn (for å unngå å bruke ø)
create table ansatte
(
      id int identity primary key ,
      fornavn text,
      etternavn text,
      lonn int
);
GO

-- Så setter vi inn noen rader i tabellen
insert into ansatte
      (fornavn,etternavn,lonn)
values
      ('Jo', 'Li', 450000),
      ('Lykke', 'Li', 570000),
      ('Hans', 'Jensen', 460000);

-- Vi oppretter tabellen ansatte2 med samme struktur som ansatte, men hvor id-feltet ikke lages av systemet som et løpenummer
CREATE TABLE ansatte2   
(
      id int primary key ,
      fornavn text,
      etternavn text,
      lonn int 	
);


-- Denne setningen sletter ansatte som har lønn over 500 000 fra tabellen ansatte og 
-- setter dem inn i tabellen ansatte2
DELETE FROM ansatte
   output deleted.id, DELETED.fornavn, deleted.etternavn, deleted.lonn into ansatte2
   WHERE
      lonn >= 500000;

-- Så kan vi sjekke innholdet i de to tabellene 
select * from ansatte;
select * from ansatte2;



