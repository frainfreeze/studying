-- ISHOD 5 - OKIDACI --
-----------------------
-- Izrada log tablice.
CREATE TABLE Zapisnik
(
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

/* Zadatak 6.
Dodajte novi okidaè na tablicu Grad i veite ga uz sva tri dogaðaja. 
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
Neka okidaè zapie u Zapisnik da se desio dogaðaj samo ako je promijenjen stupac DrzavaID. 
Uklonite okidaè. */
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

DROP TRIGGER Okidac3
GO

-- 
/*Zadatak 8. Dodajte 4 nova okidaèa koji u zapisnik ispisuju "Pozdrav iz broja n" nakon umetanja retka. 
Umetnite redak.  Posloite redoslijed okidaèa tako da bude 4, 2, 3, 1. 
Umetnite redak. Vratite originalni redoslijed. Umetnite redak. Uklonite okidaèe. */
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

DROP TRIGGER Okidac1
DROP TRIGGER Okidac2
DROP TRIGGER Okidac3
DROP TRIGGER Okidac4
GO
 
/* Zadatak 9. Napravite tablice Tbl1 i Tbl2 s proizvoljnim stupcima. 
Na Tbl1 napravite okidaè vezan uz INSERT koji umeæe retke u Tbl2 i u Zapisnik. 
Na Tbl2 napravite okidaè vezan uz INSERT koji umeæe retke u Tbl1 i u Zapisnik. 
Umetnite jedan redak u Tbl1.  */
CREATE TABLE Tbl1
(
	Stupac1 int PRIMARY KEY IDENTITY,
	Stupac2 nvarchar(50)
)
CREATE TABLE Tbl2
(
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

SELECT * FROM Tbl1
SELECT * FROM Tbl2
SELECT * FROM Zapisnik

-- I6 - TIPOVI --
-----------------
/* Zadatak 1.
RAD SA STRINGOVIMA (1)
Napisati funkciju koja prima string i vraæa novi string sastavljen od:
	druga polovica stringa + prva polovica stringa. 
Ako ulazni string ima neparan broj znakova, 
neka u prvoj polovici bude manji broj znakova 
(primjerice, za "Slon" treba vratiti "onSl", za "Mirko" treba "rkoMi"). */
CREATE FUNCTION dbo.Obrni
(
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

/* Zadatak 2.
RAD SA STRINGOVIMA (2)
Napisati funkciju koja prima string i koja vraæa broj pojavljivanja slova 'a' u tom stringu. */
CREATE FUNCTION dbo.BrojSlovaA
(
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
PRINT dbo.BrojSlovaA('Ana')
PRINT dbo.BrojSlovaA('Ankica')
PRINT dbo.BrojSlovaA('Anakonda')
-- Dohvatiti sve proizvode iz i pokraj svakog ispisati broj pojavljivanja slova 'a' u nazivu.
SELECT *, dbo.BrojSlovaA(Naziv) AS BrojSlovaA FROM Proizvod
GO

/* Zadatak 3.
RAD SA STRINGOVIMA (2)
Napisati funkciju koja prima string i koja vraæa broj samoglasnika u tom stringu. */
CREATE FUNCTION dbo.BrojSamoglasnika
(
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
PRINT dbo.BrojSamoglasnika('Ana')
PRINT dbo.BrojSamoglasnika('Ankica')
PRINT dbo.BrojSamoglasnika('Anakonda')
-- Dohvatiti sve proizvode iz i pokraj svakog ispisati broj samoglasnika u nazivu.
SELECT *, dbo.BrojSamoglasnika(Naziv) AS BrojSamoglasnika FROM Proizvod
GO

/* Zadatak 4.
XML (1)
Napisati proceduru koja prima XML dokument oblika:
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
 
/* Zadatak 5.
XML (1)
Proiriti prethodni XML dokument tako da svaki grad sadrava atribut "PostanskiBroj". 
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

/* Zadatak 6.
XML (2)
Napisati proceduru koja prima XML dokument oblika:
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

/* Zadatak 7
XML (3)
Napisati proceduru koja prima XML dokument oblika:
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

/* Zadatak 8.
KORISNIÈKI DEFINIRANI TABLIÈNI TIPOVI
Napiite proceduru koja dohvaæa sve kupce èiji ID-evi su proslijeðeni 
pomoæu korisnièki definiranog tabliènog tipa. 
*/
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

/* Zadatak 9.
KORISNIÈKI DEFINIRANI TABLIÈNI TIPOVI
Napiite proceduru koja umeæe drave proslijeðene pomoæu korisnièki definiranog tabliènog tipa. Pozovite proceduru. */
-- Kreiranje korisnièki definiranog tipa
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

/*Zadatak 10
KORISNIÈKI DEFINIRANI TABLIÈNI TIPOVI
Napiite proceduru koja umeæe potkategorije proslijeðene 
pomoæu korisnièki definiranog tabliènog tipa. 
Umetnuti samo onu potkategoriju koja ne postoji u tablici 
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
/* Kreiranje pomoæne tablice
Napravite tablicu Osoba s IDOsoba (PK i IDENTITY), Ime i Prezime.
*/
CREATE TABLE Osoba
(
    IDOsoba int PRIMARY KEY IDENTITY,
    Ime nvarchar(50),
    Prezime nvarchar(50)
)
GO

/* Zadatak 1.
TRANSAKCIJE (1)
U transakciji umetnite 3 zapisa u Osoba i na kraju odustanite od transakcije.  */
SELECT * FROM Osoba

BEGIN TRAN
	INSERT INTO Osoba VALUES ('Miro', 'Miriæ')
	INSERT INTO Osoba VALUES ('Ana', 'Aniæ')
	INSERT INTO Osoba VALUES ('Iva', 'Iviæ')
	SELECT * FROM Osoba
ROLLBACK TRAN

SELECT * FROM Osoba
GO

/* Zadatak 2
TRANSAKCIJE (1)
U transakciji umetnite 3 zapisa u Osoba i na kraju potvrdite transakciju. */
SELECT * FROM Osoba

BEGIN TRAN
	INSERT INTO Osoba VALUES ('Miro', 'Miriæ')
	INSERT INTO Osoba VALUES ('Ana', 'Aniæ')
	INSERT INTO Osoba VALUES ('Iva', 'Iviæ')
	SELECT * FROM Osoba
COMMIT TRAN

SELECT * FROM Osoba
GO
 
/*Zadatak 3.
TRANSAKCIJE (1)
U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu toèku. Umetnite jo 1 zapis. 
Na kraju odustanite od transakcije. */
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

/*Zadatak 4.
TRANSAKCIJE (1)
U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu toèku. 
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

/*Zadatak 5.
TRANSAKCIJE (2)
U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu toèku. 
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

/* Zadatak 6.
TRANSAKCIJE (2)
U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu toèku. 
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

/* Zadatak 7.
TRANSAKCIJE (2)
U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu toèku. 
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

/* Zadatak 8.
TRANSAKCIJE (2)
U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu toèku. 
Umetnite jo 1 zapis i vratite se na kontrolnu toèku. 
Na kraju potvrdite transakciju. */
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

/* Zadatak 9.
TRANSAKCIJE (3)
Napiite proceduru za brisanje drave. Neka procedura prima 1 parametar, IDDrzava. 
Transakciju vodite izvan procedure. 
Ispiite uspjeh ili neuspjeh. 
- Pozovite 3 puta proceduru s vrijednostima parametara jednakim 50, 51 i 52. 
- Pozovite 3 puta proceduru s vrijednostima parametara jednakim 50, 51 i 1. */
-- Napiite proceduru za brisanje drave. Neka procedura prima 1 parametar, IDDrzava. 
CREATE PROC p9
	@IDDrzava int
AS
DELETE FROM Drzava WHERE IDDrzava = @IDDrzava
GO
-- Transakciju vodite izvan procedure. 
-- Ispiite uspjeh ili neuspjeh. 
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
-- Transakciju vodite izvan procedure. 
-- Ispiite uspjeh ili neuspjeh. 
-- Pozovite 3 puta proceduru s vrijednostima parametara jednakim 50, 51 i 1.
BEGIN TRY
	BEGIN TRAN
		EXEC p9 50
		EXEC p9 51
		EXEC p9 1
	COMMIT TRAN
	PRINT 'Brisanje uspjeno'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'Greka pri brisanju'
END CATCH
GO

/* Zadatak 10.
TRANSAKCIJE (3)
Napiite proceduru s 3 parametra za brisanje triju drava. 
Transakciju vodite unutar procedure. Ispiite uspjeh ili neuspjeh. 
Pozovite proceduru s vrijednostima 50, 51 i 52. 
Pozovite proceduru s vrijednostima 50, 51 i 1. */
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

/* Zadatak 11.
TRANSAKCIJE (4)
Unutar vanjske transakcije pozovite prethodnu proceduru s vrijednostima 50, 51 i 52. 
Nakon toga odustanite od vanjske transakcije. 
Ispiite uspjeh ili neuspjeh. */
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
 
/* Zadatak 12.
TRANSAKCIJE (4)
Osmislite XML za unos raèuna s tri stavke. 
Napiite proceduru za unos raèuna i unutar transakcije odradite umetanje raèuna i stavki. Pozovite proceduru. */
-- Napiite proceduru za unos raèuna i unutar transakcije odradite umetanje raèuna i stavki. 
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
Kod rjeavanja zadataka s transakcijama 
potrebne su dvije SQL skripte, svaka u 
svojoj konekciji te svaka SQL naredba 
treba sadravati redni broj izvravanja*/
/*Zadatak 1.
IZOLACIJSKI NIVOI (1) - SKRIPTA 1
Demonstrirajte problem prljavog èitanja na tablici Drzava na retku s IDDrzava = 3. 
Napiite gdje se desilo prljavo èitanje. */
-- TRANSAKCIJA 1.
-- KORACI KOJI NEDOSTAJU IZVRAVAJU SE U DRUGOJ SKRIPTI
-- 1. 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 3.
BEGIN TRAN
-- 5.
UPDATE Drzava SET Naziv = 'BIH' WHERE IDDrzava = 3
-- 7.
ROLLBACK TRAN

/*Zadatak 2.
IZOLACIJSKI NIVOI (1) - SKRIPTA 1
Demonstrirajte rjeenje problem prljavog èitanja na tablici Drzava na retku s IDDrzava = 3. 
Napiite gdje bi se desilo prljavo èitanje i kako ste to sprijeèili. */
-- TRANSAKCIJA 1.
-- KORACI KOJI NEDOSTAJU IZVRAVAJU SE U DRUGOJ SKRIPTI
-- 1. 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 3.
BEGIN TRAN
-- 5.
UPDATE Drzava SET Naziv = 'BIH' WHERE IDDrzava = 3
-- 7.
ROLLBACK TRAN

/* Zadatak 3.
IZOLACIJSKI NIVOI (2) - SKRIPTA 1
Demonstrirajte problem neponovljivog èitanja na tablici Drzava na retku s IDDrzava = 3. 
Napiite gdje se desilo neponovljivo èitanje. */
-- TRANSAKCIJA 1.
-- KORACI KOJI NEDOSTAJU IZVRAVAJU SE U DRUGOJ SKRIPTI
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

/*Zadatak 4.
IZOLACIJSKI NIVOI (2) - SKRIPTA 1
Demonstrirajte rjeenje problema neponovljivog èitanja na tablici Drzava na retku s IDDrzava = 3. 
Napiite gdje bi se desilo neponovljivo èitanje. */
-- TRANSAKCIJA 1.
-- KORACI KOJI NEDOSTAJU IZVRAVAJU SE U DRUGOJ SKRIPTI
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

/*Zadatak 5.
IZOLACIJSKI NIVOI (2) - SKRIPTA 1 Demonstrirajte problem fantoma na tablici Drzava 
na recima s nazivima koji zapoèinju s 'H'. Napiite gdje se pojavljuju fantomi. */
-- TRANSAKCIJA 1.
-- KORACI KOJI NEDOSTAJU IZVRAVAJU SE U DRUGOJ SKRIPTI
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

/* Zadatak 6.
IZOLACIJSKI NIVOI (2) - SKRIPTA 1
Demonstrirajte rjeenje problema fantoma na tablici Drzava 
na recima s nazivima koji zapoèinju s 'H'. 
Napiite gdje bi se pojavili fantomi. */
-- TRANSAKCIJA 1.
-- KORACI KOJI NEDOSTAJU IZVRAVAJU SE U DRUGOJ SKRIPTI
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

/* N A P O M E N A
Kod rjeavanja zadataka s transakcijama 
potrebne su dvije SQL skripte, svaka u 
svojoj konekciji te svaka SQL naredba 
treba sadravati redni broj izvravanja */
/* Zadatak 1.
IZOLACIJSKI NIVOI (1) - SKRIPTA 2
Demonstrirajte problem prljavog èitanja na tablici Drzava na retku s IDDrzava = 3. 
Napiite gdje se desilo prljavo èitanje. */
-- TRANSAKCIJA 2.
-- KORACI KOJI NEDOSTAJU IZVRAVAJU SE U PRVOJ SKRIPTI
-- 2.
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
-- 4. 
BEGIN TRAN
-- 6.
SELECT * FROM Drzava WHERE IDDrzava = 3 -- Prljavo èitanje.
-- 8.
ROLLBACK TRAN

/* Zadatak 2.
IZOLACIJSKI NIVOI (1) - SKRIPTA 2
Demonstrirajte rjeenje problem prljavog èitanja na tablici Drzava na retku s IDDrzava = 3. 
Napiite gdje bi se desilo prljavo èitanje i kako ste to sprijeèili. */
-- TRANSAKCIJA 2.
-- KORACI KOJI NEDOSTAJU IZVRAVAJU SE U PRVOJ SKRIPTI
-- 2.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED -- Prljavo èitanje sprjeèavamo postavljanjem bilo kojeg izolacijskog nivoa iznad READ UNCOMMITTED.
-- 4. 
BEGIN TRAN
-- 6.
SELECT * FROM Drzava WHERE IDDrzava = 3 -- Blokiranje umjesto prljavog èitanja.
-- 8.
ROLLBACK TRAN

/* Zadatak 3
IZOLACIJSKI NIVOI (2) - SKRIPTA 2
Demonstrirajte problem neponovljivog èitanja na tablici Drzava na retku s IDDrzava = 3. 
Napiite gdje se desilo neponovljivo èitanje. */
-- TRANSAKCIJA 2.
-- KORACI KOJI NEDOSTAJU IZVRAVAJU SE U PRVOJ SKRIPTI
-- 2.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 4. 
BEGIN TRAN
-- 6.
UPDATE Drzava SET Naziv = 'Bosna i Hercegovina' WHERE IDDrzava = 3
-- 7.
COMMIT TRAN

/* Zadatak 4.
IZOLACIJSKI NIVOI (2) - SKRIPTA 2
Demonstrirajte rjeenje problema neponovljivog èitanja na tablici Drzava na retku s IDDrzava = 3. 
Napiite gdje bi se desilo neponovljivo èitanje. */
-- TRANSAKCIJA 2.
-- KORACI KOJI NEDOSTAJU IZVRAVAJU SE U PRVOJ SKRIPTI
-- 2.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 4. 
BEGIN TRAN
-- 6.
UPDATE Drzava SET Naziv = 'Hrv' WHERE IDDrzava = 1 -- Blokiran zbog S lokota.
-- 9.
ROLLBACK TRAN

/* Zadatak 5.
IZOLACIJSKI NIVOI (2) - SKRIPTA 2
Demonstrirajte problem fantoma na tablici Drzava 
na recima s nazivima koji zapoèinju s 'H'. 
Napiite gdje se pojavljuju fantomi. */
-- TRANSAKCIJA 2.
-- KORACI KOJI NEDOSTAJU IZVRAVAJU SE U PRVOJ SKRIPTI
-- 2.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 4. 
BEGIN TRAN
-- 6.
INSERT INTO Drzava (Naziv) VALUES ('Honduras')
-- 7.
COMMIT TRAN

/* Zadatak 6  IZOLACIJSKI NIVOI (2) - SKRIPTA 2
Demonstrirajte rjeenje problema fantoma na tablici Drzava 
na recima s nazivima koji zapoèinju s 'H'. 
Napiite gdje bi se pojavili fantomi. */
-- TRANSAKCIJA 2.
-- KORACI KOJI NEDOSTAJU IZVRAVAJU SE U PRVOJ SKRIPTI
-- 2.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- 4. 
BEGIN TRAN
-- 6.
INSERT INTO Drzava (Naziv) VALUES ('Haiti') -- Blokiran zbog S lokota. Da nije, umetnuo bi fantoma.
-- 9.
ROLLBACK TRAN
