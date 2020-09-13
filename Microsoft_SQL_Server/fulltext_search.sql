/*
�velse hvor vi lager en tabell med artikler, etblerer fulltekst-s�k for tabellen og s�ker opp med 
varianter av fullteksts�k-funksjonen contains()
*/

CREATE FULLTEXT CATALOG KursFTCat; 

CREATE TABLE artikler (
id int primary key identity,
tittel nvarchar(100),
artikkel text
);

INSERT INTO artikler (tittel,artikkel) VALUES 
('Enighet i tariffoppgj�ret','Fellesforbundet og NBF er enige om endringene i Biloverenskomsten. Etter konstruktive forhandlinger ble man enige b�de om �konomi og andre bestemmelser.'),
('Elbiler og skadereparasjoner','Nok en gang har ICDP henvendt seg til NBF i forbindelse med en internasjonal studie. Denne gangen er temaet for studien hvordan det europeiske servicemarkedet vil p�virkes av en stadig �kende elbilandel, og NBF har i den forbindelse f�tt en rekke sp�rsm�l knyttet til skadereparasjoner av elbiler. Her kan du lese hva vi har svart.'),
('Tidsfrister for � s�ke ulike tilskudd som f�lge av koronasituasjonen','Det er innf�rt en rekke krisepakker og st�tteordninger for n�ringslivet som f�lge av pandemien. Eksempler p� dette er tilskuddsordning for arbeidsgivere ved avbrutt permittering, ulike l�neordninger og kompensasjon til foretak for tapt omsetning.'),
('Hvordan lever norske kyr?', 'I Norge i dag holdes storfe i b�de l�sdrift og i b�sdrift. I et l�sdriftsfj�s er det liggeb�ser til alle kyr, gangareal foran spiseplassene (grovf�rbrettet), kraftf�rautomater, og en egen plass for melking for melkekyrne. I tillegg er det gjerne plassert ut b�rster slik at kyrne f�r kroppspleie. I b�sfj�s st�r dyra i hver sin b�s p� tett gulv med str� foran f�rbrettet, og en gj�dselrenne med rist bak.');
create unique index ui_noArtikkel on artikler (id);

CREATE FULLTEXT INDEX ON artikler
(artikkel                     -- Full-text indeksens kolonnenavn   
 -- TYPE COLUMN FileExtension    -- Navn p� kolonnen som inneholder informasjon om filtype
  Language 1044                -- 1044 er LCID for Norsk bokm�l
)  
KEY INDEX ui_noArtikkel ON KursFTCat --Unique indeks  
WITH CHANGE_TRACKING AUTO            --Population type;

-- Hvis vi ikke setter CHANGE_TRACKING til AUTO m� vi kj�re denne:
-- ALTER FULLTEXT INDEX ON artikler  START FULL POPULATION;

-- s�k etter alle b�yninger av order henvende
SELECT * FROM artikler
WHERE CONTAINS (artikkel, 'FORMSOF(INFLECTIONAL, "henvende")');

/*
id	tittel	                        artikkel
2	Elbiler og skadereparasjoner	Nok en gang har ICDP henvendt seg til NBF i forbindelse med en internasjonal studie. Denne gangen er temaet for studien hvordan det europeiske servicemarkedet vil p�virkes av en stadig �kende elbilandel, og NBF har i den forbindelse f�tt en rekke sp�rsm�l knyttet til skadereparasjoner av elbiler. Her kan du lese hva vi har svart.
*/

-- sjek om vi finner ordet kompensasjon med 3 ords avstand til ordet tapt
SELECT * FROM artikler
WHERE CONTAINS(artikkel, 'NEAR((kompensasjon, tapt), 4)')
/*
id	tittel	                                                                artikkel
3	Tidsfrister for � s�ke ulike tilskudd som f�lge av koronasituasjonen	Det er innf�rt en rekke krisepakker og st�tteordninger for n�ringslivet som f�lge av pandemien. Eksempler p� dette er tilskuddsordning for arbeidsgivere ved avbrutt permittering, ulike l�neordninger og kompensasjon til foretak for tapt omsetning.
*/  


-- sjekk om vi finner kyr som flertall av ku
SELECT * FROM artikler WHERE
CONTAINS (artikkel, 'FORMSOF(INFLECTIONAL, "ku")');

/*
id   tittel                       artikkel
4    Hvordan lever norske kyr?    I Norge i dag holdes storfe i b�de l�sdrift og i b�sdrift. I et l�sdriftsfj�s er det liggeb�ser til alle kyr, gangareal foran spiseplassene (grovf�rbrettet), kraftf�rautomater, og en egen plass for melking for melkekyrne. I tillegg er det gjerne plassert ut b�rster slik at kyrne f�r kroppspleie. I b�sfj�s st�r dyra i hver sin b�s p� tett gulv med str� foran f�rbrettet, og en gj�dselrenne med rist bak.
*/