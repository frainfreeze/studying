-- -- -- -- -- -- -- -- PREDAVANJE 1
-- 1. Dohvatiti sve kupce iz tablice Kupac koji se zovu Ana ili Tamara i iz Osijeka su.
SELECT * FROM Kupac WHERE Ime IN ('Ana', 'Tamara') AND GradID = 2
-- ili 
SELECT * FROM Kupac WHERE (Ime = 'Ana' OR Ime = 'Tamara') AND GradID = 2

-- 2. Umetnite proizvod "Sony Player" cijene 985,50 kuna. 
-- Potkategorija je "Playeri", kategorija "Razno". Podatke koji nisu zadani izmislite.
INSERT INTO Kategorija (Naziv) VALUES ('Razno') 

-- Ume�e kategoriju s ID-em 9 (kod vas mo�e biti druk�ije).
INSERT INTO Potkategorija (KategorijaID, Naziv) VALUES (9, 'Playeri') 

-- Ume�e potkategoriju s ID-em 38 (kod vas mo�e biti druk�ije).
INSERT INTO Proizvod (Naziv, BrojProizvoda, Boja, MinimalnaKolicinaNaSkladistu, CijenaBezPDV, PotkategorijaID) 
VALUES ('Sony Player', 'XX-0001', 'Trula vi�nja', 20, 985.50, 38)

-- 3. Napravite tablicu KupacVIP sa stupcima ime i prezime. Umetnite u nju sve kupce koji se zove Karen, Mary ili Jimmy.
CREATE TABLE KupacVIP
(
	IDKupacVIP int CONSTRAINT PK_KupacVIP PRIMARY KEY IDENTITY,
	Ime nvarchar(50) NOT NULL,
	Prezime nvarchar(50) NOT NULL
)

INSERT INTO KupacVIP (Ime, Prezime)
SELECT Ime, Prezime FROM Kupac WHERE Ime IN ('Karen', 'Mary', 'Jimmy')

SELECT * FROM KupacVIP

DROP TABLE KupacVIP

-- 4. Kupcima s ID-evima 40, 41 i 42 promijenite e-mail u nepoznato@nepoznato.com
UPDATE Kupac
SET Email = 'nepoznato@nepoznato.com'
WHERE IDKupac IN (40, 41, 42)

SELECT * FROM Kupac WHERE IDKupac IN (40, 41, 42)

-- 5. Obri�ite sve kupce koji se prezivaju Trtimirovi�. Je li se dogodila pogre�ka? Koliko ih je obrisano?
DELETE FROM Kupac WHERE Prezime = 'Trtimirovi�'

-- 6. Dohvatiti imena i prezimena svih kupaca i uz svakog ispisati naziv grada i dr�ave.
SELECT 
	k.Ime,
	k.Prezime,
	g.Naziv AS NazivGrada,
	d.Naziv AS NazivDrzave
FROM Kupac AS k
INNER JOIN Grad AS g ON k.GradID = g.IDGrad
INNER JOIN Drzava AS d ON g.DrzavaID = d.IDDrzava

-- 7. Ispisati nazive proizvoda koji su na nekoj stavci ra�una prodani u vi�e od 35 komada. Svaki proizvod navesti samo jednom.
SELECT DISTINCT
	p.Naziv
FROM Stavka AS s
INNER JOIN Proizvod AS p ON s.ProizvodID = p.IDProizvod
WHERE s.Kolicina > 35

-- 8. Koriste�i lijevo vanjsko spajanje dohvatiti sve proizvode koji nisu nikad prodani.
SELECT *
FROM Proizvod AS p
LEFT OUTER JOIN Stavka AS s ON s.ProizvodID = p.IDProizvod
WHERE s.ProizvodID IS NULL

-- 9. Koriste�i puno vanjsko spajanje ispisati nazive dr�ava i nazive gradova. 
-- Ispisati samo one gradove koji nemaju definiranu dr�avu i one dr�ave koji 
-- nemaju upisanih gradova.
SELECT 
	g.Naziv AS NazivGrada,
	d.Naziv AS NazivDrzave
FROM Grad AS g
FULL OUTER JOIN Drzava AS d ON g.DrzavaID = d.IDDrzava
WHERE g.IDGrad IS NULL OR d.IDDrzava IS NULL

-- 10. Vratite nazive svih proizvoda i uz svaki ispi�ite boju ako je definirana, 
-- odnosno "NIJE DEFINIRANA" ako nije.
SELECT 
	Naziv,
	ISNULL(Boja, 'NIJE DEFINIRANA') AS Boja
FROM Proizvod

-- 11. Vratite prosje�nu cijenu proizvoda iz potkategorije 16.
SELECT AVG(CijenaBezPdv)
FROM Proizvod
WHERE PotkategorijaID = 16

-- 12. Vratite datume najstarijeg i najnovijeg ra�una izdanog kupcu 131.
SELECT 
	MIN(DatumIzdavanja) AS NajstarijiRacun,
	MAX(DatumIzdavanja) AS NajnovijiRacun
FROM Racun
WHERE KupacID = 131

-- 13. Grupiranjem ispi�ite sve boje proizvoda i pokraj svake napi�ite koliko proizvoda ima tu boju.
SELECT 
	Boja,
	COUNT(*) AS BrojPoizvodaKojiImaTuBoju
FROM Proizvod
GROUP BY Boja

-- 14. Grupiranjem ispi�ite koliko je ra�una izdano koje godine.
SELECT 
	YEAR(DatumIzdavanja) AS GodinaIzdavanja,
	COUNT(*) AS IzdanoTeGodine
FROM Racun
GROUP BY YEAR(DatumIzdavanja)

-- 15. Grupiranjem ispi�ite ukupno zara�ene iznose za svaki od proizvoda koji je prodan u vi�e od 2000 primjeraka.
SELECT 
	p.Naziv,
	SUM(s.UkupnaCijena) AS UkupnoZaradjeno
FROM Stavka AS s
INNER JOIN Proizvod AS p ON s.ProizvodID = p.IDProizvod
GROUP BY p.Naziv
HAVING SUM(s.Kolicina) > 2000

-- 16. Koriste�i podupite, dohvatite imena i prezimena 5 komercijalista koji su izdali najvi�e ra�una.
SELECT TOP 5
    k.Ime, 
    k.Prezime, 
    (SELECT COUNT(r.IDRacun) FROM Racun r WHERE k.IDKomercijalist = r.KomercijalistID) AS UkupnoRacuna 
FROM Komercijalist k
ORDER BY UkupnoRacuna DESC

-- 17. Dohvatite sve boje proizvoda. Uz svaku boju pomo�u podupita dohvatite broj proizvoda u toj boji.
SELECT DISTINCT
	p.Boja,
	(SELECT COUNT(*)
	FROM Proizvod AS p1
	WHERE ISNULL(p1.Boja, 'NEMA') = ISNULL(p.Boja, 'NEMA')) AS BrojProizvodaTeBoje
FROM Proizvod AS p

-- 18. Vratite sve proizvode koji nikad nisu prodani:
-- a)Pomo�u IN ili NOT IN:
SELECT *
FROM Proizvod AS p
WHERE 
	p.IDProizvod NOT IN (SELECT s.ProizvodID FROM Stavka AS s)

-- b) Pomo�u EXISTS ili NOT EXISTS:
SELECT *
FROM Proizvod AS p
WHERE 
	NOT EXISTS(SELECT * FROM Stavka AS s WHERE s.ProizvodID = p.IDProizvod)
	

-- -- -- -- -- -- -- -- PREDAVANJE 2, 3
/* Kod za DEMO (slide 5) */
-- 1. Kreiranje baze.
CREATE DATABASE Predavanje02Demo
GO

USE Predavanje02Demo
GO

-- 2. Kreiranje osnovne tablice i punjenje podacima.
CREATE TABLE Klijent
(
	IDKlijent int CONSTRAINT PK_Klijent PRIMARY KEY IDENTITY, 
	Ime nvarchar(50) NOT NULL, 
	Prezime nvarchar(50) NOT NULL, 
	Tel1 nvarchar(50) NULL, 
	Tel2 nvarchar(50) NULL, 
	Tel3 nvarchar(50) NULL
)

INSERT INTO Klijent (Ime, Prezime, Tel1, Tel2, Tel3) VALUES ('Miro', 'Miri�', '095/111-222', null, null)
INSERT INTO Klijent (Ime, Prezime, Tel1, Tel2, Tel3) VALUES ('Ana', 'Ani�', '091/222-333', '098/999-555', null)
INSERT INTO Klijent (Ime, Prezime, Tel1, Tel2, Tel3) VALUES ('Juro', 'Juri�', '099/999-222', null, null)
GO

-- 3. Normalizacija. Prvo kreiramo dvije nove tablice.
CREATE TABLE KlijentOsoba
(
	IDKlijentOsoba int CONSTRAINT PK_KlijentOsoba PRIMARY KEY IDENTITY, 
	Ime nvarchar(50) NOT NULL, 
	Prezime nvarchar(50) NOT NULL
)

CREATE TABLE KlijentTelefon
(
	IDKlijentTelefon int CONSTRAINT PK_KlijentTelefon PRIMARY KEY IDENTITY, 
	KlijentOsobaID int CONSTRAINT FK_KlijentTelefon_KlijentOsoba FOREIGN KEY REFERENCES KlijentOsoba(IDKlijentOsoba) NOT NULL,
	BrojTelefona nvarchar(50) NOT NULL, 
	Rbr int NOT NULL
)
GO

-- 4. Migriramo podatke (ignoriraju�i potrebnu eksplicitnog umetanja vrijednosti primarnog klju�a).
INSERT INTO KlijentOsoba (Ime, Prezime)
SELECT Ime, Prezime
FROM Klijent

INSERT INTO KlijentTelefon (KlijentOsobaID, BrojTelefona, Rbr)
SELECT IDKlijent, Tel1, 1 AS Rbr FROM Klijent WHERE Tel1 IS NOT NULL

INSERT INTO KlijentTelefon (KlijentOsobaID, BrojTelefona, Rbr)
SELECT IDKlijent, Tel2, 2 AS Rbr FROM Klijent WHERE Tel2 IS NOT NULL

INSERT INTO KlijentTelefon (KlijentOsobaID, BrojTelefona, Rbr)
SELECT IDKlijent, Tel3, 3 AS Rbr FROM Klijent WHERE Tel3 IS NOT NULL
GO

-- 5. Uklanjamo staru tablicu (i time "skr�imo" sve njene korisnike)
DROP TABLE Klijent
GO

-- 6. Izra�ujemo pogled istog naziva.
CREATE VIEW Klijent
AS
SELECT 
	ko.IDKlijentOsoba AS IDKlijent,
	ko.Ime,
	ko.Prezime,
	(SELECT kt.BrojTelefona FROM KlijentTelefon AS kt WHERE kt.KlijentOsobaID = ko.IDKlijentOsoba AND kt.Rbr = 1) AS Tel1,
	(SELECT kt.BrojTelefona FROM KlijentTelefon AS kt WHERE kt.KlijentOsobaID = ko.IDKlijentOsoba AND kt.Rbr = 2) AS Tel2,
	(SELECT kt.BrojTelefona FROM KlijentTelefon AS kt WHERE kt.KlijentOsobaID = ko.IDKlijentOsoba AND kt.Rbr = 3) AS Tel3
FROM KlijentOsoba AS ko
GO

-- Aplikacija sad mo�e i dalje koristiti objekt naziva Klijent (ali samo za dohva�anje podataka)
SELECT * FROM Klijent
GO

USE master
DROP DATABASE Predavanje02Demo
GO

/* Primjeri 1, 2, 3, 4.
1. Situacija: neki korisnik nema pravo koristiti tablicu
   Proizvod, a treba određene podatke. Pomognite mu tako
   što ćete napraviti pogled koji će dohvaćati sve proizvode.
2. Iskoristite pogled za dohvaćanje svih zapisa
a. Iskoristite pogled za dohvaćanje zapisa u potkategoriji 13
b. Iskoristite pogled za ispis boja proizvoda i broja proizvoda u
   svakoj boji, padajuće prema broju proizvoda
c. Iskoristite pogled i pokraj naziva proizvoda ispišite i naziv
   potkategorije
3. Promijenite pogled tako da preimenujete stupac Naziv u
   NazivProizvoda. Dohvatite podatke kroz pogled.
4. Uklonite pogled
*/
CREATE VIEW p1 
AS
SELECT * FROM Proizvod
GO

SELECT * FROM p1 
SELECT * FROM p1 WHERE PotkategorijaID = 13
SELECT Boja, COUNT(*) AS BrojProizvoda FROM p1 GROUP BY Boja ORDER BY BrojProizvoda DESC

SELECT p1.Naziv, pk.Naziv AS PotkategorijaNaziv
FROM p1
INNER JOIN Potkategorija AS pk ON p1.PotkategorijaID = pk.IDPotkategorija
GO

ALTER VIEW p1 
AS
SELECT IDProizvod, Naziv AS NazivProizvoda, BrojProizvoda, Boja, MinimalnaKolicinaNaSkladistu, CijenaBezPDV, PotkategorijaID FROM Proizvod
GO

SELECT * FROM p1 

DROP VIEW p1
GO

/* Primjeri 5, 6.
5. Vašeg šefa (koji voli Management Studio) zanimaju
   podaci: ime i prezime komercijalista i koliko je ukupno
   prodao proizvoda. Rezultate želi sortirane opadajuće
   prema broju prodanih proizvoda.
   a. Objasnite šefu kako da napiše upit
   b. Napravite pogled i objasnite šefu kako da ga koristi
6. Obrišite pogled.
*/
CREATE VIEW p2
AS
SELECT
	k.Ime,
	k.Prezime,
	SUM(s.Kolicina) AS KolicinaProizvoda
FROM Komercijalist AS k
INNER JOIN Racun AS r on k.IDKomercijalist = r.KomercijalistID
INNER JOIN Stavka AS s ON r.IDRacun = s.RacunID
GROUP BY k.Ime, k.Prezime
GO

SELECT * FROM p2 ORDER BY KolicinaProizvoda DESC
GO

DROP VIEW p2
GO

/* Primjeri 7, 8.
7. Gospođa iz prodaje treba pristup podacima o kreditnim
   karticama, ali samo za kartice tipa Diners. Napravite
   pogled. Pomoću pogleda dohvatite sve podatke o
   karticama tipa Diners, a zatim o karticama tipa Visa.
8. Obrišite pogled.
*/
CREATE VIEW p3
AS
SELECT *
FROM KreditnaKartica AS kk
WHERE kk.Tip = 'Diners'
GO

SELECT * FROM p3
SELECT * FROM p3 WHERE Tip = 'Diners'
SELECT * FROM p3 WHERE Tip = 'Visa'
GO

DROP VIEW p3
GO

/* Primjeri 9, 10, 11.
9. Marketing treba podatke o svim proizvodima koji su
   prodani u više od 2000 primjeraka. Napravite pogled koji
   će to omogućiti.
10. Dodajte u pogled informaciju o broj prodanih proizvoda.
11. Uklonite pogled.
*/
CREATE VIEW p4
AS
SELECT *
FROM Proizvod AS p
WHERE (SELECT SUM(Kolicina) FROM Stavka AS s WHERE s.ProizvodID = p.IDProizvod) > 2000
GO

SELECT * FROM p4
GO

ALTER VIEW p4
AS
SELECT 
	*,
	(SELECT SUM(Kolicina) FROM Stavka AS s WHERE s.ProizvodID = p.IDProizvod) AS Prodano
FROM Proizvod AS p
WHERE (SELECT SUM(Kolicina) FROM Stavka AS s WHERE s.ProizvodID = p.IDProizvod) > 2000
GO

SELECT * FROM p4
GO

DROP VIEW p4
GO

-- Primjeri 12. Napravite pogled koji će dohvaćati sve iz tablice Kupac.
-- Možete li napraviti INSERT, UPDATE i DELETE nekog kupca?
CREATE VIEW p5
AS
SELECT * FROM Kupac
GO

SELECT * FROM p5

INSERT INTO p5 (Ime, Prezime, Email, Telefon, GradID) VALUES ('Miro', 'Miri�', NULL, '042/111-222', 9)

UPDATE p5 SET Email = 'miro@miro.com' WHERE IDKupac = 19993

DELETE FROM p5 WHERE IDKupac = 19993
GO

-- Primjeri 13. Promijenite prethodni pogled tako da dohvaća sve stupce osim Prezime. 
-- Možete li napraviti INSERT, UPDATE i DELETE nekog kupca? Obrišite pogled.
ALTER VIEW p5
AS
SELECT IDKupac, Ime, Email, Telefon, GradID FROM Kupac
GO

INSERT INTO p5 (Ime, Email, Telefon, GradID) VALUES ('Janko', NULL, '042/222-333', 8)

UPDATE p5 SET Email = 'ana@ana.com' WHERE IDKupac = 19992

DELETE FROM p5 WHERE IDKupac = 19992
GO

DROP VIEW p5
GO

/* 14. Napravite pogled koji će dohvaćati ime i prezime kupca te
       sve podatke o gradu.
   	a. Možete li napraviti INSERT grada kroz pogled. Vidi li se kroz pogled?
   	b. Možete li napraviti UPDATE ili DELETE grada kroz pogled?
   	c. Obrišite pogled.
*/
CREATE VIEW p6
AS
SELECT 
	k.Ime,
	k.Prezime,
	g.*
FROM Kupac AS k
INNER JOIN Grad AS g ON k.GradID = g.IDGrad
GO

SELECT * FROM p6

INSERT INTO p6 (Naziv, DrzavaID) VALUES ('Velika Gorica', 1)

SELECT * FROM p6
SELECT * FROM Grad

UPDATE p6 SET Naziv = 'Velika Gorica PROMIJENJENO!' WHERE IDGrad = 69

DELETE FROM p6 WHERE IDGrad = 69
GO

DROP VIEW p6
GO

/* Primjeri 15, 16, 17.
15. Napravite pogled koji će dohvaćati sve kupce iz Sarajeva.
	Pomoću tog pogleda umetnite kupca iz Zagreba. Vidi li se
	kupac kroz pogled?
16. Promijenite pogled tako da ne dopušta umetanje/izmjenu
	redaka koji neće biti vidljivi kroz njega. Probajte umetnuti
	novog kupca.
17. Obrišite pogled.
*/
CREATE VIEW p7
AS
SELECT * FROM Kupac WHERE GradID = 9
GO

SELECT * FROM p7

INSERT INTO p7 (Ime, Prezime, Email, Telefon, GradID) VALUES ('Lana', 'Lani�', NULL, NULL, 1)

SELECT * FROM p7
GO

ALTER VIEW p7
AS
SELECT * FROM Kupac WHERE GradID = 9
WITH CHECK OPTION
GO

INSERT INTO p7 (Ime, Prezime, Email, Telefon, GradID) VALUES ('Vana', 'Vani�', NULL, NULL, 1)
GO

DROP VIEW p7
GO

/* Primjeri 18. Napravite tablicu Osoba sa stupcima IDOsoba, Ime, 
	Prezime, OdjelID i Placa i umetnite nekoliko redaka.
	a. Napravite pogled koji dohvaća sve iz tablice
	b. Iskoristite pogled za dohvaćanje podataka
	c. Uklonite stupac OdjelID iz tablice
	d. Možete li iskoristiti pogled za dohvaćanje podataka?
	e. Promijenite definiciju pogleda tako da bude čvrsto vezan uz objekte koje koristi
	f. Uklonite stupac Placa iz tablice
	g. Uklonite pogled
*/
CREATE TABLE Osoba
(
	IDOsoba int CONSTRAINT PK_Osoba PRIMARY KEY IDENTITY,
	Ime nvarchar(50),
	Prezime nvarchar(50),
	OdjelID int,
	Placa money 
)
GO
INSERT INTO Osoba (Ime, Prezime, OdjelID, Placa) VALUES ('Miro', 'Miri�', 1, 5000)
INSERT INTO Osoba (Ime, Prezime, OdjelID, Placa) VALUES ('Ana', 'Ani�', 1, 8500)
INSERT INTO Osoba (Ime, Prezime, OdjelID, Placa) VALUES ('Juro', 'Juri�', 2, 3850)
GO

CREATE VIEW p8
AS
SELECT IDOsoba, Ime, Prezime, OdjelID, Placa FROM Osoba
GO

SELECT * FROM p8
GO

ALTER TABLE Osoba DROP COLUMN OdjelID
GO

SELECT * FROM p8
GO

ALTER VIEW p8 WITH SCHEMABINDING
AS
SELECT IDOsoba, Ime, Prezime, Placa FROM dbo.Osoba
GO

ALTER TABLE Osoba DROP COLUMN Placa
GO

DROP VIEW p8
GO

/* Primjeri 19. Napravite pogled koji dohvaća ime i prezime kupca, te
	naziv države.
	1. Pogledajte SELECT upit pogleda kroz sučelje i pomoću sistemske procedure sp_helptext 
	2. Zaštitite pogled
	3. Pogledajte SELECT upit pogleda kroz sučelje i pomoću sistemske procedure sp_helptext
	4. Promijenite pogled tako da bude zaštićen i čvrsto vezan uz tablice
	5. Promijenite pogled tako da bude zaštićen, čvrsto vezan uz tablice i da ne dopušta izmjene koje neće biti vidljive kroz pogled
	6. Uklonite pogled 
*/
CREATE VIEW p9
AS
SELECT
	k.Ime,
	k.Prezime,
	d.Naziv AS DrzavaNaziv
FROM Kupac AS k
INNER JOIN Grad AS g ON k.GradID = g.IDGrad
INNER JOIN Drzava AS d ON d.IDDrzava = g.DrzavaID
GO

SELECT * FROM p9
GO

EXECUTE sp_helptext p9
GO

ALTER VIEW p9 WITH ENCRYPTION
AS
SELECT
	k.Ime,
	k.Prezime,
	d.Naziv AS DrzavaNaziv
FROM Kupac AS k
INNER JOIN Grad AS g ON k.GradID = g.IDGrad
INNER JOIN Drzava AS d ON d.IDDrzava = g.DrzavaID
GO

SELECT * FROM p9
GO

EXECUTE sp_helptext p9
GO

ALTER VIEW p9 WITH ENCRYPTION, SCHEMABINDING
AS
SELECT
	k.Ime,
	k.Prezime,
	d.Naziv AS DrzavaNaziv
FROM dbo.Kupac AS k
INNER JOIN dbo.Grad AS g ON k.GradID = g.IDGrad
INNER JOIN dbo.Drzava AS d ON d.IDDrzava = g.DrzavaID
GO

ALTER VIEW p9 WITH ENCRYPTION, SCHEMABINDING
AS
SELECT
	k.Ime,
	k.Prezime,
	d.Naziv AS DrzavaNaziv
FROM dbo.Kupac AS k
INNER JOIN dbo.Grad AS g ON k.GradID = g.IDGrad
INNER JOIN dbo.Drzava AS d ON d.IDDrzava = g.DrzavaID
WITH CHECK OPTION
GO

SELECT * FROM p9
GO

DROP VIEW p9
GO


-- 1. Kad je napravljena baza AdventureWorksOBP?
select * from sys.databases
where name='AdventureWorksOBP'
-- 2018-09-14 09:27:07.627


--2. Ispišite sve obavezne stupce koji pripadaju tablici Kupac.
select * from sys.columns
where object_id=789577851
-- IDKupac, Ime, Prezime

select * from sys.tables
where name='kupac'
-- object_id=789577851

select * from sys.columns
where object_id=
(
	select object_id from sys.tables where name='kupac'
)
-- IDKupac, Ime, Prezime


--3. Ispišite naziv stupca koji se najčešće pojavljuje 
-- u bazi AdventureWorksOBP te ispišite i koliko je to puta.
select name, count(*)
from sys.columns
group by name
order by 2 desc
-- 'status'


--4. Ispišite sve primarne i UNIQUE ključeve na tablici Proizvod.
select * from sys.tables
where name='proizvod'
-- Proizvod object_id=757577737

select *
from sys.key_constraints
where parent_object_id=757577737
-- PK_Proizvod


--5. Ispišite nazive svih stranih ključeva u tablici Racun te napišite tablice kamo vode.
select *
from sys.tables
-- Racun object_id=821577965

select *
from sys.foreign_keys as fk
where fk.parent_object_id=821577965
-- FK_Racun_Komercijalist vodi na referenced_object_id=629577281
-- FK_Racun_KreditnaKartica vodi na referenced_object_id=597577167

select * from sys.tables where object_id=629577281
-- Komercijalist

select * from sys.tables where object_id=597577167
-- KreditnaKartica


-- -- -- -- -- -- -- -- PREDAVANJE 4
/*
a. Na koliko stranica su smješteni podaci iz tablice dbo.Proizvod?
b. Koji su redni brojevi tih stranica?
c. Po kojem stupcu su poredani zapisi na stranicama?
d. Pronađite slot na kojem je redak za IDProizvod = 858 (Half-Finger Gloves, S). Koja je boja tog proizvoda?
e. Koji je zadnji redak na prvoj stranici?
f. Koji je prvi redak na drugoj stranici?
g. Umetnite redak u tablicu. Na koju stranicu je dodan i zašto? Pronađite ga.
*/
DBCC TRACEON(3604)
GO

DBCC IND('AdventureWorksOBP', 'Proizvod', -1)
-- a) Podaci iz tablice dbo.Proizvod se smje�teni na 6 stranica (PageType = 1)
-- b) Njihovi redni brojevi su 1836, 1848, 1850, 1851, 1852 i 1853.

DBCC PAGE('AdventureWorksOBP', 1, 1836, 3) WITH TABLERESULTS
-- c) Zapisi na stranicama su poredani po IDProizvod.

DBCC PAGE('AdventureWorksOBP', 1, 1851, 3) WITH TABLERESULTS
-- d) Slot za redak za IDProizvod = 858 (Half-Finger Gloves, S) je 78, boja proizvoda je crna.

DBCC PAGE('AdventureWorksOBP', 1, 1836, 3) WITH TABLERESULTS
-- e) Zadnji redak na prvoj stranici je IDProizvod = 425.

DBCC PAGE('AdventureWorksOBP', 1, 1848, 3) WITH TABLERESULTS
-- f) Prvi redak na drugoj stranici je IDProizvod = 426.

-- g)
INSERT INTO dbo.Proizvod (Naziv, BrojProizvoda, Boja, MinimalnaKolicinaNaSkladistu, CijenaBezPDV, PotkategorijaID)
VALUES ('Testni proizvod 1', 'TP-001', 'ljubi�asta', 0, 5.55, NULL)

DBCC PAGE('AdventureWorksOBP', 1, 1853, 3) WITH TABLERESULTS
-- Dodan je na zadnju stranicu, a to je 1853.


-- -- -- -- -- -- -- -- PREDAVANJE 5
/* Optimiziranje upita
1. Optimizirajte upit: SELECT DatumIzdavanja FROM Racun
    WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'
    a. Koliko stranica je pregledao RDBMS?
    b. Napravite indeks koji optimizira upit
    c. Koliko sad stranica pregled RDBMS?
    d. Uklonite indeks

2. Optimizirajte upit: SELECT IDRacun, DatumIzdavanja
    FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'

3. Optimizirajte upit: SELECT IDRacun, BrojRacuna,
    DatumIzdavanja FROM Racun WHERE DatumIzdavanja
    BETWEEN '20010702' AND '20010702 23:59:59'
    a. Pomaže li nam postojeći indeks? Zašto? Kako ćemo riješiti problem?
    
4. Optimizirajte upit: SELECT r.IDRacun,
    SUM(s.Kolicina) AS Kolicina,
    SUM(s.UkupnaCijena) AS UkupnaCijena
    FROM Racun AS r
    INNER JOIN Stavka AS s ON r.IDRacun = s.RacunID
    WHERE r.DatumIzdavanja BETWEEN '20040126' AND '20040126 23:59:59' AND BrojRacuna LIKE 'SO6275%'
    GROUP BY r.IDRacun
*/

SET STATISTICS IO ON

-- Primjer 1.
SELECT DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'
-- logical reads 202

CREATE NONCLUSTERED INDEX ix1 ON Racun(DatumIzdavanja)

SELECT DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'
-- logical reads 2

DROP INDEX ix1 ON Racun
GO

-- Primjer 2.
SELECT IDRacun, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'
-- logical reads 202

CREATE NONCLUSTERED INDEX ix1 ON Racun(DatumIzdavanja)

SELECT IDRacun, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'
-- logical reads 2

DROP INDEX ix1 ON Racun
GO

-- Primjer 3.
SELECT IDRacun, BrojRacuna, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'
-- logical reads 202

CREATE NONCLUSTERED INDEX ix1 ON Racun(DatumIzdavanja)

SELECT IDRacun, BrojRacuna, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'
-- logical reads 10 - mora iæi na klasterirani indeks (key lookup) jer mu nedostaje vrijednost za BrojRacuna.

DROP INDEX ix1 ON Racun

CREATE NONCLUSTERED INDEX ix1 ON Racun(DatumIzdavanja) INCLUDE (BrojRacuna)

SELECT IDRacun, BrojRacuna, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'
-- logical reads 2 - sad ne mora iæi na klasterirani indeks.

DROP INDEX ix1 ON Racun
GO

-- Primjer 4.
SELECT r.IDRacun, SUM(s.Kolicina) AS Kolicina, SUM(s.UkupnaCijena) AS UkupnaCijena
FROM Racun AS r
INNER JOIN Stavka AS s ON r.IDRacun = s.RacunID
WHERE 
	r.DatumIzdavanja BETWEEN '20040126' AND '20040126 23:59:59' 
	AND BrojRacuna LIKE 'SO6275%'
GROUP BY r.IDRacun
-- Stavka: logical reads 847
-- Racun: logical reads 202

CREATE NONCLUSTERED INDEX ix1 ON Racun(DatumIzdavanja) INCLUDE (BrojRacuna)

CREATE NONCLUSTERED INDEX ix1 ON Stavka(RacunID) INCLUDE (Kolicina, UkupnaCijena)

SELECT r.IDRacun, SUM(s.Kolicina) AS Kolicina, SUM(s.UkupnaCijena) AS UkupnaCijena
FROM Racun AS r
INNER JOIN Stavka AS s ON r.IDRacun = s.RacunID
WHERE 
	r.DatumIzdavanja BETWEEN '20040126' AND '20040126 23:59:59' 
	AND BrojRacuna LIKE 'SO6275%'
GROUP BY r.IDRacun
-- Stavka: logical reads 18
-- Racun: logical reads 3

DROP INDEX ix1 ON Racun
DROP INDEX ix1 ON Stavka
GO

/* primjer korisnosti indeksa */
-- Dropnuti sve neklasterirane indekse s tablice Racun.
CREATE FUNCTION GetNajnoviji
(
	@IDKupac int
)
RETURNS datetime
AS
BEGIN
	DECLARE @Datum datetime

	SELECT TOP 1 @Datum = DatumIzdavanja FROM Racun
	WHERE KupacID = @IDKupac
	ORDER BY DatumIzdavanja DESC
	RETURN @Datum
END
GO

SELECT 
	IDKupac,
	Ime,
	Prezime,
	dbo.GetNajnoviji(IDKupac) AS NajnovijaKupnja
FROM Kupac
GO

CREATE NONCLUSTERED INDEX ix2 ON Racun(KupacID) INCLUDE (DatumIzdavanja)
GO


-- -- -- -- -- -- -- -- PREDAVANJE 6
-- Primjer 1. Deklarirajte varijable @Ime i @Prezime i dodijelite im
-- neke vrijednosti. Prikažite dodijeljene vrijednosti.
DECLARE @Ime nvarchar(50)
DECLARE @Prezime nvarchar(50)

SET @Ime = 'Miro'
SET @Prezime = 'Miri�'

PRINT @Ime
PRINT @Prezime
PRINT 'Korisnik: ' + @Ime + ' ' + @Prezime

SELECT @Ime
SELECT @Prezime
SELECT 'Korisnik: ' + @Ime + ' ' + @Prezime
GO

-- Primjer 2. Deklarirajte varijable @Ime i @Prezime i dodijelite im vrijednosti 
-- iz tablice Kupac za IDKupac jednak 16. Prikažite dodijeljene vrijednosti.
DECLARE @Ime nvarchar(50)
DECLARE @Prezime nvarchar(50)

SELECT @Ime = Ime, @Prezime = Prezime FROM Kupac WHERE IDKupac = 16

SELECT 'Korisnik: ' + @Ime + ' ' + @Prezime
GO

-- Primjer 3. Deklarirajte varijable @Ime i @Prezime i dodijelite im vrijednosti 
-- iz tablice Kupac tako da odaberete sve retke iz tablice. Prikažite dodijeljene vrijednosti.
DECLARE @Ime nvarchar(50)
DECLARE @Prezime nvarchar(50)

SELECT @Ime = Ime, @Prezime = Prezime FROM Kupac

SELECT 'Korisnik: ' + @Ime + ' ' + @Prezime
GO

-- Naredba IF - ELSE IF - ELSE.
DECLARE @Broj float
SET @Broj = RAND()

IF @Broj >= 0 AND @Broj < 0.33 BEGIN
	SELECT 'Prva tre�ina'
END
ELSE IF @Broj >= 0.33 AND @Broj < 0.67 BEGIN
	SELECT 'Druga tre�ina'
END
ELSE BEGIN
	SELECT 'Tre�a tre�ina'
END
GO

-- Primjer 4. Napišite proceduru koja dohvaća sve retke iz tablice
-- Kupac. Pozovite proceduru. Promijenite proceduru tako da vraća rezultate 
-- poredane po imenu pa po prezimenu. Uklonite proceduru.
CREATE PROC dbo.DohvatiSveKupce
AS
SELECT * FROM Kupac
GO

EXEC dbo.DohvatiSveKupce
GO

ALTER PROCEDURE dbo.DohvatiSveKupce
AS
SELECT * FROM Kupac ORDER BY Ime, Prezime
GO

EXEC dbo.DohvatiSveKupce
GO

DROP PROC dbo.DohvatiSveKupce
GO

-- Primjer 5.Napišite proceduru koja dohvaća prvih 10 redaka iz tablice Proizvod, 
-- prvih 5 redaka iz tablice KreditnaKartica i zadnja 3 retka iz tablice Racun. 
-- Pozovite proceduru. Uklonite proceduru.
CREATE PROC p5
AS
SELECT TOP 10 * FROM Proizvod
SELECT TOP 5 * FROM KreditnaKartica
SELECT TOP 3 * FROM Racun ORDER BY IDRacun DESC
GO

EXEC p5
GO

DROP PROC p5
GO

-- Primjer 6. Napišite proceduru koja prima @ID proizvoda i i vraća samo taj proizvod 
-- iz tablice Proizvod. Pozovite proceduru na oba načina. Uklonite proceduru.
CREATE PROC p6
	@AjDiProizvoda int
AS
SELECT * FROM Proizvod WHERE IDProizvod = @AjDiProizvoda
GO

EXEC p6 1
EXEC p6 @AjDiProizvoda = 1
GO

DROP PROC p6
GO

-- Primjer 7. Napišite proceduru koja prima dvije cijene i vraća nazive i
-- cijene svih proizvoda čija cijena je u zadanom rasponu.
-- Pozovite proceduru na oba načina. Uklonite proceduru.
CREATE PROC p7
	@Cijena1 money,
	@Cijena2 money
AS
SELECT Naziv, CijenaBezPDV FROM Proizvod WHERE CijenaBezPDV BETWEEN @Cijena1 AND @Cijena2
GO

EXEC p7 500, 1000
EXEC p7 @Cijena1 = 500, @Cijena2 = 1000
EXEC p7 @Cijena2 = 1000, @Cijena1 = 500 -- Parametri nisu po redu.
GO

DROP PROC p7
GO

-- Primjer 8. Napišite proceduru koja prima četiri parametra potrebna za
-- unos nove kreditne kartice. Neka procedura napravi novi zapis u KreditnaKartica. 
-- Neka procedura prije i nakon umetanja dohvati broj zapisa u tablici. Pozovite 
-- proceduru na oba načina. Uklonite proceduru.
CREATE PROC p8
	@Tip nvarchar(50),
	@Broj nvarchar(25),
	@IstekMjesec tinyint,
	@IstekGodina smallint
AS
-- Dohvacanje prije.
SELECT COUNT(*) AS BrojPrije FROM dbo.KreditnaKartica 

-- Umetanje.
INSERT INTO dbo.KreditnaKartica (Tip, Broj, IstekMjesec, IstekGodina)
VALUES (@Tip, @Broj, @IstekMjesec, @IstekGodina)

-- Dohvacanje nakon.
SELECT COUNT(*) AS BrojNakon FROM dbo.KreditnaKartica 
GO

EXEC p8 'American Express', '12345678901234', 11, 2013
EXEC p8 @Tip = 'Visa', @Broj = '99999999990000', @IstekMjesec = 5, @IstekGodina = 2014
GO

DROP PROC p8
GO

-- Primjer 9. Napišite proceduru koja prima tri boje i za svaku boju vraća
-- proizvode u njoj. Pozovite proceduru i nakon toga je uklonite.
CREATE PROC p9
	@Boja1 nvarchar(15),
	@Boja2 nvarchar(15),
	@Boja3 nvarchar(15)
AS
SELECT * FROM Proizvod WHERE Boja = @Boja1
SELECT * FROM Proizvod WHERE Boja = @Boja2
SELECT * FROM Proizvod WHERE Boja = @Boja3
GO

EXEC p9 'Red', '�uta', 'Black'
GO

DROP PROC p9
GO

-- Primjer 10. Napišite proceduru koja prima parametre @IDProizvod i @Boja. 
-- Parametar @Boja neka bude izlazni parametar. Neka procedura za zadani proizvod 
-- vrati njegovu boju pomoću izlaznog parametra. Pozovite proceduru na oba načina i
-- ispišite vraćenu vrijednost. Uklonite proceduru.
CREATE PROC p10
	@IDProizvod int,
	@Boja nvarchar(15) OUTPUT
AS
SELECT @Boja = Boja FROM Proizvod WHERE IDProizvod = @IDProizvod
GO

DECLARE @Farba nvarchar(15)
EXEC p10 320, @Farba OUTPUT
PRINT @Farba
GO

DECLARE @Farba nvarchar(15)
EXEC p10 @IDProizvod = 320, @Boja = @Farba OUTPUT
PRINT @Farba
GO

DROP PROC p10
GO

-- Primjer 11. Napišite proceduru koja prima kriterij po kojemu ćete filtrirati
-- prezimena iz tablice Kupac. Neka procedura pomoću izlaznog parametra vrati broj 
-- zapisa koji zadovoljavaju zadani kriterij. Neka procedura vrati i sve zapise koji 
-- zadovoljavaju kriterij. Pozovite proceduru i ispišite vraćenu vrijednost. Uklonite proceduru.
CREATE PROC p11
	@Filter nvarchar(50),
	@BrojZapisa int OUTPUT
AS
SELECT @BrojZapisa = COUNT(*) FROM Kupac WHERE Prezime LIKE @Filter

SELECT * FROM Kupac WHERE Prezime LIKE @Filter
GO

DECLARE @Cnt int
EXEC p11 '%abe%', @Cnt OUTPUT
PRINT @Cnt
GO

DROP PROC p11
GO

-- Primjer 12. Napišite proceduru koja za zadanog komercijalistu pomoću izlaznih 
-- parametara vraća njegovo ime i prezime te ukupnu količinu izdanih računa.
CREATE PROC p12
	@KomercijalistID int,
	@Ime nvarchar(50) OUTPUT,
	@Prezime nvarchar(50) OUTPUT,
	@IzdaoRacuna int OUTPUT
AS
SELECT 
	@Ime = k.Ime, 
	@Prezime = k.Prezime, 
	@IzdaoRacuna = COUNT(*)
FROM Komercijalist AS k
INNER JOIN Racun AS r ON k.IDKomercijalist = r.KomercijalistID
WHERE k.IDKomercijalist = @KomercijalistID
GROUP BY k.Ime, k.Prezime
GO

DECLARE @Ime nvarchar(50), @Prezime nvarchar(50), @IzdaoRacuna int
EXEC p12 276, @Ime OUTPUT, @Prezime OUTPUT, @IzdaoRacuna OUTPUT
SELECT @Ime
SELECT @Prezime
SELECT @IzdaoRacuna
GO

DROP PROC p12
GO

-- Primjer 13. Napišite proceduru koja prima ime i prezime kupca i vraća 0
-- kao RETURN parametar ako kupac postoji u tablici, odnosno 200 ako kupac ne 
-- postoji. Pozovite proceduru i ispišite RETURN vrijednost.
CREATE PROC p13
	@Ime nvarchar(50),
	@Prezime nvarchar(50)
AS
IF EXISTS(SELECT * FROM Kupac WHERE Ime = @Ime AND Prezime = @Prezime)
	RETURN 0
ELSE
	RETURN 200
GO

DECLARE @RetVal int
EXEC @RetVal = p13 'Amy', 'Alberts'
PRINT @RetVal
GO

DECLARE @RetVal int
EXEC @RetVal = p13 'Pa�ko', 'Patak'
PRINT @RetVal
GO

-- Primjer 14. Promijenite proceduru iz prethodnog zadatka tako da bude zaštićena.
ALTER PROC p13
	@Ime nvarchar(50),
	@Prezime nvarchar(50)
WITH ENCRYPTION
AS
IF EXISTS(SELECT * FROM Kupac WHERE Ime = @Ime AND Prezime = @Prezime)
	RETURN 0
ELSE
	RETURN 200
GO

-- Primjer 15. Uklonite proceduru.
DROP PROC p13
GO

-- Primjer 16. Napravite tablicu Student koja se sastoji od stupaca IDStudent, Ime, 
-- Prezime i JMBAG i umetnite neke podatke. Napišite proceduru koja vraća ime i prezime 
-- iz te tablice i pozovite je.
CREATE TABLE Student
(
	IDStudent int CONSTRAINT PK_Student PRIMARY KEY IDENTITY,
	Ime nvarchar(50),
	Prezime nvarchar(50),
	JMBAG char(11)
)
GO

INSERT INTO Student (Ime, Prezime, JMBAG) VALUES ('Miro', 'Miri�', '111222333')
INSERT INTO Student (Ime, Prezime, JMBAG) VALUES ('Ana', 'Ani�', '999888777')
GO

CREATE PROC p16
AS
SELECT Ime, Prezime FROM Student
GO

EXEC p16
GO

-- Primjer 17. Promijenite proceduru tako da uz ime i prezime vraća i datum rođenja. Što se desilo?
ALTER PROC p16
AS
SELECT Ime, Prezime, DatumRodjenja FROM Student
GO

-- Primjer 18. Promijenite proceduru tako da vraća sve zapise iz tablice
-- IzmisljenaTablica. Što se desilo? Pokrenite proceduru. Što se desilo?
ALTER PROC p16
AS
SELECT * FROM IzmisljenaTablica
GO

EXEC p16
GO

-- Primjer 19. Napravite tablicu IzmisljenaTablica i pokrenite proceduru. Što se desilo?
CREATE TABLE IzmisljenaTablica
(
	Naziv nvarchar(50)
)
GO

EXEC p16
GO


-- CRUD.

-- Primjer 20. Svaka operacija posebno. Napravite procedure koje rade CRUD operacije 
-- na tablici Student tako da svakoj operaciji dodijelite posebnu proceduru. 
-- Iskoristite procedure za umetanje, izmjenu, dohvaćanje i brisanje zapisa.
CREATE PROC InsertStudent
	@IDStudent int OUTPUT, 
	@Ime nvarchar(50), 
	@Prezime nvarchar(50), 
	@JMBAG char(11)
AS
INSERT INTO Student (Ime, Prezime, JMBAG) VALUES (@Ime, @Prezime, @JMBAG)
SET @IDStudent = SCOPE_IDENTITY()
GO

CREATE PROC UpdateStudent
	@IDStudent int, 
	@Ime nvarchar(50), 
	@Prezime nvarchar(50), 
	@JMBAG char(11)
AS
UPDATE Student 
SET Ime = @Ime, Prezime = @Prezime, JMBAG = @JMBAG
WHERE IDStudent = @IDStudent
GO

CREATE PROC DeleteStudent
	@IDStudent int
AS
DELETE FROM Student WHERE IDStudent = @IDStudent
GO

CREATE PROC GetStudent
	@IDStudent int
AS
SELECT * FROM Student WHERE IDStudent = @IDStudent
GO

EXEC GetStudent 1

DECLARE @NoviIDStudenta int
EXEC InsertStudent @IDStudent = @NoviIDStudenta OUTPUT, @Ime = 'Ana', @Prezime = 'Ani�', @JMBAG = '11224451253'
SELECT @NoviIDStudenta

EXEC GetStudent 1

EXEC UpdateStudent 1, 'Ana', 'Ani� Miri�', '11224451253'

EXEC GetStudent 1

EXEC DeleteStudent 1

EXEC GetStudent 1
GO

-- Primjer 21. INSERT/UPDATE zajedno, ostalo posebno. Napravite procedure koje rade 
-- CRUD operacije na tablici Student tako da operacije umetanja i izmjene obavite u
-- jednoj proceduri, a druge dvije operacije obavite u posebnim procedurama. Iskoristite 
-- procedure za umetanje, izmjenu, dohvaćanje i brisanje zapisa.
CREATE PROC MergeStudent
	@IDStudent int OUTPUT, 
	@Ime nvarchar(50), 
	@Prezime nvarchar(50), 
	@JMBAG char(11)
AS
IF EXISTS(SELECT * FROM Student WHERE IDStudent = @IDStudent)
	UPDATE Student 
	SET Ime = @Ime, Prezime = @Prezime, JMBAG = @JMBAG
	WHERE IDStudent = @IDStudent
ELSE
	INSERT INTO Student (Ime, Prezime, JMBAG) VALUES (@Ime, @Prezime, @JMBAG)
	SET @IDStudent = SCOPE_IDENTITY()
GO

CREATE PROC DeleteStudent
	@IDStudent int
AS
DELETE FROM Student WHERE IDStudent = @IDStudent
GO

CREATE PROC GetStudent
	@IDStudent int
AS
SELECT * FROM Student WHERE IDStudent = @IDStudent
GO

EXEC GetStudent 1

DECLARE @NoviIDStudenta int
EXEC MergeStudent @NoviIDStudenta OUTPUT, 'Ana', 'Ani�', '11224451253'
PRINT @NoviIDStudenta

EXEC GetStudent 2

EXEC MergeStudent 2, 'Ana', 'Ani� Miri�', '11224451253'

EXEC GetStudent 2

EXEC DeleteStudent 2

EXEC GetStudent 2
GO

-- Primjer 22. UPDATE/INSERT/DELETE zajedno. Napravite procedure koje rade CRUD 
-- operacije na tablici Student tako da operacije umetanja, izmjene i brisanja obavite 
-- u jednoj proceduri, a dohvaćanje u drugoj. Iskoristite procedure za umetanje, izmjenu, 
-- dohvaćanje i brisanje zapisa.
CREATE PROC ChangeStudent
	@Operacija char(1),
	@IDStudent int OUTPUT, 
	@Ime nvarchar(50), 
	@Prezime nvarchar(50), 
	@JMBAG char(11)
AS
IF @Operacija = 'U'
	UPDATE Student 
	SET Ime = @Ime, Prezime = @Prezime, JMBAG = @JMBAG
	WHERE IDStudent = @IDStudent
ELSE IF @Operacija = 'I' BEGIN
	INSERT INTO Student (Ime, Prezime, JMBAG) VALUES (@Ime, @Prezime, @JMBAG)
	SET @IDStudent = SCOPE_IDENTITY()
END
ELSE IF @Operacija = 'D'
	DELETE FROM Student WHERE IDStudent = @IDStudent
GO

CREATE PROC GetStudent
	@IDStudent int
AS
SELECT * FROM Student WHERE IDStudent = @IDStudent
GO

EXEC GetStudent 3

DECLARE @NoviIDStudenta int
EXEC ChangeStudent 'I', @NoviIDStudenta OUTPUT, 'Ana', 'Ani�', '11224451253'
PRINT @NoviIDStudenta

EXEC GetStudent 3

EXEC ChangeStudent 'U', 3, 'Ana', 'Ani� Miri�', '11224451253'

EXEC GetStudent 3

EXEC ChangeStudent 'D', 3, null, null, null

EXEC GetStudent 3
GO



-- -- -- -- -- -- -- -- PREDAVANJE 7
-- 1. Dohvatite sve podatke za račune iz 2003, s tim da datum
-- izdavanja formatirate na hrvatski način.
SELECT	
	IDRacun, 
	CONVERT(char(10), r.DatumIzdavanja, 104) AS DatumIzdavanja, 
	BrojRacuna, KupacID, KomercijalistID, KreditnaKarticaID, Komentar
FROM Racun AS r
WHERE YEAR(DatumIzdavanja) = 2003

-- 2. Dohvatite nazive svih proizvoda i uz svaki naziv u zagradi ispišite i njegov ID.
SELECT Naziv + ' (' + CAST(IDProizvod AS nvarchar(20)) + ')' AS Naziv
FROM Proizvod

-- ili

SELECT Naziv + ' (' + CONVERT(nvarchar(50), IDProizvod) + ')' AS Naziv
FROM Proizvod

/* 3. Dohvatite sve proizvode i pri tome dodajte još jedan
stupac u kojem ćete ispisati:
o "Jeftino" ako je cijena manja od 100
o "Srednje skupo" ako je cijena između 100 i 1000
o "Skupo" ako je cijena veća od 1000 */
SELECT *,
	CASE
		WHEN CijenaBezPDV < 100 THEN 'Jeftino'
		WHEN CijenaBezPDV BETWEEN 100 AND 1000 THEN 'Srednje skupo'
		ELSE 'Skupo'
	END AS CijenaKomentar
FROM Proizvod

-- 4. Dohvatite naziv i boju svih proizvoda. Za boju koja je NULL ispisati "Nije definirana".
SELECT Naziv, 
	CASE
		WHEN Boja IS NULL THEN 'Nedefinirana'
		ELSE Boja
	END AS Boja
FROM Proizvod

-- ili 

SELECT Naziv, ISNULL(Boja, 'Nedefinirana') AS Boja
FROM Proizvod

-- 5. Deklarirajte varijable @a i @b i dajte im vrijednosti 51 i 0. Unutar TRY bloka 
-- izračunajte @a / @b. Unutar CATCH bloka ispišite informacije o greški koja se desila.
DECLARE @a int = 51
DECLARE @b int = 0

BEGIN TRY
	PRINT @a / @b
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
	PRINT ERROR_NUMBER()
	PRINT ERROR_SEVERITY()
	PRINT ERROR_LINE()
	PRINT ERROR_PROCEDURE()
END CATCH
GO

/* 6. Napravite tablicu Vrsta koja ima stupce IDVrsta (primarni ključ, ali nije IDENTITY) 
    i Naziv. Napravite proceduru koja prima IDVrsta i Naziv i umeće ih u tablicu. Pozovite
    proceduru dva puta s vrijednostima 1 i "Pingvin".
    o Implementirajte TRY/CATCH izvan procedure i pozovite je.
    o Implementirajte TRY/CATCH unutar procedure i pozovite je.
*/
CREATE TABLE Vrsta
(
	IDVrsta int CONSTRAINT PK_Vrsta PRIMARY KEY,
	Naziv nvarchar(50)
)
GO

CREATE PROC InsertVrsta
	@IDVrsta int,
	@Naziv nvarchar(50)
AS
INSERT INTO Vrsta (IDVrsta, Naziv) VALUES (@IDVrsta, @Naziv)
GO

EXEC InsertVrsta 1, 'Pingvin'
EXEC InsertVrsta 1, 'Pingvin'
GO

BEGIN TRY
	EXEC InsertVrsta 2, 'Slon'
	EXEC InsertVrsta 2, 'Slon'
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
	PRINT ERROR_NUMBER()
	PRINT ERROR_SEVERITY()
	PRINT ERROR_LINE()
	PRINT ERROR_PROCEDURE()
END CATCH
GO

ALTER PROC InsertVrsta
	@IDVrsta int,
	@Naziv nvarchar(50)
AS
BEGIN TRY
	INSERT INTO Vrsta (IDVrsta, Naziv) VALUES (@IDVrsta, @Naziv)
END TRY
BEGIN CATCH
	PRINT 'Desila se gre�ka: ' + ERROR_MESSAGE()
	PRINT 'Vrsta nije upisana.'
END CATCH
GO

EXEC InsertVrsta 3, 'Ovca'
EXEC InsertVrsta 3, 'Ovca'
GO

-- 7. Napišite funkciju koja prima ID proizvoda i dohvaća broj prodanih primjeraka. 
-- Pozovite funkciju samostalno. Dohvatite sve nazive i boje i uz svaki proizvod ispišite
-- koliko primjeraka je prodano. Promijenite funkciju tako da vrati 0 za one proizvode 
-- koji nisu prodani niti u jednom primjerku. Ako treba, optimizirajte. Uklonite funkciju.
CREATE FUNCTION UkupnaKolicina
(
	@IDProizvod int
)
RETURNS int
AS
BEGIN
	DECLARE @Ukupno int

	SELECT @Ukupno = Sum(Kolicina) FROM Stavka WHERE ProizvodID = @IDProizvod

	RETURN @Ukupno
END
GO

DECLARE @Rez int
SET @Rez = dbo.UkupnaKolicina(776)
SELECT @Rez

SELECT
	Naziv,
	Boja,
	dbo.UkupnaKolicina(IDProizvod) AS Prodano
FROM Proizvod
GO

ALTER FUNCTION UkupnaKolicina
(
	@IDProizvod int
)
RETURNS int
AS
BEGIN
	DECLARE @Ukupno int

	SELECT @Ukupno = Sum(Kolicina) FROM Stavka WHERE ProizvodID = @IDProizvod

	RETURN 
		CASE
			WHEN @Ukupno IS NOT NULL THEN @Ukupno
			ELSE 0
		END
END
GO

SELECT
	Naziv,
	Boja,
	dbo.UkupnaKolicina(IDProizvod) AS Prodano
FROM Proizvod
GO

CREATE INDEX ix1 ON Stavka (ProizvodID) INCLUDE (Kolicina)

SELECT
	Naziv,
	Boja,
	dbo.UkupnaKolicina(IDProizvod) AS Prodano
FROM Proizvod
GO

-- 8. Napišite funkciju koja prima string. Ako je broj znakova u stringu <= 10, 
-- neka funkcija vrati ulazni string. Ako ne, neka vrati prvih 7 znakova i iza toga 
-- tri točke. Ispišite nazive svih proizvoda koristeći napravljenu funkciju.
CREATE FUNCTION Skrati
(
	@s nvarchar(max)
)
RETURNS nvarchar(10)
AS
BEGIN
	RETURN CASE
		WHEN LEN(@s) <= 10 THEN @s
		ELSE SUBSTRING(@s, 1, 7) + '...'
	END
END
GO

SELECT dbo.Skrati('Zvonko')
SELECT dbo.Skrati('Zvonko Telefonko')

SELECT 
	Naziv,
	dbo.Skrati(Naziv) AS NazivSkraceni
FROM Proizvod
GO

-- 9. Napišite funkciju koja za zadanog kupca vraća datum najnovije kupovine. 
-- Ispišite sve kupce i kraj svakog ispišite datum najnovije kupovine. Ako treba, optimizirajte.
CREATE FUNCTION GetNajnoviji
(
	@IDKupac int
)
RETURNS datetime
AS
BEGIN
	DECLARE @Datum datetime
	
	SELECT TOP 1 @Datum = DatumIzdavanja FROM Racun
	WHERE KupacID = @IDKupac
	ORDER BY DatumIzdavanja DESC
	
	RETURN @Datum
END
GO

SELECT 
	IDKupac,
	dbo.GetNajnoviji(IDKupac) AS NajnovijaKupnja
FROM Kupac
GO

CREATE NONCLUSTERED INDEX ix2 ON Racun(KupacID) INCLUDE (DatumIzdavanja)
GO

SELECT 
	IDKupac,
	dbo.GetNajnoviji(IDKupac) AS NajnovijaKupnja
FROM Kupac
GO

-- 10. Napišite jednostavnu tabličnu funkciju koja vraća IDKupac, ime i prezime 
-- svih osoba čije prezime započinje sa zadanim stringom. Iskoristite funkciju za 
-- dohvat svih osoba čije prezime započinje sa 'Ac'. Uz svaku osobu dohvatite i njegove narudžbe.
CREATE FUNCTION DohvatiOsobe
(
    @PrezimeLike nvarchar(50)
)
RETURNS TABLE
AS
RETURN
    SELECT IDKupac, Ime, Prezime
    FROM Kupac
    WHERE Prezime LIKE @PrezimeLike + '%'
GO

SELECT * FROM DohvatiOsobe('Ac')
GO

SELECT * 
FROM DohvatiOsobe('Ac') AS o
INNER JOIN Racun AS r ON o.IDKupac = r.KupacID
GO

-- 11. Napišite jednostavnu tabličnu funkciju koja prima dva datuma. Neka funkcija 
-- vrati sve račune koji su izrađeni između tih datuma. Iskoristite funkciju za dohvat 
-- računa između 11.11.2002. i 15.03.2003. 
-- + Promijenite funkciju tako da datum izdavanja vrati u hrvatskom formatu.
CREATE FUNCTION DohvatiRacuneIzmedju
(
    @D1 datetime, 
    @D2 datetime
)
RETURNS TABLE
AS
RETURN
	SELECT *
	FROM Racun AS r
	WHERE r.DatumIzdavanja BETWEEN @D1 AND @D2
GO

SELECT * FROM DohvatiRacuneIzmedju('20021111', '20030315')
GO

ALTER FUNCTION DohvatiRacuneIzmedju
(
    @D1 datetime, 
    @D2 datetime
)
RETURNS TABLE
AS
RETURN
	SELECT 
		IDRacun, 
		CONVERT(char(10), r.DatumIzdavanja, 104) AS DatumIzdavanja, 
		BrojRacuna, KupacID, KomercijalistID, KreditnaKarticaID, Komentar
	FROM Racun AS r
	WHERE r.DatumIzdavanja BETWEEN @D1 AND @D2
GO

SELECT * FROM DohvatiRacuneIzmedju('20021111', '20030315')
GO

-- 12. Napišite i iskoristitie funkciju jednaku onoj iz zadatka 11, ali neka ova bude složena. 
CREATE FUNCTION DohvatiRacuneIzmedjuSlozena
(
    @D1 datetime, 
    @D2 datetime
)
RETURNS @rez TABLE
(
	IDRacun int, 
	DatumIzdavanja datetime, 
	BrojRacuna nvarchar(25), 
	KupacID int, 
	KomercijalistID int, 
	KreditnaKarticaID int, 
	Komentar nvarchar(128)	
)
AS
BEGIN
	
	INSERT INTO @rez (IDRacun, DatumIzdavanja, BrojRacuna, KupacID, KomercijalistID, KreditnaKarticaID, Komentar)
	SELECT IDRacun, DatumIzdavanja, BrojRacuna, KupacID, KomercijalistID, KreditnaKarticaID, Komentar
	FROM Racun AS r
	WHERE r.DatumIzdavanja BETWEEN @D1 AND @D2
	
	RETURN
END
GO

SELECT * FROM DohvatiRacuneIzmedjuSlozena('20021111', '20030315')
GO

-- 13. Napišite složenu tabličnu funkciju koja prima cijenu. Ako je cijena NULL, 
-- vratite nazive i cijene svih proizvoda iz tablice Proizvod. Ako nije, vratite 
-- nazive i cijene samo onih proizvoda čija cijena je veća od zadane cijene.
-- Iskoristite funkciju s NULL i s nekom cijenom.
CREATE FUNCTION Slozena13
(
	@Cijena money
)
RETURNS @rez TABLE ( Naziv nvarchar(50), Cijena money )
AS
BEGIN
	IF @Cijena IS NULL BEGIN
		INSERT INTO @rez (Naziv, Cijena)
		SELECT Naziv, CijenaBezPDV FROM Proizvod
	END
	ELSE BEGIN
		INSERT INTO @rez (Naziv, Cijena)
		SELECT Naziv, CijenaBezPDV FROM Proizvod WHERE CijenaBezPDV > @Cijena
	END
	
	RETURN
END
GO

SELECT * FROM Slozena13(NULL)
SELECT * FROM Slozena13(2300)
GO

-- 14. Napravite tablicu Student koja se sastoji od IDStudent, Ime, Prezime i JMBAG. 
-- Napravite procedure koje rade CRUD operacije INSERT, UPDATE i DELETE na tablici Student. 
-- Svakoj operaciji dodijelite posebnu proceduru. Operaciju SELECT implementirajte 
-- tabličnom funkcijom. Iskoristite procedure i funkcije za umetanje, izmjenu, 
-- dohvaćanje i brisanje zapisa.
CREATE TABLE Student
(
	IDStudent int CONSTRAINT PK_Student PRIMARY KEY IDENTITY,
	Ime nvarchar(50),
	Prezime nvarchar(50),
	JMBAG char(11)
)
GO

CREATE PROC InsertStudent
	@IDStudent int OUTPUT, 
	@Ime nvarchar(50), 
	@Prezime nvarchar(50), 
	@JMBAG char(11)
AS
INSERT INTO Student (Ime, Prezime, JMBAG) VALUES (@Ime, @Prezime, @JMBAG)
SET @IDStudent = SCOPE_IDENTITY()
GO

CREATE PROC UpdateStudent
	@IDStudent int, 
	@Ime nvarchar(50), 
	@Prezime nvarchar(50), 
	@JMBAG char(11)
AS
UPDATE Student 
SET Ime = @Ime, Prezime = @Prezime, JMBAG = @JMBAG
WHERE IDStudent = @IDStudent
GO

CREATE PROC DeleteStudent
	@IDStudent int
AS
DELETE FROM Student WHERE IDStudent = @IDStudent
GO

CREATE FUNCTION dbo.GetStudent
(
    @IDStudent int
)
RETURNS TABLE
AS
    RETURN SELECT * FROM Student WHERE IDStudent = @IDStudent
GO

SELECT * FROM GetStudent(1)

DECLARE @NoviIDStudenta int
EXEC InsertStudent @IDStudent = @NoviIDStudenta OUTPUT, @Ime = 'Ana', @Prezime = 'Ani�', @JMBAG = '11224451253'
PRINT @NoviIDStudenta

SELECT * FROM GetStudent(1)

EXEC UpdateStudent 1, 'Ana', 'Anic Miric', '11224451253'

SELECT * FROM GetStudent(1)

EXEC DeleteStudent 1

SELECT * FROM GetStudent(1)
GO