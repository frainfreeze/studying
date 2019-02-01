-- I2: pogledi --
-----------------
-- Iskoristite pogled za dohvaæanje onih osoba èije ime zapoèinje sa L i prezime zavrava na a
SELECT * FROM p1 
WHERE Ime LIKE 'L%' AND Prezime LIKE '%a'

-- Iskoristite pogled za ispis svih ID-eva gradova i broja osoba koje ive u tom gradu, padajuæe prema broju osoba
SELECT GradID, COUNT(*) AS BrojOsoba 
FROM p1 
GROUP BY GradID 
ORDER BY BrojOsoba DESC

-- Iskoristite pogled tako da ispiete ime i prezime te pokraj svakoga ispisite njegov naziv grada i naziv drzave
SELECT p1.Ime, p1.Prezime, g.Naziv as 'Grad', d.Naziv as 'Drava'
FROM p1
LEFT JOIN Grad AS g ON p1.GradID = g.IDGrad
LEFT JOIN Drzava AS d ON g.DrzavaID= d.IDDrzava

-- Promijenite pogled tako da ne ukljuèuje stupce Email, Telefon i GradID
ALTER VIEW p1 AS
SELECT IDKupac, Ime, Prezime FROM Kupac

-- Uklonite pogled
DROP VIEW p1

-- Ispiite nazive svih kupaca, te za svakoga ispiite email, grad i naziv drave u kojoj je smjeten
CREATE VIEW p2 AS
SELECT 
	k.Ime, k.Prezime, k.Email,
	g.Naziv AS Grad,
	d.Naziv AS Drzava
FROM Kupac AS k
LEFT JOIN Grad AS g ON k.GradID = g.IDGrad
LEFT JOIN Drzava AS d ON g.DrzavaID = d.IDDrzava

-- Ispisite sve drave i za svaku od njih ispiite koliko kupaca iz nje postoji
CREATE VIEW p3 AS
SELECT 
	d.Naziv AS Drzava,
	COUNT(k.IDKupac) AS BrojKupaca
FROM Kupac AS k
LEFT JOIN Grad AS g ON k.GradID = g.IDGrad
LEFT JOIN Drzava AS d ON g.DrzavaID = d.IDDrzava
GROUP BY d.Naziv

-- Ispisite nazive svih proizvoda koje je kupilo >300 kupaca
CREATE VIEW p4 AS
SELECT 
	p.Naziv, COUNT(k.IDKupac) AS BrojKupaca
FROM Proizvod AS p
INNER JOIN Stavka AS s ON s.ProizvodID = p.IDProizvod
INNER JOIN Racun AS r ON s.RacunID = r.IDRacun
INNER JOIN Kupac AS k ON r.KupacID = k.IDKupac
GROUP BY p.Naziv
HAVING COUNT(k.IDKupac) > 300

-- Ispiite nazive i zaradu 5 proizvoda koji se najbolje prodaju
CREATE VIEW p5 AS
SELECT TOP 5
	p.Naziv, SUM(s.UkupnaCijena) AS Zarada
FROM Proizvod AS p
INNER JOIN Stavka AS s ON s.ProizvodID = p.IDProizvod
GROUP BY p.Naziv
ORDER BY Zarada DESC

-- Napravite pogled koji vraæa imena i prezimena te e-mailove svih kupaca iz Zagreba.
CREATE VIEW p6 AS
SELECT 
	k.Ime, k.Prezime, k.Email, g.Naziv AS Grad
FROM Kupac AS k
INNER JOIN Grad AS g ON k.GradID = g.IDGrad
WHERE g.Naziv = 'Zagreb'

-- Promijenite pogled tako da dohvaca i sve kupce iz Splita.
ALTER VIEW p6 AS
SELECT 
	k.Ime, k.Prezime, k.Email, g.Naziv AS Grad
FROM Kupac AS k
INNER JOIN Grad AS g ON k.GradID = g.IDGrad
WHERE g.Naziv = 'Zagreb' OR g.Naziv = 'Split'

-- Koristeci pogled ispisite broj kupaca iz Zagreba i broj kupaca iz Splita.
SELECT 
	Grad, COUNT(*) AS Broj
FROM p6
GROUP BY Grad


-- Napravite pogled koji æe dohvaæati sve stupce i retke iz tablice Kategorija
CREATE VIEW v1 AS
SELECT * FROM Kategorija
GO
-- Ispiite nazive kategorija, potkategorija i proizvoda (koristite kreirani pogled)
SELECT
	v1.Naziv as 'Kategorija',
	Potkategorija.Naziv as 'Potkategorija',
	Proizvod.Naziv as 'Proizvod'
FROM v1
RIGHT JOIN Potkategorija ON Potkategorija.KategorijaID = v1.IDKategorija
RIGHT JOIN Proizvod ON Proizvod.PotkategorijaID = Potkategorija.IDPotkategorija
GO
-- Pomoæu pogleda umetnite kategoriju naziva Alarmi
INSERT INTO v1 (Naziv) VALUES ('Alarmi')
GO
-- Pomoæu pogleda promijenite kategoriji Alarmi naziv u Aktivna zatita
UPDATE v1 SET Naziv = 'Aktivna zatita' WHERE Naziv = 'Alarmi'
GO
-- Pomoæu pogleda obriite kategoriju Aktivna zatita
DELETE FROM v1 WHERE Naziv = 'Aktivna zatita'
GO

-- Napravite pogled koji æe dohvaæati naziv grada, naziv drave u kojoj se nalazi te sve podatke o kupcima koji im pripadaju
CREATE VIEW v2 AS
SELECT
	Drzava.Naziv as 'Drava', Grad.Naziv as 'Grad', Kupac.* 
FROM Kupac
LEFT JOIN Grad ON Kupac.GradID = Grad.IDGrad
LEFT JOIN Drzava ON Grad.DrzavaID = Drzava.IDDrzava
GO
-- Probajte pomoæu pogleda umetnuti novi grad. to se dogodilo?
INSERT INTO v2 (Grad) VALUES ('Bedekovèina')
GO
-- Probajte pomoæu pogleda umetnuti novu dravu. to se dogodilo?
INSERT INTO v2 (Drava) VALUES ('Uzbekistan')
GO
-- Probajte pomoæu pogleda umetnuti novog kupca. to se dogodilo? Moete li vidjeti novododanog kupca kroz pogled? Postoji li on u tablici?
INSERT INTO v2 (Ime, Prezime) 
	VALUES ('Pero','Periæ')
GO

-- Napravite pogled koji æe dohvaæati sve kreditne kartice koje su tipa Visa ili MasterCard (tablica KreditnaKastica)
CREATE VIEW v3 AS
SELECT * FROM KreditnaKartica WHERE Tip IN ('Visa', 'MasterCard')
GO
-- Umetnite zapis o kreditnoj kartici tipa American Express.
-- Dohvatiti umetnuti redak pomoæu pogleda. to se dogodilo? Je li redak uspjeno umetnut u tablicu?
INSERT INTO v3 (Tip, Broj,IstekMjesec, IstekGodina) 
VALUES ('American Express', '111222333444', 12, 2012)
GO
SELECT * FROM v3 WHERE Tip = 'American Express'
GO
-- Promijenite pogled tako da ne doputa umetanje/izmjenu redaka koji neæe biti vidljivi kroz njega.
ALTER VIEW v3 AS
SELECT * FROM KreditnaKartica WHERE Tip IN ('Visa', 'MasterCard')
WITH CHECK OPTION
GO
INSERT INTO v3 (Tip, Broj,IstekMjesec, IstekGodina) 
VALUES ('American Express', '111222333444', 12, 2012)
GO
-- Umetnite zapis o kreditnoj kartici tipa MasterCard. to se dogodilo? Je li redak uspjeno umetnut u tablicu?
INSERT INTO v3 (Tip, Broj,IstekMjesec, IstekGodina) 
VALUES ('MasterCard', '111222333444', 12, 2012)
GO
-- Promijenite pogled tako da doputa umetanje/izmjenu redaka koji neæe biti vidljivi kroz njega.
ALTER VIEW v3 AS
SELECT * FROM KreditnaKartica WHERE Tip IN ('Visa', 'MasterCard')
GO

/* Napravite pogled koji dohvaæa 10 proizvoda koji su najvie prodavani. Stupci koje pogled vraæa neka budu ID i naziv te ukupna kolièina prodanih proizvoda.
Pogledajte SELECT upit pogleda kroz suèelje i pomoæu sistemske procedure sp_helptext
Zatitite pogled
Pogledajte SELECT upit pogleda kroz suèelje i pomoæu sistemske procedure sp_helptext
Promijenite pogled tako da bude zatiæen i èvrsto vezan uz tablice
Promijenite pogled tako da bude zatiæen, èvrsto vezan uz tablice i da ne doputa izmjene koje neæe biti vidljive kroz pogled
*/
CREATE VIEW v5 AS
SELECT TOP 10 
	Proizvod.IDProizvod AS 'ID',
	Proizvod.Naziv,
	SUM(Stavka.Kolicina) AS 'UkupnaKolicina'
FROM Proizvod
INNER JOIN Stavka ON Stavka.ProizvodID = Proizvod.IDProizvod
GROUP BY Proizvod.IDProizvod, Proizvod.Naziv
ORDER BY 3 DESC
GO

SELECT * FROM v5
GO

EXECUTE sp_helptext v5
GO

ALTER VIEW v5 
WITH ENCRYPTION
AS
SELECT TOP 10 
	Proizvod.IDProizvod AS 'ID',
	Proizvod.Naziv,
	SUM(Stavka.Kolicina) AS 'UkupnaKolicina'
FROM Proizvod
INNER JOIN Stavka ON Stavka.ProizvodID = Proizvod.IDProizvod
GROUP BY Proizvod.IDProizvod, Proizvod.Naziv
ORDER BY 3 DESC
GO

EXECUTE sp_helptext v5
GO

ALTER VIEW v5 
WITH ENCRYPTION, SCHEMABINDING
AS
SELECT TOP 10 
	dbo.Proizvod.IDProizvod AS 'ID',
	dbo.Proizvod.Naziv,
	SUM(dbo.Stavka.Kolicina) AS 'UkupnaKolicina'
FROM dbo.Proizvod
INNER JOIN dbo.Stavka ON dbo.Stavka.ProizvodID = dbo.Proizvod.IDProizvod
GROUP BY dbo.Proizvod.IDProizvod, dbo.Proizvod.Naziv
ORDER BY 3 DESC
GO

ALTER VIEW v5 
WITH ENCRYPTION, SCHEMABINDING
AS
SELECT TOP 10 
	dbo.Proizvod.IDProizvod AS 'ID',
	dbo.Proizvod.Naziv,
	SUM(dbo.Stavka.Kolicina) AS 'UkupnaKolicina'
FROM dbo.Proizvod
INNER JOIN dbo.Stavka ON dbo.Stavka.ProizvodID = dbo.Proizvod.IDProizvod
GROUP BY dbo.Proizvod.IDProizvod, dbo.Proizvod.Naziv
ORDER BY 3 DESC
WITH CHECK OPTION
GO


-- i3: rad s diskom --
----------------------
/* DBCC TRACEON(3604) vrijedi za cijelu konekciju
• DBCC IND će nam vratiti sljedeće bitne podatke:
    • PageFID – rbr podatkovne datoteke (kod nas uvijek 1)
    • PagePID – rbr stranice unutar podatkovne datoteke
    • PageType – tip stranice
        • 1 = podatkovna stranica
        • 2 = indeksna stranica
• Za DBCC PAGE koristimo gornje podatke
    • Vraća zaglavlje i niz slotova koji sadržavaju retke

zad 1:
a. Na koliko stranica su smješteni podaci iz tablice Drzava (PageType jednak 1)?
b. Napišite redne brojeve stranica (PagePID) i redne brojeve datoteke u kojoj su smještene stranice (PageFID).
c. Kolika je duljina prvog, drugog i trećeg retka u bajtovima?
d. Po kojem stupcu su poslagani reci na stranicama?
e. Pronađite redak za “Njemačka". Koji su reci ispred i iza njega? */
DBCC TRACEON(3604) -- uljucen ispis svih dbcc poruka
DBCC IND('AdventureWorksOBP', 'Drzava', -1) -- prikaz stranica koje pripadaju tablici, vrijednost -1 oznacava podatkovne i indeksne stranice
-- a. DBCC IND vraæa 2 retka, ali samo jedan od njih ima PageType jednak 1. Dakle, svi podaci iz tablice su smjeteni na jednu stranicu.
-- b. PageFID = 1, PagePID = 77

DBCC PAGE('AdventureWorksOBP', 1, 77, 3) WITH TABLERESULTS --prikz detalja stranice, vrijednost 3 znaci najvise detalja
-- c. Za 1. redak imamo: "Slot 0 Offset 0x60 Length 31", dakle, njegova duljina je 31 bajta.
--    Za 2. redak imamo: "Slot 1 Offset 0x7f Length 31", dakle, njegova duljina je 31 bajta.
--    Za 3. redak imamo: "Slot 2 Offset 0x9e Length 53", dakle, njegova duljina je 53 bajta.
-- d. Reci su poslagani po stupcu IDDrzava, uzlazno od a prema z.
-- e. Redak ispred Njemaèka je Hrvatska, a iza je Bosna i Hercegovina.


/* zad 2. 
a. Na koliko stranica su smješteni podaci iz tablice Proizvod?
b. Napišite redne brojeve stranica (PagePID) i redne brojeve datoteke u kojoj su smještene stranice (PageFID).
c. Kolika je duljina prvog, drugog i trećeg retka u bajtovima?
d. Koji je ProizvodID zadnjeg retka na prvoj stranici? Koji je ProizvodID prvog retka na drugoj stranici?
e. Koji je ProizvodID zadnjeg retka na drugoj stranici? Koji je ProizvodID prvog retka na trećoj stranici?
f. Po kojem stupcu su poslagani retci na stranicama? */
DBCC TRACEON(3604)
DBCC IND('AdventureWorksOBP', 'Proizvod', -1)
DBCC PAGE('AdventureWorksOBP', 1, 79, 3) WITH TABLERESULTS
DBCC PAGE('AdventureWorksOBP', 1, ???, 3) WITH TABLERESULTS

SELECT COUNT(*) FROM Proizvod
-- g. Ukupno stranica = ?? Ukupno redaka = 504 Prosjeèno redaka po stranici = ??

/* zad 3.
a. Na koliko stranica su smješteni podaci iz tablice Kupac?
b. Napišite redne brojeve prvih 5 stranica (PagePID) i redne brojeve datoteke u kojoj su smještene
stranice (PageFID).
c. Koliko redaka je smješteno na prvoj stranici?
d. Kolika je duljina prvog, drugog i trećeg retka u bajtovima? */
DBCC TRACEON(3604)
DBCC IND('AdventureWorksOBP', 'Kupac', -1)
DBCC PAGE('AdventureWorksOBP', 1, ???, 3) WITH TABLERESULTS

-- indeksi --
-------------
SET STATISTICS IO ON

-- Optimizirajte upit: SELECT PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 
-- a.) Koliko stranica pregled RDBMS?
SELECT PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 
-- (28 row(s) affected) \n Table 'Proizvod'. Scan count 1, logical reads 8, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- b.) Napravite indeks koji optimizira upit
CREATE NONCLUSTERED INDEX i1 ON Proizvod(PotkategorijaID)
GO
-- c.) Koliko sad stranica pregled RDBMS?
SELECT PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 
-- (28 row(s) affected) \n Table 'Proizvod'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- d.) Uklonite indeks
DROP INDEX Proizvod.i1
GO

-- Optimizirajte upit: SELECT IDProizvod, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 
-- a.) Koliko stranica pregled RDBMS?
SELECT IDProizvod, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12
-- (28 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 8, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 8
-- b.) Napravite indeks koji optimizira upit
CREATE NONCLUSTERED INDEX i1 ON Proizvod(PotkategorijaID)
GO
-- c.) Koliko sad stranica pregled RDBMS?
SELECT IDProizvod, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12
-- (28 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2
-- d.) Uklonite indeks
DROP INDEX Proizvod.i1
GO

-- Optimizirajte upit: SELECT ProductID, Name, ProductSubcategoryID FROM Production.Product WHERE ProductSubcategoryID = 12 
SELECT IDProizvod, Naziv, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12
-- (28 row(s) affected) Table 'Proizvod'. Scan count 1, logical reads 8, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
CREATE NONCLUSTERED INDEX i1 ON Proizvod(PotkategorijaID)
GO
SELECT IDProizvod, Naziv, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12
-- (28 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 8, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 8
-- a) Pomae li nam indeks iz prethodnog primjera? to uèiniti sa stupcem Naziv? 
-- logical reads 8 - mora iæi na klasterirani indeks jer mu nedostaje vrijednost za Naziv.
DROP INDEX Proizvod.i1
GO
CREATE NONCLUSTERED INDEX i1 ON Proizvod(PotkategorijaID) INCLUDE (naziv)
GO
SELECT IDProizvod, Naziv, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12
-- (28 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2 - sad ne mora ici na klasterirani indeks.
DROP INDEX Proizvod.i1
GO

-- Zadatak 4.
-- Optimizirajte upit: SELECT IDProizvod, Naziv, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 AND Naziv LIKE 'ML%'
SELECT IDProizvod, Naziv, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 AND Naziv LIKE 'ML%'
-- (8 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 8, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 8 - mora iæi na klasterirani indeks jer mu nedostaje vrijednost za Naziv.
CREATE NONCLUSTERED INDEX i1 ON Proizvod(PotkategorijaID) INCLUDE (naziv)
GO
SELECT IDProizvod, Naziv, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 AND Naziv LIKE 'ML%'
-- (8 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2 - sad ne mora iæi na klasterirani indeks.
DROP INDEX Proizvod.i1
GO

-- Optimizirajte upit: SELECT Boja, COUNT(*) AS Cnt FROM Proizvod WHERE PotkategorijaID = 12 GROUP BY Boja ORDER BY Cnt DESC
SELECT Boja, COUNT(*) AS Cnt FROM Proizvod WHERE PotkategorijaID = 12 GROUP BY Boja ORDER BY Cnt DESC
-- (2 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 8, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 8 - mora iæi na klasterirani indeks jer mu nedostaje vrijednost za Boja.
CREATE NONCLUSTERED INDEX i1 ON Proizvod(PotkategorijaID) INCLUDE (Boja)
GO
SELECT Boja, COUNT(*) AS Cnt FROM Proizvod WHERE PotkategorijaID = 12 GROUP BY Boja ORDER BY Cnt DESC
-- (2 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2 - sad ne mora iæi na klasterirani indeks.
DROP INDEX Proizvod.i1
GO

-- Optimizirajte upit: SELECT DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'  
-- a.) Koliko stranica pregled RDBMS?
SELECT DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 202
-- b.) Napravite indeks koji optimizira upit
CREATE NONCLUSTERED INDEX i1 ON Racun(DatumIzdavanja)
GO
-- c.) Koliko sad stranica pregled RDBMS?
SELECT DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' 
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2
-- d.) Uklonite indeks
DROP INDEX Racun.i1
GO

-- Optimizirajte upit: SELECT IDRacun, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'  
-- a.) Koliko stranica pregled RDBMS?
SELECT IDRacun, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 202
-- b.) Napravite indeks koji optimizira upit
CREATE NONCLUSTERED INDEX i1 ON Racun(DatumIzdavanja)
GO
-- c.) Koliko sad stranica pregled RDBMS?
SELECT IDRacun, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' 
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2
-- d.) Uklonite indeks
DROP INDEX Racun.i1
GO

-- Optimizirajte upit: SELECT IDRacun, BrojRacuna, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'  
SELECT IDRacun, BrojRacuna, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' 
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 202
CREATE NONCLUSTERED INDEX i1 ON Racun(DatumIzdavanja)
GO
SELECT IDRacun, BrojRacuna, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' 
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 202
-- a) Pomae li nam indeks iz prethodnog primjera? to uèiniti sa stupcem BrojRacuna? 
-- logical reads 202 - mora iæi na klasterirani indeks jer mu nedostaje vrijednost za BrojRacuna.
DROP INDEX Racun.i1
GO
CREATE NONCLUSTERED INDEX i1 ON Racun(DatumIzdavanja) INCLUDE (BrojRacuna)
GO
SELECT IDRacun, BrojRacuna, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' 
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2 - sad ne mora iæi na klasterirani indeks.
DROP INDEX Racun.i1
GO

-- Optimizirajte upit: SELECT IDRacun FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' AND BrojRacuna LIKE 'S%'  
SELECT IDRacun FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' AND BrojRacuna LIKE 'S%' 
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 202
CREATE NONCLUSTERED INDEX i1 ON Racun(DatumIzdavanja) INCLUDE (BrojRacuna)
GO
SELECT IDRacun FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' AND BrojRacuna LIKE 'S%' 
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2 - sad ne mora iæi na klasterirani indeks.
DROP INDEX Racun.i1
GO

-- Optimizirajte upit: SELECT KupacID, COUNT(*) AS Cnt  FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' GROUP BY KupacID ORDER BY Cnt DESC
SELECT KupacID, COUNT(*) AS Cnt  FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' GROUP BY KupacID ORDER BY Cnt DESC
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 202
CREATE NONCLUSTERED INDEX i1 ON Racun(DatumIzdavanja) INCLUDE (KupacID)
GO
SELECT KupacID, COUNT(*) AS Cnt  FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' GROUP BY KupacID ORDER BY Cnt DESC 
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2 - sad ne mora iæi na klasterirani indeks.
DROP INDEX Racun.i1
GO


-- i4: varijable i procedure --
-------------------------------
-- Deklarirajte varijable @Ime i @Prezime i dodijelite im vrijednosti iz tablice Kupac za IDKupac jednak 8812. 
DECLARE @Ime nvarchar(50) DECLARE @Prezime nvarchar(50)
SELECT @Ime = Ime, @Prezime = Prezime FROM Kupac WHERE IDKupac = 8812
SET NOCOUNT ON -- When SET NOCOUNT is ON, the count (indicating the number of rows affected by a Transact-SQL statement) is not returned.
/* Umetnite zapis u tablicu Drzava i u varijablu spremite generiranu IDENTITY vrijednost. 
Iskoristite tu vrijednost da biste za tu dr�avu umetnuli dva grada. */
DECLARE @IDDrzavaNovi int
INSERT INTO Drzava VALUES ('Kina')
select SCOPE_IDENTITY()
SET @IDDrzavaNovi = SCOPE_IDENTITY()
INSERT INTO Grad VALUES ('Peking', @IDDrzavaNovi)
GO
/* Napi�ite proceduru koja prima dvije cijene i vra�a nazive i cijene svih proizvoda �ija je cijena u zadanom rasponu. */
CREATE PROC p10 
    @Cijena1 money,
	@Cijena2 money
AS
SELECT Naziv, CijenaBezPDV FROM Proizvod WHERE CijenaBezPDV BETWEEN @Cijena1 AND @Cijena2
GO
EXEC p10 500, 1000
EXEC p10 @Cijena1 = 500, @Cijena2 = 1000
GO
DROP PROC p10
GO
/* prima naziv drzave i naziv grada.  Neka procedura umetne grad koji pripada zadanoj dr�avi. 
Pazite na to postoji li vec drzava upisana u tablicu Drzava ili ne postoji.  Ako postoji, nemojte je umetati ponovno. */
CREATE PROC p11
	@Drzava nvarchar(50),
	@Grad nvarchar(50)
AS
DECLARE @IDDrzava int
SELECT @IDDrzava = IDDrzava FROM Drzava WHERE Naziv = @Drzava

IF @IDDrzava IS NOT NULL BEGIN
	INSERT INTO Grad VALUES (@Grad, @IDDrzava)
END
ELSE BEGIN
	INSERT INTO Drzava VALUES (@Drzava)
	SET @IDDrzava = SCOPE_IDENTITY()
	INSERT INTO Grad VALUES (@Grad, @IDDrzava)
END
GO
EXEC p11 'Japan', 'Osaka'
GO
/* prima kriterij po kojemu �ete filtrirati prezimena iz tablice Kupac. Neka procedura pomo�u izlaznog parametra vrati broj zapisa koji zadovoljavaju zadani kriterij. Neka procedura vrati i sve zapise koji zadovoljavaju kriterij. */CREATE PROC p13	@Filter nvarchar(50),	@BrojZapisa int OUTPUTAS
SELECT @BrojZapisa = COUNT(*) FROM Kupac WHERE Prezime LIKE @Filter
SELECT * FROM Kupac WHERE Prezime LIKE @Filter
GO

DECLARE @Cnt int
EXEC p13 '%hu%', @Cnt OUTPUT
PRINT @Cnt
GO
/* za zadanog komercijalistu pomo�u izlaznih parametara vra�a njegovo ime 
i prezime te ukupnu zara�enu koli�inu novaca. */
CREATE PROC p14
	@KomercijalistID int,
	@Ime nvarchar(50) OUTPUT,
	@Prezime nvarchar(50) OUTPUT,
	@Zaradio money OUTPUT
AS
SELECT @Ime = Ime, @Prezime = Prezime
FROM Komercijalist
WHERE IDKomercijalist = @KomercijalistID
SELECT @Zaradio = SUM(s.UkupnaCijena) 
FROM Racun AS r
INNER JOIN Stavka AS s ON r.IDRacun = s.RacunID
WHERE r.KomercijalistID = @KomercijalistID
GO
DECLARE @Ime nvarchar(50), @Prezime nvarchar(50), @Zaradio money
EXEC p14 276, @Ime OUTPUT, @Prezime OUTPUT, @Zaradio OUTPUT
PRINT @Ime
PRINT @Prezime
PRINT @Zaradio
GO
/* ume�e novu kategoriju i kroz izlazni parametar vra�a generiranu IDENTITY vrijednost. 
Ako ve� postoji kategorija zadanog imena, ne treba je upisivati ponovno i u tom slu�aju kroz izlazni parametar vratite vrijednost -1. */
CREATE PROC p15
	@Kategorija nvarchar(50),
	@ID int OUTPUT
AS
IF NOT EXISTS(SELECT * FROM Kategorija WHERE Naziv = @Kategorija) 
	BEGIN
		INSERT INTO Kategorija VALUES (@Kategorija)
		SET @ID = SCOPE_IDENTITY()
	END
ELSE 
	BEGIN
		SET @ID = -1
	END
GO
/* kroz tri izlazna parametra vra�a najmanju, najve�u i prosje�nu cijenu proizvoda iz tablice Proizvod. 
Neka procedura vrati i sve proizvode koji imaju cijenu ve�u od 0 i manju od prosje�ne. */
CREATE PROC p16
	@Najmanja money OUTPUT,
	@Najveca money OUTPUT,
	@Prosjecna money OUTPUT
AS
SELECT 
	@Najmanja = MIN(CijenaBezPDV),
	@Najveca = MAX(CijenaBezPDV),
	@Prosjecna = AVG(CijenaBezPDV)
FROM Proizvod

SELECT * FROM Proizvod WHERE CijenaBezPDV > 0 AND CijenaBezPDV < @Prosjecna
GO
DECLARE @Najmanja money, @Najveca money, @Prosjecna money
EXEC p16 @Najmanja OUTPUT, @Najveca OUTPUT, @Prosjecna OUTPUT
PRINT @Najmanja
PRINT @Najveca
PRINT @Prosjecna
GO
/* prima ime i prezime osobe i vra�a 0 kao RETURN parametar ako osoba postoji u tablici, odnosno 200 ako osoba ne postoji.  */
CREATE PROC p15
	@Ime nvarchar(50),
	@Prezime nvarchar(50)
AS
DECLARE @BrojOsoba int
SELECT @BrojOsoba = Count(*) FROM Kupac WHERE Ime = @Ime AND Prezime = @Prezime
IF @BrojOsoba = 0
	RETURN 200
ELSE
	RETURN 0
GO
DECLARE @RetVal int
EXEC @RetVal = p15 'Amy', 'Albertss'
PRINT @RetVal
GO
/* Promijenite proceduru iz prethodnog zadatka tako da bude zasticena. */
ALTER PROC p15
	...
WITH ENCRYPTION
AS  
	...
/* Napravite tablicu Student koja se sastoji od stupaca IDStudent, Ime, Prezime i JMBAG. */
CREATE TABLE Student (
	IDStudent int PRIMARY KEY IDENTITY,
	Ime nvarchar(50),
	Prezime nvarchar(50),
	JMBAG char(11)
)
GO

/* Napravite procedure koje rade CRUD operacije na tablici Student tako da svakoj operaciji 
dodijelite posebnu proceduru. Iskoristite procedure za umetanje, izmjenu, dohvacanje i brisanje zapisa. */
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
EXEC InsertStudent @IDStudent = @NoviIDStudenta OUTPUT, 
	@Ime = 'Ana', @Prezime = 'Ani�', @JMBAG = '11224451253'
PRINT @NoviIDStudenta
EXEC GetStudent 1
EXEC UpdateStudent 1, 'Ana', 'Ani� Miri�', '11224451253'
EXEC GetStudent 1
EXEC DeleteStudent 1
EXEC GetStudent 1
GO

/* UPDATE/INSERT/DELETE zajedno. CRUD operacije na tablici Student tako da operacije 
umetanja, izmjene i brisanja obavite u jednoj proceduri, a dohva�anje u drugoj.  */
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