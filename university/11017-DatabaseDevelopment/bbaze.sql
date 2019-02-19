-- I3 - rad s diskom --
----------------------
SELECT IDTablica, data1, data2 FROM Tablica Where data2 LIKE 'nesto' AND dataID = nesto 
create nonclustered index on tablename(dataID) include (data1,data2)

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


-- I4 - varijable i procedure --
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


--ISHOD 8
/* 1. dio */
create database OLAPdb
go
use OLAPdb
go

CREATE TABLE Sales ( Country varchar(50), Region varchar(50), Sales int );
INSERT INTO sales VALUES (N'Canada', N'Alberta', 100);
INSERT INTO sales VALUES (N'Canada', N'British Columbia', 200);
INSERT INTO sales VALUES (N'Canada', N'British Columbia', 300);
INSERT INTO sales VALUES (N'United States', N'Montana', 100);
GO

select * from sales

-- Osnovno koritenje
select Country, Region, SUM(sales) AS TotalSales
from Sales
group by Country, Region

-- Izraèun grand totala.
select SUM(sales) AS GrandTotal
from Sales

select SUM(sales) AS GrandTotal
from Sales
group by ()

-- GROUP BY ROLLUP
select Country, Region, SUM(Sales) AS TotalSales
from Sales
group by rollup (Country, Region)

-- GROUP BY CUBE
select Country, Region, SUM(Sales) AS TotalSales
from Sales
group by cube (Country, Region)

-- GROUP BY GROUPING SETS ()
select Country, Region, SUM(Sales) AS TotalSales
from Sales
group by grouping sets (Country, Region, ())



-- ZADACI.
use AdventureWorksOBP
go

-- 1. Koristeći ROLLUP, dohvatite broj izdanih računa za kupce prezimena Adams i Simmons te broj izdanih
-- računa za svaku jedinstvenu kombinaciju imena i prezimena tih kupaca. Koliko je ukupno računa izdano Adamsima?
select
	Prezime, Ime, COUNT(*) as BrojIzdanihRacuna
from Racun as r
inner join Kupac as k on r.KupacID = k.IDKupac
where k.Prezime in ('Adams', 'Simmons')
group by rollup (k.Prezime, k.Ime)

-- 2. Koristeći ROLLUP, dohvatite broj izdanih računa za kupce koji se zovu Rose i Lydia te broj izdanih
-- računa za svaku jedinstvenu kombinaciju imena i prezimena tih kupaca. Koliko je ukupno računa izdano Lydiama?
select
	Prezime, Ime, COUNT(*) as BrojIzdanihRacuna
from Racun as r
inner join Kupac as k on r.KupacID = k.IDKupac
where k.Ime in ('Rose', 'Lydia')
group by rollup (k.Ime, k.Prezime)

-- 3. Koristeći CUBE, dohvatite količinu izdanih računa za sve komercijaliste čije prezime započinje slovom A.
-- Dodatno, neka rezultati uključuju i količinu po svakom imenu, svakom prezimenu te grand total.
select
	kom.Ime, kom.Prezime, COUNT(*) as BrojIzdanihRacuna
from Racun as r
inner join Komercijalist as kom on r.KomercijalistID = kom.IDKomercijalist
where kom.Prezime like 'A%'
group by cube (kom.Ime, kom.Prezime)

-- 4. Koristeći GROUPING SETS, dohvatite zaradu za svaki naziv proizvoda, za svaku boju proizvoda te grand
-- total. Nedefinirane boje nemojte uključiti u rezultat.
select
	p.Naziv, p.Boja, SUM(s.UkupnaCijena) as Zarada
from Stavka as s
inner join Proizvod as p on s.ProizvodID = p.IDProizvod
where p.Boja is not null
group by GROUPING sets ((p.Naziv), (p.Boja), ())

-- 5. Jednim upitom dohvatite sljedeće podatke: zaradu po boji proizvoda, te grand total. Nedefinirane boje
-- nemojte uključiti u rezultat.
select
	p.Boja, SUM(s.UkupnaCijena) as Zarada
from Stavka as s
inner join Proizvod as p on s.ProizvodID = p.IDProizvod
where p.Boja is not null
group by GROUPING sets ((p.Boja), ())

-- 6. Jednim upitom dohvatite sljedeće podatke: zaradu po državi, po gradu u državi te grand total.
select
	d.Naziv as Drzava, g.Naziv as Grad, SUM(s.UkupnaCijena) as Zarada
from Stavka as s
inner join Racun as r on r.IDRacun = s.RacunID
inner join Kupac as k on k.IDKupac = r.KupacID
left join Grad as g on g.IDGrad = k.GradID
left join Drzava as d on d.IDDrzava = g.DrzavaID
group by rollup (d.Naziv, g.Naziv)


/* 1. dio */
CREATE TABLE Sales ( Country varchar(50), Region varchar(50), Sales int );
INSERT INTO sales VALUES (N'Canada', N'Alberta', 100);
INSERT INTO sales VALUES (N'Canada', N'British Columbia', 200);
INSERT INTO sales VALUES (N'Canada', N'British Columbia', 300);
INSERT INTO sales VALUES (N'United States', N'Montana', 100);
GO

select * from Sales

-- Primjer funkcija rangiranja
select 
	Country, 
	Region,
	Sales,
	ROW_NUMBER() over (order by Sales) as Rn,
	RANK() over (order by Sales) as R,
	DENSE_RANK() over (order by Sales) as Dr,
	NTILE(2) over (order by Sales) as N
from Sales
order by Country, Region

-- Primjer funkcija rangiranja s particioniranjem
select 
	Country, 
	Region,
	Sales,
	ROW_NUMBER() over (partition by Country order by Sales) as Rn
from Sales

-- ZADACI.

-- 1. Ispišite sve kupce poslagane prema prezimenu pa prema imenu. Kraj svakog kupca ispišite koji je
-- njegov redni broj prema istom kriteriju.
select
	*,
	ROW_NUMBER() over (order by Prezime, Ime) as Rbr
from Kupac
order by Prezime, Ime

-- 2. Ispišite sve kupce poslagane prema gradu pa prema prezimenu pa prema imenu. Kraj svakog kupca
-- ispišite koji je njegov redni broj prema prezimenu i imenu, ali za svaki grad posebno.
select
	*,
	ROW_NUMBER() over (partition by GradID order by Prezime, Ime) as Rbr
from Kupac
order by GradID, Prezime, Ime

-- 3. Ispišite sve stavke i uz svaku stavku ispišite njeno mjesto na rang listi. Stavka koja ima najveću količinu
-- treba biti prva na rang listi, a ona s najmanjom količinom treba biti zadnja.
select 
	*,
	RANK() over (order by Kolicina desc) as MjestoNaRangListi
from Stavka
order by Kolicina desc

-- 4. Ispišite sve račune za komercijalista 284. Podijelite te račune u skupine po 3 računa prema starosti, a
-- zatim prema broju računa. Neka svi računi iz prve skupine imaju broj 1, iz sljedeće skupine neka imaju broj 2, itd.
select
	*,
	NTILE(13) over (order by DatumIzdavanja, BrojRacuna) as Skupina
from Racun
where KomercijalistID = 284
order by DatumIzdavanja

-- Primjer agregatnih funkcija
select 
	*,
	SUM(s.Kolicina) over ()
from Racun as r
inner join Stavka s on s.RacunID = r.IDRacun
order by r.DatumIzdavanja, r.IDRacun

select 
	*,
	SUM(s.Kolicina) over (order by DatumIzdavanja)
from Racun as r
inner join Stavka s on s.RacunID = r.IDRacun
order by r.DatumIzdavanja, r.IDRacun

select 
	*,
	SUM(s.Kolicina) over (partition by year(DatumIzdavanja) order by DatumIzdavanja)
from Racun as r
inner join Stavka s on s.RacunID = r.IDRacun
order by r.DatumIzdavanja, r.IDRacun

-- Primjer running totala.
select 
    Country, 
    Region,
    Sales,
    AVG(Sales) over (order by Region) as a1,
    SUM(Sales) over (order by Region) as a2
from Sales

-- ZADACI.

-- 5. Ispišite sve stavke, a uz svaku stavite i datum izdavanja računa kojemu pripada. Uz svaki redak ispišite i
-- running total ukupne zarade. Resetirajte vrijednost svake godine.
select 
	s.*,
	r.DatumIzdavanja,
	SUM(s.UkupnaCijena) over (partition by year(DatumIzdavanja) order by DatumIzdavanja) as RunningSum
from Racun as r
inner join Stavka s on s.RacunID = r.IDRacun
order by r.DatumIzdavanja, r.IDRacun

-- 6. Ispišite sve proizvode i pokraj svakog ispišite koliko ima proizvoda njegove boje.
select
	*,
	COUNT(*) over (partition by Boja) as ProizvodaBoje
from Proizvod

-- 7. Ispišite sve proizvode. Pokraj svakog ispišite koliko je njegova cijena manja od najskupljeg proizvoda.
-- Uzmite u obzira samo proizvode koji imaju cijenu veću od 0.
select
	*,
	(MAX(CijenaBezPDV) over ()) - CijenaBezPDV as Razlika
from Proizvod
where CijenaBezPDV > 0
order by CijenaBezPDV

-- 8. Ispišite sve proizvode s cijenom većom od 0, od najjeftinijeg prema najskupljem. Uz svaki proizvod
-- ispišite koliko je skuplji od prethodnog.
select 
	*,
	CijenaBezPDV - LAG(CijenaBezPDV, 1) over (order by CijenaBezPDV) as Delta
from Proizvod
where CijenaBezPDV > 0
order by CijenaBezPDV

-- 9. Napravite tablicu VozniRed sa stupcima ID, Stanica, Polazak. Ubacite četiri retka s podacima: Zagreb,
-- 11:00; Dugo Selo, 11:35; Kutina, 13:15; Novska 13:45. Ispišite vozni red i uz svaku stanicu napišite koliko minuta traje vožnja do iduće stanice.
create table VozniRed (
	IDVozniRed int constraint PK_VozniRed primary key identity,
	Stanica nvarchar(50) not null,
	Polazak time not null
)
go
insert into VozniRed (Stanica, Polazak) values ('Zagreb', '11:00')
insert into VozniRed (Stanica, Polazak) values ('Dugo Selo', '11:35')
insert into VozniRed (Stanica, Polazak) values ('Kutina', '13:15')
insert into VozniRed (Stanica, Polazak) values ('Novska', '13:45')
go

select
	*,
	datediff(minute, Polazak, LEAD(Polazak, 1) over (order by Polazak)) as VoznjaDoIduce
from VozniRed
go