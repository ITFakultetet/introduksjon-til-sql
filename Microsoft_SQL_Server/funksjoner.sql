-- Lag en funksjon "navn" som slår sammen fornavn og etternavn med et mellomrom mellom, 
-- og samtidig sørger for at både fornmavn og etternavn skrives med stor forbokstav

create or alter function navn(@fornavn nvarchar(100),@etternavn nvarchar(100) )
returns varchar(100)
AS 
BEGIN
-- her er sql-en som bruker de innebygde funksjonene concat(), upper(), len(), left() og right() 
return concat(left(upper(@fornavn),1),right(@fornavn,len(@fornavn)-1),' ',left(upper(@etternavn),1),right(@etternavn,len(@etternavn)-1))
END;
GO

-- Sjekk at funksjonen virker
use hr;
go
select top 10 dbo.navn(first_name,last_name) as navn from employees;

