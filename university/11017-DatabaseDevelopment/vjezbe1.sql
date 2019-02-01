---------------- Vjezba 1 
-- 1a. Napisati skriptu koja �e implementirati sljede�i model (dan u vje�bi)
-- kreiranje i prebacivanje na bazu
CREATE DATABASE RentACar
GO
USE RentACar
GO

-- kreiranje tablica, prvo idu maticne talice (ne sadrze u sebi FK-eve)
-- Proizvodac
CREATE TABLE Proizvodjac (
	IDProizvodjac int CONSTRAINT PK_Proizvodjac PRIMARY KEY IDENTITY,
	Naziv nvarchar(50) NOT NULL
)
GO

-- Kategorija
CREATE TABLE Kategorija (
	IDKategorija int CONSTRAINT PK_Kategorija PRIMARY KEY IDENTITY,
	Naziv nvarchar(50) NOT NULL
)
GO

-- Status vozila
CREATE TABLE StatusVozila (
	IDStatusVozila int CONSTRAINT PK_StatusVozila PRIMARY KEY IDENTITY,
	Naziv nvarchar(50) NOT NULL
)
GO

-- Klijent
CREATE TABLE Klijent (
	IDKlijent int CONSTRAINT PK_Klijent PRIMARY KEY IDENTITY,
	Ime nvarchar(50) NOT NULL,
	Prezime nvarchar(50) NOT NULL,
	EMail nvarchar(50) NULL,
	Telefon nvarchar(50) NULL,
	Adresa nvarchar(50) NOT NULL,
	Grad nvarchar(50) NOT NULL,
	Drzava nvarchar(50) NOT NULL
)
GO

-- kreiranje tablica, kao drugu stvar kreiramo tablice koje se na njih vezu (sadrze strane kljuceve)
-- kreiranje ide slijedno - prvo vezne tablice koje se vezu na maticne, zatim tablice 
-- koje se vezu na prve vezne tablice itd.

-- Model -> veze se na Proizvodaca
CREATE TABLE Model (
	IDModel int CONSTRAINT PK_Model PRIMARY KEY IDENTITY,
	Naziv nvarchar(50) NOT NULL,
	IDProizvodjac int CONSTRAINT FK_Model_Proizvodjac 
		FOREIGN KEY REFERENCES Proizvodjac(IDProizvodjac) NULL,
)
GO

-- slijedece vezne tablice - vezu se na maticne i na vezne tablice napravljene u prethodnoj rundi
-- Vozilo -> veze se na Kategorija (maticna tablica) i na Model (vezna tablica 1. runde)
CREATE TABLE Vozilo (
	IDVozilo int CONSTRAINT PK_Vozilo PRIMARY KEY IDENTITY,
	Registracija nvarchar(20) NOT NULL,
	IDModel int CONSTRAINT FK_Vozilo_Model 
		FOREIGN KEY REFERENCES Model(IDModel) NOT NULL,
	IDKategorija int CONSTRAINT FK_Vozilo_Kategorija 
		FOREIGN KEY REFERENCES Kategorija(IDKategorija) NOT NULL,
	Kilometraza int NOT NULL,
	CijenaPodDanu money NOT NULL
)
GO

-- Najam -> Veze sa na Status vozila i na Klijent (maticne tablice) te na Vozilo (vezna tablica 2. runde)
CREATE TABLE Najam (
	IDNajam int CONSTRAINT PK_Najam PRIMARY KEY IDENTITY,
	IDStatusVozila int CONSTRAINT FK_Najam_StatusVozila
		FOREIGN KEY REFERENCES StatusVozila(IDStatusVozila) NOT NULL,
	IDKlijent int CONSTRAINT FK_Najam_Klijent
		FOREIGN KEY REFERENCES Klijent(IDKlijent) NOT NULL,
	IDVozilo int CONSTRAINT FK_Najam_Vozilo
		FOREIGN KEY REFERENCES Vozilo(IDVozilo) NOT NULL,
	DatumOd datetime NOT NULL,
	DatumDo datetime NULL
)
GO


/*
Bazu napuniti sljede�im podacima:
Proizvo�a�i: Opel, Honda, Volkswagen
Modeli: Astra, Vectra, Civic, Legend, Polo, Golf, Passat
Kategorije: �Benzinski motor�, �Dizelski motor�
Vozila: 
Po 1 vozilo svakog modela s benzinskim motorom
Svakog Opela dodati i s dizelskim motorom
Klijenti: Iva Ivi�, Maja Maji�, Miro Miri�
StatusVozila: �Pla�eno�, �Preuzeto�, �Vra�eno�
Najam: upi�ite da je svaki klijent iznajmio po 2 vozila, s podacima po �elji (jednog je vratio, jedan je preuzet)
*/

-- Proizvo�a�i: Opel, Honda, Volkswagen
INSERT INTO Proizvodjac (Naziv) VALUES ('Opel'), ('Honda'), ('Volkswagen'), ('Fiat')
GO

-- Modeli: Astra, Vectra, Civic, Legend, Polo, Golf, Passat
INSERT INTO Model(Naziv, IDProizvodjac) VALUES ('Astra', 1), ('Vectra', 1), 
('Civic', 2), ('Legend', 2), ('Polo', 3), ('Golf', 3), ('Passat', 3), ('C5', null)
GO

-- Kategorije: �Benzinski motor�, �Dizelski motor�
INSERT INTO Kategorija (Naziv) VALUES ('Benzinski motor'), ('Dizelski motor')
GO

-- Vozila:  Po 1 vozilo svakog modela s benzinskim motorom
INSERT INTO Vozilo (Registracija, IDModel, IDKategorija, Kilometraza, CijenaPodDanu)
VALUES ('ZG111A', 1, 1, 25000, 550.00)
GO
INSERT INTO Vozilo (Registracija, IDModel, IDKategorija, Kilometraza, CijenaPodDanu)
VALUES ('ZG222A', 2, 1, 35000, 530.00)
GO

-- Svakog Opela dodati i s dizelskim motorom
INSERT INTO Vozilo (Registracija, IDModel, IDKategorija, Kilometraza, CijenaPodDanu)
VALUES ('ZG555B', 5, 2, 45000, 200.00)
GO

-- Klijenti
INSERT INTO Klijent (Ime, Prezime, EMail, Telefon, Adresa, Grad, Drzava)
VALUES ('Iva', 'Ivi�', 'iva.ivic@abc.com', null, 'Vrtna 17', 'Vara�din', 'HR')
GO

-- StatusVozila: �Pla�eno�, �Preuzeto�, �Vra�eno�
INSERT INTO StatusVozila (Naziv) VALUES ('Pla�eno')
GO
INSERT INTO StatusVozila (Naziv) VALUES ('Preuzeto')
GO
INSERT INTO StatusVozila (Naziv) VALUES ('Vra�eno')
GO


-- Najam: upi�ite da je svaki klijent iznajmio po 2 vozila, s podacima po �elji (jednog je vratio, jedan je preuzet)
INSERT INTO Najam (IDStatusVozila, IDKlijent, IDVozilo, DatumOd, DatumDo)
VALUES (3, 1, 2, '20090901', '20090902')
GO

INSERT INTO Najam (IDStatusVozila, IDKlijent, IDVozilo, DatumOd, DatumDo)
VALUES (2, 1, 4, '20090917', null)
GO

-- Vje�ba 1c.
-- Ispi�ite ID proizvo�a�a i broj njegovih modela, opadaju�e prema broju modela
SELECT IDProizvodjac, Count(*) AS BrojModela FROM Model 
GROUP BY IDProizvodjac ORDER BY BrojModela DESC

-- Ispi�ite naziv proizvo�a�a i broj njegovih modela, opadaju�e prema broju modela
SELECT p.Naziv, Count(*) AS BrojModela 
FROM Model AS m
INNER JOIN Proizvodjac AS p ON m.IDProizvodjac = p.IDProizvodjac
GROUP BY p.Naziv ORDER BY BrojModela DESC

-- Ispi�ite najjeftiniju i najskuplju cijenu iznajmljivanja vozila za 10 dana
SELECT Min(CijenaPodDanu) * 10 AS NajmanjaCijena, Max(CijenaPodDanu) * 10 AS NajvecaCijena 
FROM Vozilo

-- Ispi�ite ukupnu kilometra�u koju su pre�la Opel vozila
SELECT Sum(Kilometraza) AS Km FROM Vozilo WHERE IDModel = 1

-- Ispi�ite broj klijenata
SELECT Count(*) FROM Klijent

-- Ispi�ite sve klijente iz Vara�dina koji nemaju definiran e-mail
SELECT * FROM Klijent WHERE Grad = 'Vara�din' AND EMail IS NULL

-- Ispi�ite registraciju i naziv modela, rastu�e prema nazivu
SELECT v.Registracija, m.Naziv FROM Vozilo AS v 
INNER JOIN Model AS m ON v.IDModel = m.IDModel
ORDER BY m.Naziv

-- Ispi�ite registraciju, naziv modela i naziv proizvo�a�a, rastu�e prema nazivu proizvo�a�a
SELECT v.Registracija, m.Naziv, p.Naziv AS NazivProizvodjaca FROM Vozilo AS v 
INNER JOIN Model AS m ON v.IDModel = m.IDModel
INNER JOIN Proizvodjac AS p on m.IDProizvodjac = p.IDProizvodjac
ORDER BY p.Naziv

-- Ispi�ite registraciju, naziv modela i naziv kategorije, rastu�e prema nazivu kategorije
SELECT v.Registracija, m.Naziv, k.Naziv AS Kategorija FROM Vozilo AS v 
INNER JOIN Model AS m ON v.IDModel = m.IDModel
INNER JOIN Kategorija AS k on v.IDKategorija = k.IDKategorija
ORDER BY k.Naziv

-- Ispi�ite registraciju, naziv modela, naziv proizvo�a�a i naziv kategorije, rastu�e prema registraciji
SELECT v.Registracija, m.Naziv, p.Naziv AS NazivProizvodjaca, k.Naziv AS Kategorija FROM Vozilo AS v 
INNER JOIN Model AS m ON v.IDModel = m.IDModel
INNER JOIN Proizvodjac AS p on m.IDProizvodjac = p.IDProizvodjac
INNER JOIN Kategorija AS k on v.IDKategorija = k.IDKategorija
ORDER BY v.Registracija

-- Ispi�ite sve najmove. Za svaki najam ispi�ite: od kada, do kada, naziv statusa, naziv proizvo�a�a, 
-- naziv kategorije, ime i prezime klijenta
SELECT n.DatumOd, n.DatumDo, sv.Naziv AS Stanje, p.Naziv AS Proizvodjac, k.Ime, k.Prezime FROM Najam AS n
INNER JOIN StatusVozila AS sv ON n.IDStatusVozila = sv.IDStatusVozila
INNER JOIN Vozilo AS v ON v.IDVozilo = n.IDVozilo
INNER JOIN Model AS m ON v.IDModel = m.IDModel
INNER JOIN Proizvodjac AS p ON m.IDProizvodjac = p.IDProizvodjac
INNER JOIN Klijent AS k ON n.IDKlijent = k.IDKlijent

-- Ispi�ite sve najmove kod kojih su vozila vra�ena u pro�lom tjednu
SELECT * FROM Najam WHERE IDStatusVozila = 3 AND DatumDo BETWEEN '20150921' AND '20150927 23:59:59'

-- Ispi�ite sve proizvo�a�e koji nemaju niti jedan model (spajanjem i podupitom) ispis spajanjem
SELECT p.*
FROM Proizvodjac AS p
LEFT JOIN Model AS m ON p.IDProizvodjac = m.IDProizvodjac
WHERE m.IDProizvodjac IS NULL

-- ispis podupitom
SELECT *
FROM Proizvodjac AS p
WHERE NOT EXISTS(SELECT * FROM Model AS m WHERE p.IDProizvodjac = m.IDProizvodjac)

-- Ispi�ite nazive svih modela i nazive njihovih proizvo�a�a. Ako neki model nema proizvo�a�a, stavite vrijednost "nepoznato".
SELECT 
	m.Naziv AS NazivModela,
	ISNULL(p.Naziv, 'nepoznato') AS NazivProizvodjaca
FROM Model AS m
LEFT JOIN Proizvodjac AS p ON m.IDProizvodjac = p.IDProizvodjac

-- Ispi�ite nazive dvaju proizvo�a�a koji imaju najvi�e modela
SELECT TOP 2
	p.Naziv,
	COUNT(*) AS BrojVozila
FROM Proizvodjac AS p
LEFT JOIN model AS m ON m.IDProizvodjac = p.IDProizvodjac
GROUP BY p.Naziv
ORDER BY BrojVozila DESC 
-
---------------- Vjezba 2
-- prebacivanje na bazu AdventureWorksOBP
USE AdventureWorksOBP
GO

-- Napravite pogled koji �e dohva�ati sve iz tablice Kupac
CREATE VIEW p1 
AS
SELECT * FROM Kupac
GO

-- Iskoristite pogled za dohva�anje svih zapisa
SELECT * FROM p1 
GO

-- Iskoristite pogled za dohva�anje onih osoba �ije ime zapo�inje sa �L� i prezime zavr�ava na �a�
SELECT * FROM p1 
WHERE Ime LIKE 'L%' AND Prezime LIKE '%a'
GO

-- Iskoristite pogled za ispis svih ID-eva gradova i broja osoba koje �ive u tom gradu, 
-- padaju�e prema broju osoba (pomo�u grupiranja i pomo�u podupita) \ pomo�u grupiranja
SELECT GradID, COUNT(*) AS BrojOsoba 
FROM p1 
GROUP BY GradID 
ORDER BY BrojOsoba DESC
GO

-- pomo�u podupita
SELECT DISTINCT 
	GradID, 
	(SELECT COUNT(*) 
	 FROM p1 AS sq 
	 WHERE ISNULL(sq.GradID, '') = ISNULL(mq.GradID, '')) AS BrojOsoba
FROM p1 AS mq 
ORDER BY BrojOsoba DESC
GO

-- Iskoristite pogled tako da ispi�ete ime i prezime te pokraj svakoga  ispi�ite njegov naziv grada i naziv dr�ave
SELECT p1.Ime, p1.Prezime, g.Naziv as 'Grad', d.Naziv as 'Dr�ava'
FROM p1
LEFT JOIN Grad AS g ON p1.GradID = g.IDGrad
LEFT JOIN Drzava AS d ON g.DrzavaID= d.IDDrzava
GO

-- Promijenite pogled tako da ne uklju�uje stupce Email, Telefon i GradID
ALTER VIEW p1 
AS
SELECT IDKupac, Ime, Prezime FROM Kupac
GO
-- provjera
SELECT * FROM p1 
GO

-- Pripremite sljede�e izvje�taje u obliku pogleda:
-- Ispi�ite nazive svih kupaca, te za svakoga ispi�ite email, grad i naziv dr�ave u kojoj je smje�ten
-- Tablice: Kupac, Grad, Drzava

CREATE VIEW p2 AS
SELECT k.Ime, k.Prezime, k.Email, g.Naziv AS Grad, d.Naziv AS Drzava
FROM Kupac AS k
LEFT JOIN Grad AS g ON k.GradID = g.IDGrad
LEFT JOIN Drzava AS d ON g.DrzavaID = d.IDDrzava
GO

-- Ispi�ite sve dr�ave i za svaku od njih ispi�ite koliko kupaca iz nje postoji
-- Tablice: Kupac, Grad, Drzava
CREATE VIEW p3 AS
SELECT d.Naziv AS Drzava, COUNT(k.IDKupac) AS BrojKupaca
FROM Kupac AS k
LEFT JOIN Grad AS g ON k.GradID = g.IDGrad
LEFT JOIN Drzava AS d ON g.DrzavaID = d.IDDrzava
GROUP BY d.Naziv
GO

-- Ispi�ite nazive svih proizvoda koje je kupilo >300 kupaca
-- Tablice: Kupac, Racun, Stavka i Proizvod
CREATE VIEW p4 AS
SELECT p.Naziv, COUNT(k.IDKupac) AS BrojKupaca
FROM Proizvod AS p
INNER JOIN Stavka AS s ON s.ProizvodID = p.IDProizvod
INNER JOIN Racun AS r ON s.RacunID = r.IDRacun
INNER JOIN Kupac AS k ON r.KupacID = k.IDKupac
GROUP BY p.Naziv
HAVING COUNT(k.IDKupac) > 300
GO

-- Ispi�ite nazive i zaradu 5 proizvoda koji se najbolje prodaju
-- Tablice: Stavka i Proizvod
CREATE VIEW p5 AS
SELECT TOP 5 p.Naziv, SUM(s.UkupnaCijena) AS Zarada
FROM Proizvod AS p
INNER JOIN Stavka AS s ON s.ProizvodID = p.IDProizvod
GROUP BY p.Naziv
ORDER BY Zarada DESC
GO

-- Uklonite sve poglede
DROP VIEW p2
DROP VIEW p3
DROP VIEW p4
DROP VIEW p5
GO

-- Napravite pogled koji vra�a imena i prezimena te e-mailove svih kupaca iz Zagreba.
CREATE VIEW p6 AS
SELECT k.Ime, k.Prezime, k.Email, g.Naziv AS Grad
FROM Kupac AS k
INNER JOIN Grad AS g ON k.GradID = g.IDGrad
WHERE g.Naziv = 'Zagreb'
GO

-- Promijenite pogled tako da dohva�a i sve kupce iz Splita.
ALTER VIEW p6 AS
SELECT  k.Ime, k.Prezime, k.Email, g.Naziv AS Grad
FROM Kupac AS k
INNER JOIN Grad AS g ON k.GradID = g.IDGrad
WHERE g.Naziv = 'Zagreb' OR g.Naziv = 'Split'
GO

-- Koriste�i pogled ispi�ite broj kupaca iz Zagreba i broj kupaca iz Splita.
SELECT Grad, COUNT(*) AS Broj
FROM p6
GROUP BY Grad
GO

---------------- Vjezba 3
-- Napravite pogled koji �e dohva�ati sve stupce i retke iz tablice Kategorija
CREATE VIEW v1 AS
SELECT * FROM Kategorija
GO 

-- Ispi�ite nazive kategorija, potkategorija i proizvoda (koristite kreirani pogled)
SELECT v1.Naziv as 'Kategorija', Potkategorija.Naziv as 'Potkategorija', Proizvod.Naziv as 'Proizvod'
FROM v1
RIGHT JOIN Potkategorija ON Potkategorija.KategorijaID = v1.IDKategorija
RIGHT JOIN Proizvod ON Proizvod.PotkategorijaID = Potkategorija.IDPotkategorija
GO

-- Pomo�u pogleda umetnite kategoriju naziva �Alarmi�
INSERT INTO v1 (Naziv) VALUES ('Alarmi')
GO 

-- Pomo�u pogleda promijenite kategoriji �Alarmi� naziv u �Aktivna za�tita�
UPDATE v1 SET Naziv = 'Aktivna za�tita' WHERE Naziv = 'Alarmi'
GO

-- Pomo�u pogleda obri�ite kategoriju �Aktivna za�tita�
DELETE FROM v1 WHERE Naziv = 'Aktivna za�tita'
GO

-- Napravite pogled koji �e dohva�ati naziv grada, naziv dr�ave u kojoj se nalazi te sve 
-- podatke o kupcima koji im pripadaju (tablice Grad, Drzava, Kupac).
CREATE VIEW v2 AS
SELECT Drzava.Naziv as 'Dr�ava', Grad.Naziv as 'Grad', Kupac.* 
FROM Kupac
LEFT JOIN Grad ON Kupac.GradID = Grad.IDGrad
LEFT JOIN Drzava ON Grad.DrzavaID = Drzava.IDDrzava
GO

-- Napravite pogled koji �e dohva�ati sve kreditne kartice koje su tipa Visa ili MasterCard (tablica KreditnaKastica)
CREATE VIEW v3 AS
SELECT * FROM KreditnaKartica WHERE Tip IN ('Visa', 'MasterCard')
GO

-- Umetnite zapis o kreditnoj kartici tipa American Express.
-- Dohvatiti umetnuti redak pomo�u pogleda. �to se dogodilo? Je li redak uspje�no umetnut u tablicu?
INSERT INTO v3 (Tip, Broj,IstekMjesec, IstekGodina) 
VALUES ('American Express', '111222333444', 12, 2012)
GO
SELECT * FROM v3 WHERE Tip = 'American Express'
GO

-- Promijenite pogled tako da ne dopu�ta umetanje/izmjenu redaka koji ne�e biti vidljivi kroz njega.
ALTER VIEW v3 AS
SELECT * FROM KreditnaKartica WHERE Tip IN ('Visa', 'MasterCard')
WITH CHECK OPTION
GO
INSERT INTO v3 (Tip, Broj,IstekMjesec, IstekGodina) 
VALUES ('American Express', '111222333444', 12, 2012)
GO

-- Umetnite zapis o kreditnoj kartici tipa MasterCard. �to se dogodilo? Je li redak uspje�no umetnut u tablicu?
INSERT INTO v3 (Tip, Broj,IstekMjesec, IstekGodina) 
VALUES ('MasterCard', '111222333444', 12, 2012)
GO

-- Promijenite pogled tako da dopu�ta umetanje/izmjenu redaka koji ne�e biti vidljivi kroz njega.
ALTER VIEW v3 AS
SELECT * FROM KreditnaKartica WHERE Tip IN ('Visa', 'MasterCard')
GO


/*
Napravite tablicu Film sa stupcima IDFilm, Naziv, GodinaProizvodnje, TrajanjeMinuta i KratkiOpis. Umetnite koji redak. 
Napravite pogled koji dohva�a sve iz tablice Film
Iskoristite pogled za dohva�anje podataka
Uklonite stupac TrajanjeMinuta iz tablice
Iskoristite pogled za dohva�anje podataka
Promijenite pogled tako da bude �vrsto vezan uz objekte koje koristi
Iskoristite pogled za dohva�anje podataka
Uklonite stupac GodinaProizvodnje iz tablice. Je li uklanjanje uspjelo? Za�to?
Uklonite pogled i tablicu
*/
CREATE TABLE Film
(
	IDFilm int CONSTRAINT PK_Film PRIMARY KEY IDENTITY,
	Naziv nvarchar(200) NOT NULL,
	GodinaProizvodnje int NOT NULL,
	TrajanjeMinuta int NOT NULL,
	KratkiOpis nvarchar(max) NOT NULL
)
GO
INSERT INTO Film (Naziv, GodinaProizvodnje, TrajanjeMinuta, KratkiOpis) 
	VALUES (N'O ma�kama i psima 2: Osveta Kitty Galore', 2010, 85, N'U vje�noj bitci ma�aka i pasa, jedna poludjela ma�ka odvest �e stvari jednu �apu predaleko. Kitty Galore, biv�a agentica �pijunske organizacije MIJAU, pobjegla je i skovala �avolji plan u kojem ne samo da �e poku�ati pripitomiti svoje vje�ne neprijatelje, ve� i svoje biv�e kolege ma�ke, ali i cjelokupno �ovje�anstvo. Suo�eni s ovom prijetnjom bez presedana, ma�ke i psi biti �e prisiljeni prvi put u povijesti udru�iti snage kako bi spasili sebe � ali i svoje vlasnike')
INSERT INTO Film (Naziv, GodinaProizvodnje, TrajanjeMinuta, KratkiOpis) 
	VALUES (N'Shrek uvijek i zauvijek', 2010, 95, N'Nakon �to se borio s opakim zmajem, spasio prekrasnu princezu i oslobodio �itavo kraljevstvo � kakav bi zadatak jo� mogao postojati u �ivotu slavnog Shreka? Odgovor je jasan: obitelj, odnosno svakodnevna bitka s malim nesta�nim Shreki�ima. Me�utim, sve �e to biti kratka vijeka, jer �e Shrek ubrzo upoznati lukavog Rumpelstiltskina i iznenada se na�i u potpuno drugoj dimenziji, alternativnoj budu�nosti u kojoj se on i Fiona nikad nisu susreli, u kojoj je ba� on ugro�ena vrsta, a Rumpelstiltskin kralj! Naravno, jedino je Shrek taj koji �e mo�i ispraviti novonastalu situaciju, spasiti prijatelje, obnoviti kraljevstvo i ponovno prona�i svoju pravu, jedinu ljubav.')
INSERT INTO Film (Naziv, GodinaProizvodnje, TrajanjeMinuta, KratkiOpis) 
	VALUES (N'Resident Evil: Drugi svijet', 2010, 90, N'Svijet je poharan virusnom infekcijom od koje oboljeli postaju zombiji. Alice (Milla Jovovich) pronalazi pre�ivjele i spa�ava ih. Njezina bitka s Umbrella Corporation dosti�e smrtonosne razine, no u pomo� joj priska�e stari prijatelj. U nadi da �e prona�i sigurno mjesto odlaze prema Los Angelesu. No, grad je preplavljen tisu�ama zombija i oni �e naletjeti u zamku')
GO

CREATE VIEW v4 AS
SELECT * FROM Film
GO

SELECT * FROM v4
GO

ALTER TABLE Film DROP COLUMN TrajanjeMinuta
GO

ALTER VIEW v4 
WITH SCHEMABINDING
AS
SELECT IDFilm, Naziv, GodinaProizvodnje, KratkiOpis FROM dbo.Film
GO

SELECT * FROM v4
GO

ALTER TABLE Film DROP COLUMN GodinaProizvodnje
GO

DROP VIEW v4
DROP TABLE Film
GO


/*
Napravite pogled koji dohva�a 10 proizvoda koji su najvi�e prodavani. Stupci koje pogled vra�a neka budu ID i naziv te ukupna koli�ina prodanih proizvoda.
Pogledajte SELECT upit pogleda kroz su�elje i pomo�u sistemske procedure sp_helptext
Za�titite pogled
Pogledajte SELECT upit pogleda kroz su�elje i pomo�u sistemske procedure sp_helptext
Promijenite pogled tako da bude za�ti�en i �vrsto vezan uz tablice
Promijenite pogled tako da bude za�ti�en, �vrsto vezan uz tablice i da ne dopu�ta izmjene koje ne�e biti vidljive kroz pogled
Uklonite pogled
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

DROP VIEW v5
GO


---------------- Vjezba 4
DBCC TRACEON(3604)
DBCC IND('AdventureWorksOBP', 'Drzava', -1)
-- a. DBCC IND vra�a 2 retka, ali samo jedan od njih ima PageType jednak 1. 
-- Dakle, svi podaci iz tablice su smje�teni na jednu stranicu.
-- b. PageFID = 1, PagePID = 77

DBCC PAGE('AdventureWorksOBP', 1, 77, 3) WITH TABLERESULTS
-- c. Za 1. redak imamo: "Slot 0 Offset 0x60 Length 31", dakle, njegova duljina je 31 bajta.
--    Za 2. redak imamo: "Slot 1 Offset 0x7f Length 31", dakle, njegova duljina je 31 bajta.
--    Za 3. redak imamo: "Slot 2 Offset 0x9e Length 53", dakle, njegova duljina je 53 bajta.
-- d. Reci su poslagani po stupcu IDDrzava, uzlazno od a prema z.
-- e. Redak ispred Njema�ka je Hrvatska, a iza je Bosna i Hercegovina.

-- Vje�be 2.
DBCC TRACEON(3604)
DBCC IND('AdventureWorksOBP', 'Proizvod', -1)

DBCC PAGE('AdventureWorksOBP', 1, 79, 3) WITH TABLERESULTS
DBCC PAGE('AdventureWorksOBP', 1, ???, 3) WITH TABLERESULTS

SELECT COUNT(*) FROM Proizvod
-- g. Ukupno stranica = ??
--    Ukupno redaka = 504
--    Prosje�no redaka po stranici = ??

-- Vje�be 3.
DBCC TRACEON(3604)
DBCC IND('AdventureWorksOBP', 'Kupac', -1)

DBCC PAGE('AdventureWorksOBP', 1, ???, 3) WITH TABLERESULTS

---------------------------------------
SET STATISTICS IO ON

-- Zadatak 1.
-- Optimizirajte upit:
-- SELECT PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 

-- a.) Koliko stranica pregled RDBMS?
SELECT PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 
-- (28 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 8, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 8

-- b.) Napravite indeks koji optimizira upit
CREATE NONCLUSTERED INDEX i1 ON Proizvod(PotkategorijaID)
GO

-- c.) Koliko sad stranica pregled RDBMS?
SELECT PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 
-- (28 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2

-- d.) Uklonite indeks
DROP INDEX Proizvod.i1
GO

-- Zadatak 2.
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

-- Zadatak 3.
-- Optimizirajte upit:
-- SELECT ProductID, Name, ProductSubcategoryID FROM Production.Product WHERE ProductSubcategoryID = 12 
SELECT IDProizvod, Naziv, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12
-- (28 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 8, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 8

CREATE NONCLUSTERED INDEX i1 ON Proizvod(PotkategorijaID)
GO

SELECT IDProizvod, Naziv, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12
-- (28 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 8, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 8

-- a) Poma�e li nam indeks iz prethodnog primjera? �to u�initi sa stupcem Naziv? 
-- logical reads 8 - mora i�i na klasterirani indeks jer mu nedostaje vrijednost za Naziv.
DROP INDEX Proizvod.i1
GO

CREATE NONCLUSTERED INDEX i1 ON Proizvod(PotkategorijaID) INCLUDE (naziv)
GO

SELECT IDProizvod, Naziv, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12
-- (28 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2 - sad ne mora i�i na klasterirani indeks.

DROP INDEX Proizvod.i1
GO

-- Zadatak 4.
-- Optimizirajte upit:
-- SELECT IDProizvod, Naziv, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 AND Naziv LIKE 'ML%'
SELECT IDProizvod, Naziv, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 AND Naziv LIKE 'ML%'
-- (8 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 8, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 8 - mora i�i na klasterirani indeks jer mu nedostaje vrijednost za Naziv.
CREATE NONCLUSTERED INDEX i1 ON Proizvod(PotkategorijaID) INCLUDE (naziv)
GO

SELECT IDProizvod, Naziv, PotkategorijaID FROM Proizvod WHERE PotkategorijaID = 12 AND Naziv LIKE 'ML%'
-- (8 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2 - sad ne mora i�i na klasterirani indeks.

DROP INDEX Proizvod.i1
GO

-- Zadatak 5.
-- Optimizirajte upit:
-- SELECT Boja, COUNT(*) AS Cnt FROM Proizvod WHERE PotkategorijaID = 12 GROUP BY Boja ORDER BY Cnt DESC
SELECT Boja, COUNT(*) AS Cnt FROM Proizvod WHERE PotkategorijaID = 12 GROUP BY Boja ORDER BY Cnt DESC
-- (2 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 8, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 8 - mora i�i na klasterirani indeks jer mu nedostaje vrijednost za Boja.
CREATE NONCLUSTERED INDEX i1 ON Proizvod(PotkategorijaID) INCLUDE (Boja)
GO

SELECT Boja, COUNT(*) AS Cnt FROM Proizvod WHERE PotkategorijaID = 12 GROUP BY Boja ORDER BY Cnt DESC
-- (2 row(s) affected)
-- Table 'Proizvod'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2 - sad ne mora i�i na klasterirani indeks.

DROP INDEX Proizvod.i1
GO

-- Zadatak 6.
-- Optimizirajte upit:
-- SELECT DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'  
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

-- Zadatak 7.
-- Optimizirajte upit:
-- SELECT IDRacun, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'  
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

-- Zadatak 8.
-- Optimizirajte upit:
-- SELECT IDRacun, BrojRacuna, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'  
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

-- a) Poma�e li nam indeks iz prethodnog primjera? �to u�initi sa stupcem BrojRacuna? 
-- logical reads 202 - mora i�i na klasterirani indeks jer mu nedostaje vrijednost za BrojRacuna.
DROP INDEX Racun.i1
GO

CREATE NONCLUSTERED INDEX i1 ON Racun(DatumIzdavanja) INCLUDE (BrojRacuna)
GO

SELECT IDRacun, BrojRacuna, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' 
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2 - sad ne mora i�i na klasterirani indeks.

DROP INDEX Racun.i1
GO

-- Zadatak 9.
-- Optimizirajte upit:
-- SELECT IDRacun FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' AND BrojRacuna LIKE 'S%'  
SELECT IDRacun FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' AND BrojRacuna LIKE 'S%' 
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 202

CREATE NONCLUSTERED INDEX i1 ON Racun(DatumIzdavanja) INCLUDE (BrojRacuna)
GO

SELECT IDRacun FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' AND BrojRacuna LIKE 'S%' 
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2 - sad ne mora i�i na klasterirani indeks.

DROP INDEX Racun.i1
GO

-- Zadatak 10.
-- Optimizirajte upit:
-- SELECT KupacID, COUNT(*) AS Cnt  FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' GROUP BY KupacID ORDER BY Cnt DESC
SELECT KupacID, COUNT(*) AS Cnt  FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' GROUP BY KupacID ORDER BY Cnt DESC
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 202

CREATE NONCLUSTERED INDEX i1 ON Racun(DatumIzdavanja) INCLUDE (KupacID)
GO

SELECT KupacID, COUNT(*) AS Cnt  FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' GROUP BY KupacID ORDER BY Cnt DESC 
-- (4 row(s) affected)
-- Table 'Racun'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
-- logical reads 2 - sad ne mora i�i na klasterirani indeks.

DROP INDEX Racun.i1
GO

/* VARIJABLE
Deklarirajte varijable @Ime i @Prezime i dodijelite im neke vrijednosti. 
Ispi�ite dodijeljene vrijednosti. */
DECLARE @Ime nvarchar(50)
DECLARE @Prezime nvarchar(50)

SET @Ime = 'Miro'
SET @Prezime = 'Miri�'

PRINT @Ime
PRINT @Prezime
PRINT 'Korisnik: ' + @Ime + ' ' + @Prezime
GO

/* VARIJABLE
Deklarirajte varijable @Ime i @Prezime i dodijelite im vrijednosti iz tablice Kupac za IDKupac jednak 8812. 
Ispi�ite dodijeljene vrijednosti. */
DECLARE @Ime nvarchar(50)
DECLARE @Prezime nvarchar(50)

SELECT @Ime = Ime, @Prezime = Prezime FROM Kupac WHERE IDKupac = 8812

PRINT 'Korisnik: ' + @Ime + ' ' + @Prezime
GO

/* VARIJABLE
Deklarirajte varijable @Ime i @Prezime i dodijelite im vrijednosti iz tablice Kupac tako da odaberete sve retke iz tablice. 
Ispi�ite dodijeljene vrijednosti. */
DECLARE @Ime nvarchar(50)
DECLARE @Prezime nvarchar(50)

SELECT @Ime = Ime, @Prezime = Prezime FROM Kupac

PRINT 'Korisnik: ' + @Ime + ' ' + @Prezime
GO

-----------------------------------------------------------------------------------
SET NOCOUNT ON
-----------------------------------------------------------------------------------

/* IF-ELSE IF-ELSE i SCOPE_IDENTITY()
Provjerite broj zapisa u tablici Kupac. 
Ako ih ima vi�e ili jednako 20000, ispi�ite �Postoji vi�e od 20000 kupaca :)�. 
Ako ih ima manje, ispi�ite �Jo� nismo dostigli 20000 kupaca :(� */
DECLARE @Broj int
SELECT @Broj = COUNT(*) FROM dbo.Kupac
IF @Broj >= 20000
	PRINT 'Postoji vi�e od 20000 kupaca :)'
ELSE
	PRINT 'Jo� nismo dostigli 20000 kupaca :('
GO

/* IF-ELSE IF-ELSE i SCOPE_IDENTITY()
Umetnite zapis u tablicu Drzava, generiranu IDENTITY vrijednost dodijelite nekoj varijabli pa je ispi�ite. */
DECLARE @NoviID int
INSERT INTO Drzava VALUES ('Gruzija')
SET @NoviID = SCOPE_IDENTITY()
PRINT @NoviID
GO

/* IF-ELSE IF-ELSE i SCOPE_IDENTITY()
Umetnite zapis u tablicu Drzava i u varijablu spremite generiranu IDENTITY vrijednost. 
Iskoristite tu vrijednost da biste za tu dr�avu umetnuli dva grada. */
DECLARE @IDDrzavaNovi int
INSERT INTO Drzava VALUES ('Kina')
select SCOPE_IDENTITY()
SET @IDDrzavaNovi = SCOPE_IDENTITY()

INSERT INTO Grad VALUES ('�angaj', @IDDrzavaNovi)
INSERT INTO Grad VALUES ('Peking', @IDDrzavaNovi)
GO

/* PROCEDURE BEZ PARAMETARA
Napi�ite proceduru koja dohva�a sve retke iz tablice Drzava. 
Pozovite proceduru. 
Promijenite proceduru tako da vra�a rezultate poredane padaju�e po nazivu dr�ave. 
Uklonite proceduru. */
CREATE PROC p7
AS
SELECT * FROM Drzava
GO

EXEC p7
GO

ALTER PROC p7
AS
SELECT * FROM Drzava ORDER BY Naziv DESC
GO

EXEC p7
GO

DROP PROC p7
GO

/* PROCEDURE BEZ PARAMETARA
Napi�ite proceduru koja dohva�a prvih 5 redaka iz tablice Racun, prvih 5 redaka iz tablice Stavka i prvih 5 redaka iz tablice Proizvod. 
Pozovite proceduru. 
Uklonite proceduru. */
CREATE PROC p8
AS
SELECT TOP 5 * FROM Racun
SELECT TOP 5 * FROM Stavka
SELECT TOP 5 * FROM Proizvod
GO

EXEC p8
GO

DROP PROC p8
GO

/* PROCEDURE S ULAZNIM PARAMETRIMA
Napi�ite proceduru koja prima @ID proizvoda i vra�a samo taj proizvod iz tablice Proizvod. 
Pozovite proceduru na oba na�ina. 
Uklonite proceduru. */
CREATE PROC p9
	@IDPr int
AS
SELECT * FROM Proizvod WHERE IDProizvod = @IDPr
GO

EXEC p9 1
EXEC p9 @IDPr = 1
GO

DROP PROC p9
GO

/* PROCEDURE S ULAZNIM PARAMETRIMA
Napi�ite proceduru koja prima dvije cijene i vra�a nazive i cijene svih proizvoda �ija je cijena u zadanom rasponu. 
Pozovite proceduru na oba na�ina. 
Uklonite proceduru. */
CREATE PROC p10
	@Cijena1 money,
	@Cijena2 money
AS
SELECT Naziv, CijenaBezPDV FROM Proizvod WHERE CijenaBezPDV BETWEEN @Cijena1 AND @Cijena2
GO

EXEC p10 500, 1000
EXEC p10 @Cijena1 = 500, @Cijena2 = 1000
EXEC p10 @Cijena2 = 1000, @Cijena1 = 500
GO

DROP PROC p10
GO

/* PROCEDURE S ULAZNIM PARAMETRIMA
Napi�ite proceduru koja prima naziv dr�ave i naziv grada. 
Neka procedura umetne grad koji pripada zadanoj dr�avi. 
Pazite na to postoji li ve� dr�ava upisana u tablicu Drzava ili ne postoji. 
Ako postoji, nemojte je umetati ponovno. 
Pozovite proceduru za dr�avu �Japan� i grad �Osaka�. 
Pozovite proceduru za dr�avu �Japan� i grad �Tokyo� i potvrdite da radi ispravno. 
Uklonite proceduru. */
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
SELECT * FROM Grad
SELECT * FROM Drzava

EXEC p11 'Japan', 'Tokyo'
SELECT * FROM Grad
SELECT * FROM Drzava
GO

DROP PROC p11
GO

/* PROCEDURE S IZLAZNIM PARAMETRIMA
Napi�ite proceduru koja prima parametre @IDProizvod i @Boja. Parametar @Boja neka bude izlazni parametar. 
Neka procedura za zadani proizvod vrati njegovu boju pomo�u izlaznog parametra. 
Pozovite proceduru i ispi�ite vra�enu vrijednost. 
Uklonite proceduru. */
CREATE PROC p12
	@IDProizvod int,
	@Boja nvarchar(15) OUTPUT
AS
SELECT @Boja = Boja FROM Proizvod WHERE IDProizvod = @IDProizvod
GO

DECLARE @Farba nvarchar(15)
EXEC p12 320, @Farba OUTPUT
PRINT @Farba
GO

DROP PROC p12
GO

/* PROCEDURE S IZLAZNIM PARAMETRIMA
Napi�ite proceduru koja prima kriterij po kojemu �ete filtrirati prezimena iz tablice Kupac. 
Neka procedura pomo�u izlaznog parametra vrati broj zapisa koji zadovoljavaju zadani kriterij. 
Neka procedura vrati i sve zapise koji zadovoljavaju kriterij. 
Pozovite proceduru i ispi�ite vra�enu vrijednost. 
Uklonite proceduru. */
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

DROP PROC p13
GO

/* PROCEDURE S IZLAZNIM PARAMETRIMA
Napi�ite proceduru koja za zadanog komercijalistu pomo�u izlaznih parametara vra�a njegovo ime 
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

DROP PROC p14
GO

/* DODATNI ZADACI
Napi�ite proceduru koja ume�e novu kategoriju i kroz izlazni parametar vra�a generiranu IDENTITY vrijednost. 
Ako ve� postoji kategorija zadanog imena, ne treba je upisivati ponovno i u tom slu�aju kroz izlazni parametar vratite vrijednost -1. 
Pozovite proceduru i ispi�ite vra�enu vrijednost. 
Uklonite proceduru. */
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

/* DODATNI ZADACI
Napi�ite proceduru koja ume�e novu kategoriju i kroz izlazni parametar vra�a generiranu IDENTITY vrijednost. 
Ako ve� postoji kategorija zadanog imena, ne treba je upisivati ponovno i u tom slu�aju kroz izlazni parametar vratite vrijednost -1. 
Pozovite proceduru i ispi�ite vra�enu vrijednost. 
Uklonite proceduru. */
CREATE PROC p15
	@Kategorija nvarchar(50),
	@ID int OUTPUT
AS
DECLARE @Broj int
SELECT @Broj = COUNT(*) FROM Kategorija WHERE Naziv = @Kategorija

IF @Broj = 0 BEGIN
	INSERT INTO Kategorija VALUES (@Kategorija)
	SET @ID = SCOPE_IDENTITY()
END
ELSE BEGIN
	SET @ID = -1
END
GO

DECLARE @ID int
EXEC p15 'Gla�ala', @ID OUTPUT
PRINT @ID
GO

DECLARE @ID int
EXEC p15 'Gla�ala', @ID OUTPUT
PRINT @ID
GO

DROP PROC p15
GO

/* DODATNI ZADACI
Napi�ite proceduru koja kroz tri izlazna parametra vra�a najmanju, najve�u i prosje�nu cijenu proizvoda iz tablice Proizvod. 
Neka procedura vrati i sve proizvode koji imaju cijenu ve�u od 0 i manju od prosje�ne. 
Pozovite proceduru, ispi�ite vra�ene vrijednosti i uklonite proceduru. */
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

DROP PROC p16
GO

/* PROCEDURE S RETURN PARAMETRIMA
Napi�ite proceduru koja prima ime i prezime osobe 
i vra�a 0 kao RETURN parametar ako osoba postoji u tablici, 
odnosno 200 ako osoba ne postoji. 
Pozovite proceduru i ispi�ite RETURN vrijednost.  */
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

/* PROCEDURE S RETURN PARAMETRIMA
Promijenite proceduru iz prethodnog zadatka tako da bude za�ti�ena. */
ALTER PROC p15
	@Ime nvarchar(50),
	@Prezime nvarchar(50)
WITH ENCRYPTION
AS
DECLARE @BrojOsoba int
SELECT @BrojOsoba = Count(*) FROM Kupac WHERE Ime = @Ime AND Prezime = @Prezime

IF @BrojOsoba = 0
	RETURN 200
ELSE
	RETURN 0
GO

/* ODGO�ENA PROVJERA REFERENCI
Napravite tablicu Student koja se sastoji od stupaca 
IDStudent, Ime, Prezime i JMBAG. 
Napi�ite proceduru koja vra�a ime i prezime 
iz te tablice i pozovite je. */
CREATE TABLE Student
(
	IDStudent int PRIMARY KEY IDENTITY,
	Ime nvarchar(50),
	Prezime nvarchar(50),
	JMBAG char(11)
)
GO

CREATE PROC p18
AS
SELECT Ime, Prezime FROM Student
GO

EXEC p18
GO

/* ODGO�ENA PROVJERA REFERENCI
Promijenite proceduru tako da uz ime i prezime 
vra�a i datum ro�enja (nepostoje�i stupac!). 
�to se desilo? */
ALTER PROC p18
AS
SELECT Ime, Prezime, DatumRodjenja FROM Student
GO

/* ODGO�ENA PROVJERA REFERENCI
Promijenite proceduru tako da vra�a sve zapise 
iz tablice IzmisljenaTablica. 
�to se desilo? 
Pokrenite proceduru. 
�to se desilo? */
ALTER PROC p18
AS
SELECT * FROM IzmisljenaTablica
GO

EXEC p18
GO

/* ODGO�ENA PROVJERA REFERENCI
Napravite tablicu IzmisljenaTablica 
i pokrenite proceduru. 
�to se desilo? */
CREATE TABLE IzmisljenaTablica(
	IDIzmisljenaTablica int PRIMARY KEY IDENTITY,
	IzmisljeniStupac nvarchar(50)
)
GO

EXEC p18
GO

/* CRUD OPERACIJE
Svaka operacija posebno.
Napravite procedure koje rade CRUD operacije 
na tablici Student tako da svakoj operaciji 
dodijelite posebnu proceduru. 
Iskoristite procedure za umetanje, izmjenu, 
dohva�anje i brisanje zapisa. */
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

/* CRUD OPERACIJE
INSERT/UPDATE zajedno, ostalo posebno.
Napravite procedure koje rade CRUD operacije na tablici Student 
tako da operacije umetanja i izmjene obavite u jednoj proceduri, 
a druge dvije operacije obavite u posebnim procedurama. 
Iskoristite procedure za umetanje, izmjenu, dohva�anje i brisanje zapisa. */
CREATE PROC MergeStudent
	@IDStudent int OUTPUT, 
	@Ime nvarchar(50), 
	@Prezime nvarchar(50), 
	@JMBAG char(11)
AS
IF Exists(SELECT * FROM Student WHERE IDStudent = @IDStudent)
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

/* CRUD OPERACIJE
UPDATE/INSERT/DELETE zajedno.
Napravite procedure koje rade CRUD operacije na tablici Student 
tako da operacije umetanja, izmjene i brisanja obavite u jednoj proceduri, 
a dohva�anje u drugoj. 
Iskoristite procedure za umetanje, izmjenu, dohva�anje i brisanje zapisa. */
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