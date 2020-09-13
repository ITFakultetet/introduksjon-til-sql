/*
Øvelse hvor vi lager en tabell med artikler, etblerer fulltekst-søk for tabellen og søker opp med 
varianter av fulltekstsøk-funksjonen contains()
*/

CREATE FULLTEXT CATALOG KursFTCat; 

CREATE TABLE artikler (
id int primary key identity,
tittel nvarchar(100),
artikkel text
);

INSERT INTO artikler (tittel,artikkel) VALUES 
('Enighet i tariffoppgjøret','Fellesforbundet og NBF er enige om endringene i Biloverenskomsten. Etter konstruktive forhandlinger ble man enige både om økonomi og andre bestemmelser.'),
('Elbiler og skadereparasjoner','Nok en gang har ICDP henvendt seg til NBF i forbindelse med en internasjonal studie. Denne gangen er temaet for studien hvordan det europeiske servicemarkedet vil påvirkes av en stadig økende elbilandel, og NBF har i den forbindelse fått en rekke spørsmål knyttet til skadereparasjoner av elbiler. Her kan du lese hva vi har svart.'),
('Tidsfrister for å søke ulike tilskudd som følge av koronasituasjonen','Det er innført en rekke krisepakker og støtteordninger for næringslivet som følge av pandemien. Eksempler på dette er tilskuddsordning for arbeidsgivere ved avbrutt permittering, ulike låneordninger og kompensasjon til foretak for tapt omsetning.'),
('Hvordan lever norske kyr?', 'I Norge i dag holdes storfe i både løsdrift og i båsdrift. I et løsdriftsfjøs er det liggebåser til alle kyr, gangareal foran spiseplassene (grovfôrbrettet), kraftfôrautomater, og en egen plass for melking for melkekyrne. I tillegg er det gjerne plassert ut børster slik at kyrne får kroppspleie. I båsfjøs står dyra i hver sin bås på tett gulv med strø foran fôrbrettet, og en gjødselrenne med rist bak.');
create unique index ui_noArtikkel on artikler (id);

CREATE FULLTEXT INDEX ON artikler
(artikkel                     -- Full-text indeksens kolonnenavn   
 -- TYPE COLUMN FileExtension    -- Navn på kolonnen som inneholder informasjon om filtype
  Language 1044                -- 1044 er LCID for Norsk bokmål
)  
KEY INDEX ui_noArtikkel ON KursFTCat --Unique indeks  
WITH CHANGE_TRACKING AUTO            --Population type;

-- Hvis vi ikke setter CHANGE_TRACKING til AUTO må vi kjøre denne:
-- ALTER FULLTEXT INDEX ON artikler  START FULL POPULATION;

-- søk etter alle bøyninger av order henvende
SELECT * FROM artikler
WHERE CONTAINS (artikkel, 'FORMSOF(INFLECTIONAL, "henvende")');

/*
id	tittel	                        artikkel
2	Elbiler og skadereparasjoner	Nok en gang har ICDP henvendt seg til NBF i forbindelse med en internasjonal studie. Denne gangen er temaet for studien hvordan det europeiske servicemarkedet vil påvirkes av en stadig økende elbilandel, og NBF har i den forbindelse fått en rekke spørsmål knyttet til skadereparasjoner av elbiler. Her kan du lese hva vi har svart.
*/

-- sjek om vi finner ordet kompensasjon med 3 ords avstand til ordet tapt
SELECT * FROM artikler
WHERE CONTAINS(artikkel, 'NEAR((kompensasjon, tapt), 4)')
/*
id	tittel	                                                                artikkel
3	Tidsfrister for å søke ulike tilskudd som følge av koronasituasjonen	Det er innført en rekke krisepakker og støtteordninger for næringslivet som følge av pandemien. Eksempler på dette er tilskuddsordning for arbeidsgivere ved avbrutt permittering, ulike låneordninger og kompensasjon til foretak for tapt omsetning.
*/  


-- sjekk om vi finner kyr som flertall av ku
SELECT * FROM artikler WHERE
CONTAINS (artikkel, 'FORMSOF(INFLECTIONAL, "ku")');

/*
id   tittel                       artikkel
4    Hvordan lever norske kyr?    I Norge i dag holdes storfe i både løsdrift og i båsdrift. I et løsdriftsfjøs er det liggebåser til alle kyr, gangareal foran spiseplassene (grovfôrbrettet), kraftfôrautomater, og en egen plass for melking for melkekyrne. I tillegg er det gjerne plassert ut børster slik at kyrne får kroppspleie. I båsfjøs står dyra i hver sin bås på tett gulv med strø foran fôrbrettet, og en gjødselrenne med rist bak.
*/