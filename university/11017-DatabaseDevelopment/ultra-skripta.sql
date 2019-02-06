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

-- ISHOD 5 - OKIDACI --
-----------------------
-- Izrada log tablice.
CREATE TABLE Zapisnik (
	IDZapisnik int IDENTITY(1,1) PRIMARY KEY,
	Poruka nvarchar(max),
	Vrijeme datetime DEFAULT getdate()
)
GO

-- Zadatak 1. Napravite okidaè kojim æete svako umetanje retka u tablicu Grad zapisati u tablicu Zapisnik.  Umetnite redak.
CREATE TRIGGER Okidac1 ON Grad AFTER INSERT
AS
INSERT INTO Zapisnik (Poruka) VALUES ('Umetnut redak u Grad!')
GO

INSERT INTO Grad (Naziv, DrzavaID) VALUES ('Grad 1', 1)

SELECT * FROM Zapisnik
GO

-- Zadatak 2. Promijenite okidaè tako da zapie ID i naziv umetnutog grada u Zapisnik. Umetnite redak.
ALTER TRIGGER Okidac1 ON Grad AFTER INSERT
AS
DECLARE @ID int
DECLARE @Naziv nvarchar(50)
SELECT @ID = IDGrad, @Naziv = Naziv FROM inserted

INSERT INTO Zapisnik (Poruka) VALUES ('Umetnut redak u Grad. IDGrad: ' + CAST(@ID as nvarchar(50)) + ', Naziv: ' + @Naziv)
GO

INSERT INTO Grad (Naziv, DrzavaID) VALUES ('Grad 2', 1)

SELECT * FROM Zapisnik
GO

-- Zadatak 3. Promijenite okidaè tako da se vee uz sve dogaðaje i u Zapisnik zapisuje broj redaka u inserted i deleted tablicama. 
-- Umetnite dva nova grada, promijenite im drave i na kraju ih obriite.
ALTER TRIGGER Okidac1 ON Grad AFTER INSERT, UPDATE, DELETE
AS
DECLARE @i int
DECLARE @d int
SELECT @i = COUNT(*) FROM inserted
SELECT @d = COUNT(*) FROM deleted

INSERT INTO Zapisnik (Poruka) VALUES ('inserted: ' + CAST(@i as nvarchar(20)) + ', deleted: ' + CAST(@d as nvarchar(20)))
GO

INSERT INTO Grad (Naziv, DrzavaID) VALUES ('Grad 3', 1)
INSERT INTO Grad (Naziv, DrzavaID) VALUES ('Grad 4', 1)
SELECT * FROM Zapisnik

UPDATE Grad SET DrzavaID = 2 WHERE Naziv LIKE 'Grad%'
SELECT * FROM Zapisnik

DELETE FROM Grad WHERE Naziv LIKE 'Grad%'
SELECT * FROM Zapisnik
GO

-- Zadatak 4. Promijenite okidaè tako da upisuje staru i novu vrijednost promijenjenog naziva grada u Zapisnik. Promijenite naziv jednom gradu.
ALTER TRIGGER Okidac1 ON Grad AFTER UPDATE
AS
DECLARE @old nvarchar(50)
DECLARE @new nvarchar(50)
SELECT @old = Naziv FROM deleted
SELECT @new = Naziv FROM inserted

INSERT INTO Zapisnik (Poruka) VALUES ('Stara: ' + @old + ', nova: ' + @new)
GO

UPDATE Grad SET Naziv = 'Daruvar' WHERE IDGrad = 1
SELECT * FROM Zapisnik
GO

-- Zadatak 5. Onemoguæite okidaè iz prethodnih primjera i promijenite neki redak u tablici. 
-- Ponovno ga omoguæite. Napravite opet promjenu. Uklonite okidaè.
DISABLE TRIGGER Okidac1 ON Grad
GO

UPDATE Grad SET Naziv = 'Bjelovar' WHERE IDGrad = 1
SELECT * FROM Zapisnik
GO

ENABLE TRIGGER Okidac1 ON Grad
GO

UPDATE Grad SET Naziv = 'Vukovar' WHERE IDGrad = 1
SELECT * FROM Zapisnik
GO

DROP TRIGGER Okidac1
GO

/* Zadatak 6. Dodajte novi okidaè na tablicu Grad i veite ga uz sva tri dogaðaja. 
U okidaèu saznajte koji dogaðaj ga je pozvao i tu informaciju upiite u Zapisnik. 
Napravite umetanje, izmjenu i brisanje nekog retka. */
CREATE TRIGGER Okidac2 ON Grad AFTER INSERT, UPDATE, DELETE
AS
IF EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted) BEGIN
	-- INSERT.	
	INSERT INTO Zapisnik (Poruka) VALUES ('Desio se INSERT.')
END
ELSE IF NOT EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) BEGIN
	-- DELETE.
	INSERT INTO Zapisnik (Poruka) VALUES ('Desio se DELETE.')
END
ELSE IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) BEGIN
	-- UPDATE.
	INSERT INTO Zapisnik (Poruka) VALUES ('Desio se UPDATE.')
END
GO

INSERT INTO Grad (Naziv, DrzavaID) VALUES ('Grad 5', 1)
SELECT * FROM Zapisnik

UPDATE Grad SET Naziv = 'Ilok' WHERE IDGrad = 1
SELECT * FROM Zapisnik

DELETE FROM Grad WHERE IDGrad = 76
SELECT * FROM Zapisnik
GO

/* Zadatak 7. Dodajte novi okidaè i veite ga uz UPDATE dogaðaj na tablici Grad. 
Neka okidaè zapie u Zapisnik da se desio dogaðaj samo ako je promijenjen stupac DrzavaID. */
CREATE TRIGGER Okidac3 ON Grad AFTER UPDATE
AS
IF UPDATE(DrzavaID) BEGIN
	INSERT INTO Zapisnik (Poruka) VALUES ('Promijenjen je stupac DrzavaID.')
END
GO

UPDATE Grad SET Naziv = 'ibenik' WHERE IDGrad = 1
SELECT * FROM Zapisnik

UPDATE Grad SET DrzavaID = 3 WHERE IDGrad = 1
SELECT * FROM Zapisnik
GO

/* Zadatak 8. Dodajte 4 nova okidaèa koji u zapisnik ispisuju "Pozdrav iz broja n" nakon umetanja retka. 
Umetnite redak.  Posloite redoslijed okidaèa tako da bude 4, 2, 3, 1. 
Umetnite redak. Vratite originalni redoslijed. Umetnite redak. */
CREATE TRIGGER Okidac1 ON Grad AFTER INSERT AS
INSERT INTO Zapisnik (Poruka) VALUES ('Pozdrav iz broja 1')
GO

CREATE TRIGGER Okidac2 ON Grad AFTER INSERT AS
INSERT INTO Zapisnik (Poruka) VALUES ('Pozdrav iz broja 2')
GO

CREATE TRIGGER Okidac3 ON Grad AFTER INSERT AS
INSERT INTO Zapisnik (Poruka) VALUES ('Pozdrav iz broja 3')
GO

CREATE TRIGGER Okidac4 ON Grad AFTER INSERT AS
INSERT INTO Zapisnik (Poruka) VALUES ('Pozdrav iz broja 4')
GO

INSERT INTO Grad (Naziv, DrzavaID) VALUES ('Grad 6', 1)
SELECT * FROM Zapisnik
GO

EXEC sp_settriggerorder 'Okidac4', 'FIRST', 'INSERT'
EXEC sp_settriggerorder 'Okidac1', 'LAST', 'INSERT'
GO

INSERT INTO Grad (Naziv, DrzavaID) VALUES ('Grad 7', 1)
SELECT * FROM Zapisnik
GO

EXEC sp_settriggerorder 'Okidac4', 'NONE', 'INSERT'
EXEC sp_settriggerorder 'Okidac1', 'NONE', 'INSERT'
GO

INSERT INTO Grad (Naziv, DrzavaID) VALUES ('Grad 8', 1)
SELECT * FROM Zapisnik
GO
 
/* Zadatak 9. Napravite tablice Tbl1 i Tbl2 s proizvoljnim stupcima. 
Na Tbl1 napravite okidaè vezan uz INSERT koji umeæe retke u Tbl2 i u Zapisnik. 
Na Tbl2 napravite okidaè vezan uz INSERT koji umeæe retke u Tbl1 i u Zapisnik. 
Umetnite jedan redak u Tbl1.  */
CREATE TABLE Tbl1 (
	Stupac1 int PRIMARY KEY IDENTITY,
	Stupac2 nvarchar(50)
)
CREATE TABLE Tbl2 (
	Stupac1 int PRIMARY KEY IDENTITY,
	Stupac2 nvarchar(50)
)
GO

CREATE TRIGGER Okidac1 ON Tbl1 AFTER INSERT 
AS
INSERT INTO Zapisnik (Poruka) VALUES ('Okidaè 1 na tablici 1')
INSERT INTO Tbl2 VALUES ('Upis u drugu tablicu')
GO

CREATE TRIGGER Okidac2 ON Tbl2 AFTER INSERT 
AS
INSERT INTO Zapisnik (Poruka) VALUES ('Okidaè 2 na tablici 2')
INSERT INTO Tbl1 VALUES ('Upis u prvu tablicu')
GO

INSERT INTO Tbl1 VALUES ('Upis u prvu tablicu')
SELECT * FROM Zapisnik
GO

-- I6 - TIPOVI --
-----------------
/* Zadatak 1. RAD SA STRINGOVIMA (1)
Napisati funkciju koja prima string i vraæa novi string sastavljen od: druga polovica stringa + prva polovica stringa. 
Ako ulazni string ima neparan broj znakova, neka u prvoj polovici bude manji broj znakova 
(primjerice, za "Slon" treba vratiti "onSl", za "Mirko" treba "rkoMi"). */
CREATE FUNCTION dbo.Obrni (
	@s nvarchar(max)
)
RETURNS nvarchar(max)
AS
BEGIN
	DECLARE @d1 nvarchar(max)
	DECLARE @d2 nvarchar(max)
	DECLARE @duljina1 int
	DECLARE @duljina2 int

	SET @duljina1 = LEN(@s) / 2
	SET @duljina2 = LEN(@s) - @duljina1
	
	SET @d1 = SUBSTRING(@s, 1, @duljina1)
	SET @d2 = SUBSTRING(@s, @duljina1 + 1, @duljina2)

	RETURN @d2 + @d1
END
GO
-- Pozvati funkciju s nekim parametrom i ispisati rezultat.
PRINT dbo.Obrni('Slon')
PRINT dbo.Obrni('Mirko')
-- Ispisati obrnuti naziv svakog proizvoda iz tablice Proizvod.
SELECT dbo.Obrni(Naziv) FROM Proizvod
GO

/* Zadatak 2. Napisati funkciju koja prima string i koja vraæa broj pojavljivanja slova 'a' u tom stringu. */
CREATE FUNCTION dbo.BrojSlovaA (
	@s nvarchar(max)
)
RETURNS int
AS
BEGIN
	DECLARE @curr int
	DECLARE @next int
	DECLARE @broj int

	SET @curr = 1
	SET @next = 1
	SET @broj = 0
	WHILE @next > 0 BEGIN
		SET @next = CHARINDEX('a', @s, @curr)
		IF @next > 0
			SET @broj = @broj + 1

		SET @curr = @next + 1
	END
	RETURN @broj
END
GO
-- Pozvati funkciju s nekim parametrom i ispisati rezultat.
PRINT dbo.BrojSlovaA('Juro')
-- Dohvatiti sve proizvode iz i pokraj svakog ispisati broj pojavljivanja slova 'a' u nazivu.
SELECT *, dbo.BrojSlovaA(Naziv) AS BrojSlovaA FROM Proizvod
GO

/* Zadatak 3. Napisati funkciju koja prima string i koja vraæa broj samoglasnika u tom stringu. */
CREATE FUNCTION dbo.BrojSamoglasnika (
	@s nvarchar(max)
)
RETURNS int
AS
BEGIN
	DECLARE @i int
	DECLARE @broj int
	DECLARE @znak char(1)

	SET @i = 1
	SET @broj = 0
	WHILE @i <= LEN(@s) BEGIN
		SET @znak = SUBSTRING(@s, @i, 1)
		IF @znak IN ('a', 'e', 'i', 'o', 'u')
			SET @broj = @broj + 1

		SET @i = @i + 1
	END
	RETURN @broj
END
GO
-- Pozvati funkciju s nekim parametrom i ispisati rezultat.
PRINT dbo.BrojSamoglasnika('Juro')
-- Dohvatiti sve proizvode iz i pokraj svakog ispisati broj samoglasnika u nazivu.
SELECT *, dbo.BrojSamoglasnika(Naziv) AS BrojSamoglasnika FROM Proizvod
GO

/* Zadatak 4. Napisati proceduru koja prima XML dokument oblika:
<Gradovi>
	<Grad>Karlovac</Grad>
</Gradovi>
Neka procedura vrati tablicu s nazivima svih gradova. */
CREATE PROC IspisiNazive
	@gradovi xml
AS
SELECT
	Tablica.Stupac.value('.', 'nvarchar(50)') AS Grad
FROM @gradovi.nodes('/Gradovi/Grad') AS Tablica(Stupac)
GO
-- Pozvati proceduru  s nekim parametrom.
EXEC IspisiNazive '<Gradovi><Grad>Karlovac</Grad><Grad>Sisak</Grad><Grad>Kutina</Grad></Gradovi>'
GO
 
/* Zadatak 5. Proiriti prethodni XML dokument tako da svaki grad sadrava atribut "PostanskiBroj". 
Promijeniti proceduru tako da uz naziv grada ispisuje i potanski broj. */
ALTER PROC IspisiNazive
	@gradovi xml
AS
SELECT
	Tablica.Stupac.value('.', 'nvarchar(50)') AS Grad,
	Tablica.Stupac.value('@Pbr', 'nvarchar(5)') AS Pbr
FROM @gradovi.nodes('/Gradovi/Grad') AS Tablica(Stupac)
GO
-- Pozvati proceduru  s nekim parametrom.
EXEC IspisiNazive '<Gradovi><Grad Pbr="10000">Zagreb</Grad><Grad Pbr="31000">Osijek</Grad></Gradovi>'
GO

/* Zadatak 6. Napisati proceduru koja prima XML dokument oblika:
<Kupci>
	<Kupac>
		<Ime>Mirko</Ime>
		<Prezime>Mirkiæ</Prezime>
		<Grad>Osijek</Grad>
	</Kupac>
</Kupci>
Neka procedura vrati dva skupa redaka:
- Prezimena svih kupaca poslagana abecednim redom
- Nazive gradova. Ako ima vie kupaca iz istog grada, grad treba ispisati samo jednom. */
CREATE PROC Zad6
	@dok xml
AS
SELECT
	Tablica.Stupac.value('.', 'nvarchar(50)') AS Prezime
FROM @dok.nodes('/Kupci/Kupac/Prezime') AS Tablica(Stupac)
ORDER BY Prezime

SELECT DISTINCT
	Tablica.Stupac.value('.', 'nvarchar(50)') AS Grad
FROM @dok.nodes('/Kupci/Kupac/Grad') AS Tablica(Stupac)
GO
-- Pozvati proceduru  s nekim parametrom. Provjera da li vraæa dva skupa redaka.
EXEC Zad6 '
	<Kupci>
		<Kupac>
			<Ime>Mirko</Ime>
			<Prezime>Mirkiæ</Prezime>
			<Grad>Osijek</Grad>
		</Kupac>
		<Kupac>
			<Ime>Ana</Ime>
			<Prezime>Aniæ</Prezime>
			<Grad>Osijek</Grad>
		</Kupac>
	</Kupci>'
GO

/* Zadatak 7 Napisati proceduru koja prima XML dokument oblika:
<Osobe>
	<Osoba ID="1">Ana Aniæ</Osoba>
	<Osoba ID="2">Mira Miriæ</Osoba>
</Osobe>
Neka procedura vrati imena i prezimena te ID-eve svih osoba. 
Svaki ID treba nadopuniti s nulama s lijeve strane na duljinu od 5 znakova 
(Primjerice, za ID = 1 treba ispisati 00001, za ID = 176 treba ispisati 00176) */
CREATE PROC Zad7
	@dok xml
AS
SELECT
	Tablica.Stupac.value('.', 'nvarchar(50)') AS ImePrezime,
	CASE  
		WHEN LEN(Tablica.Stupac.value('@ID', 'nvarchar(50)')) = 1 THEN '0000' + Tablica.Stupac.value('@ID', 'nvarchar(50)')
		WHEN LEN(Tablica.Stupac.value('@ID', 'nvarchar(50)')) = 2 THEN  '000' + Tablica.Stupac.value('@ID', 'nvarchar(50)')
		WHEN LEN(Tablica.Stupac.value('@ID', 'nvarchar(50)')) = 3 THEN   '00' + Tablica.Stupac.value('@ID', 'nvarchar(50)')
		WHEN LEN(Tablica.Stupac.value('@ID', 'nvarchar(50)')) = 4 THEN    '0' + Tablica.Stupac.value('@ID', 'nvarchar(50)')
		WHEN LEN(Tablica.Stupac.value('@ID', 'nvarchar(50)')) = 5 THEN          Tablica.Stupac.value('@ID', 'nvarchar(50)')
	END AS ID
FROM @dok.nodes('/Osobe/Osoba') AS Tablica(Stupac)
GO
-- Pozvati proceduru  s nekim parametrom. 
EXEC zad7
	'<Osobe>
		<Osoba ID="1">Ana Aniæ</Osoba>
		<Osoba ID="35">Maja Majiæ</Osoba>
		<Osoba ID="158">Tanja Tanjiæ</Osoba>
		<Osoba ID="85002">Vera Veriæ</Osoba>
	</Osobe>'
GO

/* Zadatak 8. KORISNIÈKI DEFINIRANI TABLIÈNI TIPOVI
Napiite proceduru koja dohvaæa sve kupce èiji ID-evi su proslijeðeni pomoæu korisnièki definiranog tabliènog tipa. */
-- Kreiranje korisnièki definiranog tipa
CREATE TYPE MyKupac AS TABLE ( IDKupac int )
GO
-- Stvaranje procedure
CREATE PROC zad8
	@Kupci MyKupac READONLY
AS
SELECT * FROM dbo.Kupac WHERE IDKupac IN (SELECT * FROM @Kupci)
GO
-- Pozivanje procedure.
DECLARE @t MyKupac
INSERT INTO @t VALUES (1)
INSERT INTO @t VALUES (2)
INSERT INTO @t VALUES (3)
EXEC zad8 @t
GO

/* Zadatak 9. Napiite proceduru koja umeæe drave proslijeðene pomoæu korisnièki definiranog tabliènog tipa. Pozovite proceduru. */
CREATE TYPE MyDrzava AS TABLE ( Naziv nvarchar(50) )
GO
-- Stvaranje procedure
CREATE PROC zad9
	@Drzave MyDrzava READONLY
AS
INSERT INTO Drzava
SELECT * FROM @Drzave
GO
-- Pozivanje procedure.
DECLARE @t MyDrzava
INSERT INTO @t VALUES ('Indija')
INSERT INTO @t VALUES ('Pakistan')
INSERT INTO @t VALUES ('Banglade')
EXEC zad9 @t
GO
select * from drzava

/*Zadatak 10 Napiite proceduru koja umeæe potkategorije proslijeðene pomoæu korisnièki 
definiranog tabliènog tipa. Umetnuti samo onu potkategoriju koja ne postoji u tablici 
(ako postoji nemojte umetati ponovno). Pozovite proceduru.*/
-- Kreiranje korisnièki definiranog tipa
CREATE TYPE MyPotkategorija AS TABLE ( KategorijaID int, Naziv nvarchar(50) )
GO
-- Stvaranje procedure
CREATE PROC zad10
	@Potk MyPotkategorija READONLY
AS
INSERT INTO Potkategorija
SELECT KategorijaID, Naziv FROM @Potk WHERE Naziv NOT IN (SELECT Naziv FROM Potkategorija)
GO
-- Pozivanje procedure.
DECLARE @t MyPotkategorija
INSERT INTO @t VALUES (1, 'Mountain Bikes')
INSERT INTO @t VALUES (1, 'Ninja Bikes')
EXEC zad10 @t
GO

select * from Potkategorija

-- I7 - TRANSAKCIJE --
----------------------
/* Napravite tablicu Osoba s IDOsoba (PK i IDENTITY), Ime i Prezime. */
CREATE TABLE Osoba (
    IDOsoba int PRIMARY KEY IDENTITY,
    Ime nvarchar(50),
    Prezime nvarchar(50)
)
GO

/* Zadatak 1. U transakciji umetnite 3 zapisa u Osoba i na kraju odustanite od transakcije.  */
SELECT * FROM Osoba

BEGIN TRAN
	INSERT INTO Osoba VALUES ('Miro', 'Miriæ')
	INSERT INTO Osoba VALUES ('Ana', 'Aniæ')
	INSERT INTO Osoba VALUES ('Iva', 'Iviæ')
	SELECT * FROM Osoba
ROLLBACK TRAN

SELECT * FROM Osoba
GO

/* Zadatak 2 U transakciji umetnite 3 zapisa u Osoba i na kraju potvrdite transakciju. */
SELECT * FROM Osoba

BEGIN TRAN
	INSERT INTO Osoba VALUES ('Miro', 'Miriæ')
	INSERT INTO Osoba VALUES ('Ana', 'Aniæ')
	INSERT INTO Osoba VALUES ('Iva', 'Iviæ')
	SELECT * FROM Osoba
COMMIT TRAN

SELECT * FROM Osoba
GO
 
/*Zadatak 3. U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu toèku. 
Umetnite jo 1 zapis.  Na kraju odustanite od transakcije. */
SELECT * FROM Osoba

DELETE Osoba

BEGIN TRAN
	INSERT INTO Osoba VALUES ('Miro', 'Miriæ')
	SAVE TRAN cp1
	INSERT INTO Osoba VALUES ('Ana', 'Aniæ')
	SELECT * FROM Osoba
ROLLBACK TRAN

SELECT * FROM Osoba
GO

/*Zadatak 4. U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu toèku. 
Umetnite jo 1 zapis.  Na kraju potvrdite transakciju. */
SELECT * FROM Osoba

DELETE Osoba

BEGIN TRAN
	INSERT INTO Osoba VALUES ('Miro', 'Miriæ')
	SAVE TRAN cp1
	INSERT INTO Osoba VALUES ('Ana', 'Aniæ')
	SELECT * FROM Osoba
COMMIT TRAN

SELECT * FROM Osoba
GO

/*Zadatak 5. U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu toèku. 
Umetnite jo 1 zapis i postavite kontrolnu toèku. Na kraju odustanite od transakcije. */
SELECT * FROM Osoba

DELETE Osoba

BEGIN TRAN
	INSERT INTO Osoba VALUES ('Miro', 'Miriæ')
	SAVE TRAN cp1
	INSERT INTO Osoba VALUES ('Ana', 'Aniæ')
	SAVE TRAN cp2
	SELECT * FROM Osoba
ROLLBACK TRAN

SELECT * FROM Osoba
GO

/* Zadatak 6. U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu toèku. 
Umetnite jo 1 zapis i postavite kontrolnu toèku. Na kraju potvrdite transakciju. */
SELECT * FROM Osoba

DELETE Osoba

BEGIN TRAN
	INSERT INTO Osoba VALUES ('Miro', 'Miriæ')
	SAVE TRAN cp1
	INSERT INTO Osoba VALUES ('Ana', 'Aniæ')
	SAVE TRAN cp2
	SELECT * FROM Osoba
COMMIT TRAN

SELECT * FROM Osoba
GO

/* Zadatak 7. U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu toèku. 
Umetnite jo 1 zapis i vratite se na kontrolnu toèku. Na kraju odustanite od transakcije.*/
SELECT * FROM Osoba

DELETE Osoba

BEGIN TRAN
	INSERT INTO Osoba VALUES ('Miro', 'Miriæ')
	SAVE TRAN cp1
	INSERT INTO Osoba VALUES ('Ana', 'Aniæ')
	SELECT * FROM Osoba
	ROLLBACK TRAN cp1
	SELECT * FROM Osoba
ROLLBACK TRAN

SELECT * FROM Osoba
GO

/* Zadatak 8. U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu toèku. 
Umetnite jo 1 zapis i vratite se na kontrolnu toèku. Na kraju potvrdite transakciju. */
SELECT * FROM Osoba

BEGIN TRAN
	INSERT INTO Osoba VALUES ('Miro', 'Miriæ')
	SAVE TRAN cp1
	INSERT INTO Osoba VALUES ('Ana', 'Aniæ')
	SELECT * FROM Osoba
	ROLLBACK TRAN cp1
	SELECT * FROM Osoba
COMMIT TRAN

SELECT * FROM Osoba
GO

DELETE Osoba

/* Zadatak 9. Napiite proceduru za brisanje drave. Neka procedura prima 1 parametar, IDDrzava.  */
CREATE PROC p9
	@IDDrzava int
AS
DELETE FROM Drzava WHERE IDDrzava = @IDDrzava
GO
-- Transakciju vodite izvan procedure. Ispiite uspjeh ili neuspjeh. 
-- Pozovite 3 puta proceduru s vrijednostima parametara jednakim 50, 51 i 52. 
BEGIN TRY
	BEGIN TRAN
		EXEC p9 50
		EXEC p9 51
		EXEC p9 52
	COMMIT TRAN
	PRINT 'Brisanje uspjeno'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'Greka pri brisanju'
END CATCH
GO

/* Zadatak 10. Napiite proceduru s 3 parametra za brisanje triju drava. 
Transakciju vodite unutar procedure. Ispiite uspjeh ili neuspjeh. */
create PROC p10
	@IDDrzava1 int,
	@IDDrzava2 int,
	@IDDrzava3 int
AS
BEGIN TRY
	BEGIN TRAN
		DELETE FROM Drzava WHERE IDDrzava = @IDDrzava1
		DELETE FROM Drzava WHERE IDDrzava = @IDDrzava2
		DELETE FROM Drzava WHERE IDDrzava = @IDDrzava3
	COMMIT TRAN
	PRINT 'Brisanje uspjeno'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'Greka pri brisanju: '  + ERROR_MESSAGE()
END CATCH
GO
-- Pozovite proceduru s vrijednostima 50, 51 i 52. 
EXEC p10 50, 51, 52
-- Pozovite proceduru s vrijednostima 50, 51 i 1.
EXEC p10 50, 51, 1
GO

/* Zadatak 11. Unutar vanjske transakcije pozovite prethodnu proceduru s vrijednostima 50, 51 i 52. 
Nakon toga odustanite od vanjske transakcije. Ispiite uspjeh ili neuspjeh. */
BEGIN TRY
	BEGIN TRAN
		EXEC p10 50, 51, 52
	ROLLBACK TRAN
	PRINT 'Sve OK, ali odustajem od transakcije'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'Desila se greka pa odustajem od transakcije'
END CATCH 
GO
 
/* Zadatak 12. Osmislite XML za unos raèuna s tri stavke.  
Napiite proceduru za unos raèuna i unutar transakcije odradite umetanje raèuna i stavki. */
CREATE PROC p12
	@Podaci xml
AS
BEGIN TRY
	BEGIN TRAN
		DECLARE @ID int
		INSERT INTO dbo.Racun (DatumIzdavanja, BrojRacuna, KupacID, KomercijalistID, KreditnaKarticaID)
		SELECT
			T.S.value('@Datum', 'datetime'),
			T.S.value('@Broj', 'nvarchar(50)'),
			T.S.value('@KupacID', 'int'),
			T.S.value('@KomercijalistID', 'int'),
			T.S.value('@KreditnaKarticaID', 'int')
		FROM @Podaci.nodes('/Podaci/Racun') as T(S)
		PRINT 'Upisao raèun'
		
		SET @ID = SCOPE_IDENTITY()
		
		INSERT INTO dbo.Stavka (RacunID, Kolicina, ProizvodID, CijenaPoKomadu, PopustUPostocima, UkupnaCijena)
		SELECT
			@ID,
			T.S.value('@Kolicina', 'int'),
			T.S.value('@ProizvodID', 'int'),
			T.S.value('@CijenaPoKomadu', 'money'),
			T.S.value('@PopustPosto', 'money'),
			T.S.value('@UkupnaCijena', 'money')
		FROM @Podaci.nodes('/Podaci/Racun/Stavka') as T(S)
		PRINT 'Upisao stavke'
		
	COMMIT TRAN
	PRINT 'Umetanje uspjeno!'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'Desila se greka: ' + ERROR_MESSAGE()
END CATCH
GO
-- Osmislite XML za unos raèuna s tri stavke. 
DECLARE @Podaci xml = '
	<Podaci>
		<Racun Datum="20110103" Broj="SO112233" KupacID="281" KomercijalistID="280" KreditnaKarticaID="806">
			<Stavka Kolicina="1" ProizvodID="1" CijenaPoKomadu="49.99" PopustPosto="0" UkupnaCijena="49.99" />
			<Stavka Kolicina="1" ProizvodID="2" CijenaPoKomadu="99.99" PopustPosto="0" UkupnaCijena="99.99" />
			<Stavka Kolicina="1" ProizvodID="999" CijenaPoKomadu="199.99" PopustPosto="0" UkupnaCijena="199.99" />
		</Racun>
	</Podaci>'
--Pozovite proceduru.
EXEC p12 @Podaci
GO

/* N A P O M E N A
Kod rjesavanja zadataka s transakcijama potrebne su dvije SQL skripte, svaka u 
svojoj konekciji te svaka SQL naredba treba sadrzavati redni broj izvrsavanja*/

/*Zadatak 1. IZOLACIJSKI NIVOI (1) - SKRIPTA 1 .Demonstrirajte problem prljavog 
èitanja na tablici Drzava na retku s IDDrzava = 3. Napiite gdje se desilo prljavo èitanje. */
-- TRANSAKCIJA 1. KORACI KOJI NEDOSTAJU IZVRAVAJU SE U DRUGOJ SKRIPTI
-- 1. 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 3.
BEGIN TRAN
-- 5.
UPDATE Drzava SET Naziv = 'BIH' WHERE IDDrzava = 3
-- 7.
ROLLBACK TRAN
/* Zadatak 1. IZOLACIJSKI NIVOI (1) - SKRIPTA 2 */
-- TRANSAKCIJA 2. KORACI KOJI NEDOSTAJU IZVRAVAJU SE U PRVOJ SKRIPTI
-- 2.
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
-- 4. 
BEGIN TRAN
-- 6.
SELECT * FROM Drzava WHERE IDDrzava = 3 -- Prljavo èitanje.
-- 8.
ROLLBACK TRAN


/*Zadatak 2. IZOLACIJSKI NIVOI (1) - SKRIPTA 1
Demonstrirajte rjeenje problem prljavog èitanja na tablici Drzava na retku s IDDrzava = 3. 
Napiite gdje bi se desilo prljavo èitanje i kako ste to sprijeèili. */
-- 1. 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 3.
BEGIN TRAN
-- 5.
UPDATE Drzava SET Naziv = 'BIH' WHERE IDDrzava = 3
-- 7.
ROLLBACK TRAN
/* Zadatak 2. IZOLACIJSKI NIVOI (1) - SKRIPTA 2 */
-- 2.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED -- Prljavo èitanje sprjeèavamo postavljanjem bilo kojeg izolacijskog nivoa iznad READ UNCOMMITTED.
-- 4. 
BEGIN TRAN
-- 6.
SELECT * FROM Drzava WHERE IDDrzava = 3 -- Blokiranje umjesto prljavog èitanja.
-- 8.
ROLLBACK TRAN


/* Zadatak 3. IZOLACIJSKI NIVOI (2) - SKRIPTA 1
Demonstrirajte problem neponovljivog èitanja na tablici Drzava na retku s IDDrzava = 3. 
Napiite gdje se desilo neponovljivo èitanje. */
-- 1. 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 3.
BEGIN TRAN
-- 5.
SELECT * FROM Drzava WHERE IDDrzava = 3 -- Neponovljivo èitanje.
-- 8.
SELECT * FROM Drzava WHERE IDDrzava = 3
-- 9.
ROLLBACK TRAN
/* Zadatak 3 IZOLACIJSKI NIVOI (2) - SKRIPTA 2 */
-- 2.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 4. 
BEGIN TRAN
-- 6.
UPDATE Drzava SET Naziv = 'Bosna i Hercegovina' WHERE IDDrzava = 3
-- 7.
COMMIT TRAN


/*Zadatak 4. IZOLACIJSKI NIVOI (2) - SKRIPTA 1
Demonstrirajte rjeenje problema neponovljivog èitanja na tablici Drzava na retku s IDDrzava = 3. 
Napiite gdje bi se desilo neponovljivo èitanje. */
-- 1. 
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ -- Neponovljivo èitanje sprjeèavamo postavljanjem bilo kojeg izolacijskog nivoa iznad READ COMMITTED.
-- 3.
BEGIN TRAN
-- 5.
SELECT * FROM Drzava WHERE IDDrzava = 1 -- Tu bi se desilo neponovljivo èitanje, ali se neæe desiti jer sam sada postavio S lokot i drim ga do kraja transakcije.
-- 7.
SELECT * FROM Drzava WHERE IDDrzava = 1
-- 8.
ROLLBACK TRAN
/* Zadatak 4. IZOLACIJSKI NIVOI (2) - SKRIPTA 2 */
-- 2.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 4. 
BEGIN TRAN
-- 6.
UPDATE Drzava SET Naziv = 'Hrv' WHERE IDDrzava = 1 -- Blokiran zbog S lokota.
-- 9.
ROLLBACK TRAN


/*Zadatak 5. IZOLACIJSKI NIVOI (2) - SKRIPTA 1 Demonstrirajte problem fantoma na tablici Drzava 
na recima s nazivima koji zapoèinju s 'H'. Napiite gdje se pojavljuju fantomi. */
-- 1. 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 3.
BEGIN TRAN
-- 5.
SELECT * FROM Drzava WHERE Naziv LIKE 'H%' -- vraæa 1 redak.
-- 8.
SELECT * FROM Drzava WHERE Naziv LIKE 'H%' -- vraæa 2 retka, drugi redak je fantom.
-- 9.
ROLLBACK TRAN
/* Zadatak 5. IZOLACIJSKI NIVOI (2) - SKRIPTA 2 */
-- 2.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 4. 
BEGIN TRAN
-- 6.
INSERT INTO Drzava (Naziv) VALUES ('Honduras')
-- 7.
COMMIT TRAN


/* Zadatak 6.
IZOLACIJSKI NIVOI (2) - SKRIPTA 1 Demonstrirajte rjeenje problema fantoma na tablici Drzava 
na recima s nazivima koji zapoèinju s 'H'. Napiite gdje bi se pojavili fantomi. */
-- 1. 
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE -- Fantome sprjeèavamo postavljanjem izolacijskog nivoa na SERIALIZABLE.
-- 3.
BEGIN TRAN
-- 5.
SELECT * FROM Drzava WHERE Naziv LIKE 'H%' -- vraæa 1 redak i postavlja S lokot na sve retke koji zapoèinju s H kojeg æe drati do kraja transakcije.
-- 7.
SELECT * FROM Drzava WHERE Naziv LIKE 'H%' -- vraæa 1 redak.
-- 8.
ROLLBACK TRAN
/* Zadatak 6  IZOLACIJSKI NIVOI (2) - SKRIPTA 2 */
-- 2.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 4. 
BEGIN TRAN
-- 6.
INSERT INTO Drzava (Naziv) VALUES ('Haiti') -- Blokiran zbog S lokota. Da nije, umetnuo bi fantoma.
-- 9.
ROLLBACK TRAN