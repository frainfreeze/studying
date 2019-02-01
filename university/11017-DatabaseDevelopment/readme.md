## i4
### variables
```sql
-- variable: declare, assign, print
DECLARE @foo nvarchar(50)
SET @foo = 'hi.'
PRINT 'PC says: ' + @foo
GO

-- When SET NOCOUNT is ON, the count (indicating the 
-- number of rows affected by a Transact-SQL statement) is not returned.
SET NOCOUNT ON

-- IF-ELSE 
-- declare int, select number of buyers from table, print
DECLARE @Broj int
SELECT @Broj = COUNT(*) FROM dbo.Kupac
IF @Broj >= 20000
	PRINT 'theres more than 20000 buyers'
ELSE
	PRINT 'less than 20k buyers'
GO

-- scope_identity() function returns the last identity created 
-- in the same session and the same scope
-- add record to table Drzava, save identity value and add
-- new city for that country using identity value
DECLARE @IDDrzavaNovi int
INSERT INTO Drzava VALUES ('China')
-- select SCOPE_IDENTITY()
SET @IDDrzavaNovi = SCOPE_IDENTITY()
INSERT INTO Grad VALUES ('Peking', @IDDrzavaNovi)
GO
```

### procedures
```sql
-- parameterless procedure:
-- select all from Drzava
CREATE PROC p7
AS
    SELECT * FROM Drzava
GO
-- execute procedure
EXEC p7
GO
-- modify p7 to return names desc
ALTER PROC p7
AS
    SELECT * FROM Drzava ORDER BY Naziv DESC
GO
-- delete p7
DROP PROC p7
GO

-- procedure with input parameters:
-- takes 2 prices returns products in range
CREATE PROC p10
	@price1 money,
	@price2 money
AS
    SELECT Naziv, CijenaBezPDV FROM Proizvod 
    WHERE CijenaBezPDV BETWEEN @price1 AND @price2
GO
-- execute in 2 possible ways
EXEC p10 500, 1000
EXEC p10 @Cijena1 = 500, @Cijena2 = 1000
GO

-- procedure with output
-- takes filter condition for surnames, returns count and records
CREATE PROC p13
	@Filter nvarchar(50),
	@BrojZapisa int OUTPUT
AS
    SELECT @BrojZapisa = COUNT(*) FROM Kupac WHERE Prezime LIKE @Filter
    SELECT * FROM Kupac WHERE Prezime LIKE @Filter
GO

DECLARE @Cnt int
EXEC p13 '%hu%', @Cnt OUTPUT
PRINT @Cnt
GO

-- procedure with return param
-- takes name and surname, returns 0 if exist, 200 if not
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

-- alter procedure to be protected
ALTER PROC p15
	@Ime nvarchar(50),
	@Prezime nvarchar(50)
WITH ENCRYPTION
AS ...
```

### creating table
```sql
CREATE TABLE Student (
	IDStudent int PRIMARY KEY IDENTITY,
	Ime nvarchar(50),
	Prezime nvarchar(50),
	JMBAG char(11)
)
GO
```

### CRUD operations - separated insert, update, delete and get
```sql
CREATE PROC InsertTable
    @IDTable int OUTPUT,
    -- vars
AS
	INSERT INTO [Table] ([Column names]) VALUES ([@vars])
	SET @IDTable = SCOPE_IDENTITY()
GO

CREATE PROC UpdateTable
	@IDTable int, 
    -- vars
AS
	UPDATE [Table] 
	SET [Column name] = @Var, ...
	WHERE IDTable = @IDVar
GO

CREATE PROC DeleteTable
	@IDVar int
AS
	DELETE FROM [Table] WHERE IDTable = @IDVar
GO

CREATE PROC GetTable
	@IDTable int
AS
	SELECT * FROM Table WHERE IDTable = @IDTable
GO
```

### CRUD operations - joined insert, update, delete, separated get
```sql
CREATE PROC ChangeTable
	@Oper char(1),
	@IDTable int OUTPUT, 
	--vars
AS
IF @Oper = 'U'
	UPDATE Table 
	SET [table column] = @var,...
	WHERE IDTable = @IDTable
ELSE IF @Oper = 'I' BEGIN
	...
END
ELSE IF @Oper = 'D'
	DELETE FROM Table WHERE IDTable = @IDTable
GO

CREATE PROC GetTable
	@IDTable int
AS
    SELECT * FROM Table WHERE IDTable = @IDTable
GO
```

### Casting
```sql
/* PRETVARANJE TIPOVA PODATAKA
Dohvatite brojeve ra�una i datume izdavanja za kupca s ID-em 378.
Datume izdavanja formatirajte na hrvatski na�in. */
SELECT	
	BrojRacuna,
	CONVERT(char(10), DatumIzdavanja, 104) AS DatumIzdavanja
FROM Racun WHERE KupacID = 378
GO

/* PRETVARANJE TIPOVA PODATAKA
Napi�ite proceduru za umetanje zapisa u tablicu Drzava. 
Neka procedura kroz izlazni parametar vrati vrijednost primarnog klju�a novog zapisa. 
Pozovite proceduru i ispi�ite vra�enu vrijednost u formatu: 
�Umetnuta je dr�ava s ID-em n�, gdje je n vrijednost primarnog klju�a. */
CREATE PROC p1
	@Naziv nvarchar(50),
	@ID int OUTPUT
AS
INSERT INTO Drzava (Naziv) VALUES (@Naziv)
SET @ID = SCOPE_IDENTITY()
GO

DECLARE @n int
EXEC p1 'Gruzija', @n OUTPUT
PRINT 'Umetnuta je dr�ava s ID-em ' + CAST(@n AS nvarchar(10))
GO

/* PRETVARANJE TIPOVA PODATAKA
Dohvatite nazive svih proizvoda i uz svaki naziv u zagradi 
ispi�ite i njegov ID te cijenu, 
npr. �HL Road Rear Wheel (ID = 828, Cijena = 357.06)� */
SELECT Naziv + ' (ID = ' + CAST(IDProizvod AS nvarchar(50)) + ', Cijena = ' + CAST(CijenaBezPDV AS nvarchar(50)) + ')' AS Naziv
FROM dbo.Proizvod

/* NAREDBA CASE I WHILE
Dohvatite nazive svih proizvoda i uz svaki naziv ispi�ite i naziv potkategorije. 
Ako neke potkategorije nema, napi�ite �Nije definirana�. */
SELECT p.Naziv,
	CASE
		WHEN pk.Naziv IS NULL THEN 'Nije definirana'
		ELSE pk.Naziv
	END AS NazivPotkategorije
FROM Proizvod AS p
LEFT JOIN Potkategorija AS pk ON p.PotkategorijaID = pk.IDPotkategorija
```

### Case and While
```sql
/* NAREDBA CASE I WHILE
Dohvatite naziv i cijene svih proizvoda. 
Za cijene koje su ispod 1000, napi�ite �Jeftino�, izme�u 1000 i 2000 
napi�ite �Prihvatljivo�, za sve ostale napi�ite �Skupo�. */
SELECT Naziv,
	CASE
		WHEN CijenaBezPDV < 1000 THEN 'Jeftino'
		WHEN CijenaBezPDV BETWEEN 1000 AND 2000 THEN 'Prihvatljivo'
		ELSE 'Skupo'
	END AS Procjena
FROM Proizvod
GO 

/* NAREDBA CASE I WHILE
Napravite tablicu Proba sa stupcima IDProba (primarni klju� i IDENTITY) i Vrijednost (int). 
U stupac Vrijednost unesite vrijednosti izme�u 10.000.000 i 10.015.000. */
CREATE TABLE Proba ( IDProba int PRIMARY KEY IDENTITY, Vrijednost int )
GO

DECLARE @i int = 10000000
WHILE @i <= 10015000 BEGIN
	INSERT INTO Proba VALUES (@i)
	SET @i += 1
END

SELECT * FROM Proba
GO
```

### Error handling
```sql
/* STRUKTURIRANO HVATANJE POGRE�AKA
Napravite proceduru koja prima dva broja i kroz izlazni parametar 
vra�a prvi broj podijeljen drugim. 
Ako se desi gre�ka, neka procedura u izlazni parametar upi�e 0 
i neka ispi�e tekst gre�ke. 
Pozovite proceduru i ispi�ite rezultat dijeljenja. */
create PROC pp2
	@a int,
	@b int,
	@c int OUTPUT
AS
BEGIN TRY
	SET @c = @a / @b
END TRY
BEGIN CATCH
	SET @c = 0
	PRINT ERROR_MESSAGE()
END CATCH
GO

DECLARE @Rez int
EXEC pp2 32, 4, @Rez OUTPUT
PRINT @Rez

EXEC pp2 32, 0, @Rez OUTPUT
PRINT @Rez
GO

/* STRUKTURIRANO HVATANJE POGRE�AKA
Napravite tablicu Zivotinja koja ima stupce IDZivotinja 
(primarni klju�, ali nije IDENTITY) i Naziv. 
Napravite proceduru koja prima IDZivotinja i Naziv i ume�e ih u tablicu. 
Pozovite proceduru dva puta s vrijednostima 20 i "�aplja".
Implementirajte TRY/CATCH izvan procedure i pozovite je.
Implementirajte TRY/CATCH unutar procedure i pozovite je. */
CREATE TABLE Zivotinja (
	IDZivotinja int PRIMARY KEY,
	Naziv nvarchar(50)
)
GO

CREATE PROC InsertZivotinja 
	@IDZivotinja int,
	@Naziv nvarchar(50)
AS
INSERT INTO Zivotinja (IDZivotinja, Naziv) VALUES (@IDZivotinja, @Naziv)
GO

EXEC InsertZivotinja 20, '�aplja'
EXEC InsertZivotinja 20, '�aplja'
GO

BEGIN TRY
	EXEC InsertZivotinja 20, '�aplja'
	EXEC InsertZivotinja 20, '�aplja'
END TRY
BEGIN CATCH
	PRINT 'Error message: ' + cast(ERROR_MESSAGE() as nvarchar(100))
	PRINT 'Error number: ' + cast(ERROR_NUMBER() as nvarchar(100))
	PRINT 'Error severity: ' + cast(ERROR_SEVERITY() as nvarchar(100))
	PRINT 'Error line ' + cast(ERROR_LINE() as nvarchar(100))
	PRINT 'Error procedure: ' + cast(ERROR_PROCEDURE() as nvarchar(100))
END CATCH
GO

ALTER PROC InsertZivotinja 
	@IDZivotinja int,
	@Naziv nvarchar(50)
AS
BEGIN TRY
	INSERT INTO Zivotinja (IDZivotinja, Naziv) VALUES (@IDZivotinja, @Naziv)
END TRY
BEGIN CATCH
	PRINT 'Desila se gre�ka: ' + ERROR_MESSAGE()
	PRINT '�ivotinja nije upisana.'
END CATCH
GO

EXEC InsertZivotinja 20, '�aplja'
GO
```

### Scalar functions
```sql
/* SKALARNE FUNKCIJE
Napi�ite funkciju koja prima ID proizvoda i dohva�a broj prodanih primjeraka. 
Pozovite funkciju samostalno. 
Dohvatite nazive i boje svih proizvoda i uz svaki proizvoda 
ispi�ite koliko primjeraka je prodano. 
Promijenite funkciju tako da vrati 0 za one proizvode koji nisu prodani 
niti u jednom primjerku. 
Uklonite funkciju. */
create FUNCTION UkupnaKolicina (
	@ID int
)
RETURNS int
AS
BEGIN
	DECLARE @Ukupno int
	SELECT @Ukupno = Sum(Kolicina) FROM Stavka WHERE ProizvodID = @ID
	RETURN @Ukupno
END
GO

DECLARE @Rez int
SET @Rez = dbo.UkupnaKolicina(776)
PRINT @Rez

SELECT
	Naziv,
	Boja,
	dbo.UkupnaKolicina(IDProizvod) AS Prodano
FROM Proizvod
GO

ALTER FUNCTION UkupnaKolicina (
	@ID int
)
RETURNS int
AS
BEGIN
	DECLARE @Ukupno int

	SELECT @Ukupno = Sum(Kolicina) FROM Stavka WHERE ProizvodID = @ID

	RETURN CASE
		WHEN @Ukupno IS NOT NULL THEN @Ukupno
		ELSE 0
	END
END
GO

SELECT Naziv, Boja, dbo.UkupnaKolicina(IDProizvod) AS Prodano
FROM Proizvod
GO

/* SKALARNE FUNKCIJE
Napi�ite funkciju koja prima string. 
Ako je broj znakova u stringu manji od 10, neka funkcija vrati ulazni string. 
Ako ne, neka vrati prvih 7 znakova i iza toga tri to�ke. 
Ispi�ite nazive svih proizvoda koriste�i napravljenu funkciju. */
CREATE FUNCTION Skrati (
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

PRINT dbo.Skrati('Zvonko')
PRINT dbo.Skrati('Zvonko Telefonko')

SELECT 
	Naziv,
	dbo.Skrati(Naziv) AS NazivSkraceni
FROM Proizvod
GO

/* SKALARNE FUNKCIJE
Napi�ite funkciju koja za zadanog kupca vra�a datum najnovije kupovine. 
Ispi�ite sve kupce i kraj svakog ispi�ite datum najnovije kupovine. 
Ako treba, optimizirajte! */
CREATE FUNCTION GetNajnoviji (
	@IDKupac int
)
RETURNS datetime
AS
BEGIN
	DECLARE @Datum datetime
	
	SELECT TOP 1 @Datum = DatumIzdavanja FROM dbo.Racun
	WHERE KupacID = @IDKupac
	ORDER BY DatumIzdavanja DESC
	
	RETURN @Datum
END
GO

SELECT  *, dbo.GetNajnoviji(IDKupac) AS NajnovijaKupnja
FROM Kupac

CREATE NONCLUSTERED INDEX i1 ON dbo.Racun(KupacID) INCLUDE (DatumIzdavanja)
GO
```

### Table functions
```sql
/* JEDNOSTAVNE TABLI�NE FUNKCIJE
Napi�ite jednostavnu tabli�nu funkciju koja vra�a IDKupac, ime i prezime svih osoba �ije prezime zapo�inje sa zadanim stringom. 
Iskoristite funkciju za dohvat svih osoba �ije prezime zapo�inje sa 'Zhu'. 
Uz svaku osobu dohvatite i njegove ra�une. */
CREATE FUNCTION DohvatiOsobe (
    @PrezimeLike nvarchar(50)
)
RETURNS TABLE
AS
RETURN
    SELECT IDKupac, Ime, Prezime
    FROM Kupac
    WHERE Prezime LIKE @PrezimeLike + '%'
GO

SELECT * FROM DohvatiOsobe('Zhu')

SELECT * 
FROM DohvatiOsobe('Zhu') AS os
INNER JOIN Racun AS r ON os.IDKupac = r.KupacID
GO

/* JEDNOSTAVNE TABLI�NE FUNKCIJE
Napi�ite jednostavnu tabli�nu funkciju koja prima dva datuma. 
Neka funkcija vrati broj ra�una, datum izdavanja i ime i prezime kupca za sve ra�une izdane izme�u zadanih datuma. 
Iskoristite funkciju za dohvat ra�una izme�u 01.06.2004. i 03.06.2004.
Promijenite funkciju da datum vrati u hrvatskom formatu. */
CREATE FUNCTION DohvatiRacune (
    @D1 datetime, 
    @D2 datetime
)
RETURNS TABLE
AS
RETURN
	SELECT r.BrojRacuna, r.DatumIzdavanja, k.Ime, k.Prezime
	FROM Racun AS r
	LEFT JOIN dbo.Kupac AS k ON r.KupacID = k.IDKupac
	WHERE r.DatumIzdavanja BETWEEN @D1 AND @D2
GO

SELECT * FROM DohvatiRacune('20040601', '20040603')
GO

ALTER FUNCTION DohvatiRacune (
    @D1 datetime, 
    @D2 datetime
)
RETURNS TABLE
AS
RETURN
	SELECT r.BrojRacuna, CONVERT(char(10), r.DatumIzdavanja, 104) AS DatumIzdavanja, k.Ime, k.Prezime
	FROM Racun AS r
	LEFT JOIN dbo.Kupac AS k ON r.KupacID = k.IDKupac
	WHERE r.DatumIzdavanja BETWEEN @D1 AND @D2
GO

SELECT * FROM DohvatiRacune('20040601', '20040603')
GO

/* SLO�ENE TABLI�NE FUNKCIJE
Napi�ite slo�enu tabli�nu funkciju koja se pona�a kao funkcija iz zadatka 2.
PODSJETNIK na zadatak 2:
Napi�ite slo�enu  tabli�nu funkciju koja prima dva datuma. 
Neka funkcija vrati broj ra�una, datum izdavanja i ime i prezime kupca za sve ra�une izdane izme�u zadanih datuma. 
Iskoristite funkciju za dohvat ra�una izme�u 01.06.2004. i 03.06.2004. */
CREATE FUNCTION DohvatiRacuneSloz (
    @D1 datetime, 
    @D2 datetime
)
RETURNS @RetVal TABLE ( BrojRacuna nvarchar(25), DatumIzdavanja datetime, Ime nvarchar(50), Prezime nvarchar(50) )
AS
BEGIN
	INSERT INTO @RetVal (BrojRacuna, DatumIzdavanja, Ime, Prezime)
	SELECT r.BrojRacuna, r.DatumIzdavanja, k.Ime, k.Prezime
	FROM Racun AS r
	LEFT JOIN dbo.Kupac AS k ON r.KupacID = k.IDKupac
	WHERE r.DatumIzdavanja BETWEEN @D1 AND @D2
	
	RETURN
END
GO

SELECT * FROM DohvatiRacuneSloz('20040601', '20040603')
GO

/* SLO�ENE TABLI�NE FUNKCIJE
Napi�ite slo�enu tabli�nu funkciju koja prima cijenu. 
Ako je cijena NULL, vratite nazive i cijene svih proizvoda iz tablice Proizvod. 
Ako nije, vratite nazive i cijene samo onih proizvoda �ija cijena je ve�a od zadane cijene. 
Iskoristite funkciju s NULL i s cijenom od 3000. */
CREATE FUNCTION F4 (
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

SELECT * FROM F4(NULL)
SELECT * FROM F4(3000)
GO

/* Zadatak 23. SLO�ENE TABLI�NE FUNKCIJE
Napi�ite slo�enu tabli�nu funkciju koja prima jedan datum i koja vra�a tablicu 
koja se sastoji od jednog stupca i koja sadr�ava sljede�ih 5 datuma. 
Primjerice, ako je zadan 03.12.2011, funkcija treba vratiti 04.12., 05.12, 06.12, 07.12, 08.12. */
CREATE FUNCTION GetDatume
(
	@Datum datetime
)
RETURNS @RetVal TABLE ( Datum datetime )
AS
BEGIN
	DECLARE @i int = 1
	WHILE @i <= 5 BEGIN
		INSERT INTO @RetVal (Datum)
		VALUES (Dateadd(day, @i, @Datum))
		
		SET @i += 1
	END
	
	RETURN
END
GO

SELECT * FROM GetDatume(GETDATE())
SELECT * FROM GetDatume('20111229')
GO
```