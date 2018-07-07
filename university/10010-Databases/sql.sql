create database Test
go
use Test

create table Drzava(
    IDDrzava int primary key identity,
    Naziv nvarchar(50),
)

create table Grad(
    IDGrad int primary key identity,
    Naziv nvarchar(50),
    DrzavaID int foreign key references Drzava(IDDrzava)
)

create table Kupac(
    IDKupac int primary key identity,
    Ime nvarchar(50),
    Prezime nvarchar(50),
    Email nvarchar(100),
    Telefon nvarchar(100),
    GradID int foreign key references Grad(IDGrad)
)
------------------ Zadatak 1
-- Prebacimo se na bazu LosFilm nastalu iz skripte RVS-UUBP-LosFilm_Baza.sql
USE LosFilm;

-- Ubacite u tablicu Clan dva nova �lana:  Ivana Skerlecza iz Vrbovca i Petra Berislavi�a iz Trogira.
-- prvo pokupimo ID-eve mjesta za Vrbovec i pogledamo koji je zadnji ID za �lana
SELECT * FROM Mjesto WHERE Naselje LIKE 'Vrbovec';
SELECT TOP 1 ID FROM Clan ORDER BY ID DESC;
-- pogledajmo tablicu �lanova prije ubacivanja
SELECT * FROM Clan;
-- napravimo ubacivanje
INSERT INTO Clan (ID,ImePrezime,MjestoID) VALUES (8,'Ivan Skerletza',8);
-- pogledajmo tablicu �lanova nakon ubacivanja
SELECT * FROM Clan;
-- zatim pokupimo ID-eve mjesta za Trogir
SELECT * FROM Mjesto WHERE Naselje LIKE 'Trogir';
-- ustanoviti �emo da nema Trogira pa ga ubacujemo
INSERT INTO Mjesto VALUES (21220,'Trogir','Trogir','Splitsko-Dalmatinska')
-- zatim pokupimo ID-eve mjesta za Trogir
SELECT * FROM Mjesto WHERE Naselje LIKE 'Trogir';
-- zatim pogledamo koji je zadnji ID za �lana
SELECT TOP 1 ID FROM Clan ORDER BY ID DESC;
-- pogledajmo tablicu �lanova prije ubacivanja
SELECT * FROM Clan;
-- napravimo ubacivanje
INSERT INTO Clan (ID,ImePrezime,MjestoID) VALUES (9,'Petar Berislavi�',451)
-- pogledajmo tablicu �lanova nakon ubacivanja
SELECT * FROM Clan;

-- Ubacite u tablicu Film dva filma koja dolaze na Blu-ray disku: �Blade runner� i �Prohujalo s vihorom�. 
-- Ostale podatke koje trreba ubaciti potra�ite na internetu.
-- pogledajmo tablicu medija prije ubacivanja da provjerimo da li imamo Blu-ray kao medij
SELECT * FROM Medij;
-- pogledamo koji je zadnji ID za medij
SELECT TOP 1 ID FROM Medij ORDER BY ID DESC;
-- napravimo ubacivanje
INSERT INTO Medij VALUES (5,'Blue Ray');
-- pogledajmo tablicu medija nakon ubacivanja
SELECT * FROM Medij;
-- Zatim pogledajmo tablice filmova i �anrova prije ubacivanja podataka
SELECT * FROM Film ORDER BY ID;
SELECT * FROM Zanr ORDER BY ID;
-- ubacimo filmove sa IMDB-a: �Blade runner� i �Prohujalo s vihorom�
INSERT INTO Film (ID,MedijID,Naziv,Trajanje,ZanrID) VALUES (10,5,'Bladerunner',125,3);
INSERT INTO Film (ID,MedijID,Naziv,Trajanje,ZanrID) VALUES (11,5,'Prohujalo s vihorom',154,6);
-- Zatim pogledajmo tablice filmova poslije ubacivanja podataka
SELECT * FROM Film ORDER BY ID;

-- Filmu �The matrix reloaded� dodajte:
--   - jo� jednog glavnog glumca: Monica Bellucci, 
--   - jo� jednog sporednog glumca: Valerie Berry, 
--   - �anr promijenite u�Triler�, 
--   - promijenite opis na hrvatski. 
-- Sve je potrebno napraviti jednim upitom.
-- Zatim pogledajmo tablice filmova i �anrova prije promjene podataka
SELECT * FROM Film ORDER BY ID;
SELECT * FROM Zanr ORDER BY ID;
SELECT * FROM Film WHERE ID = 1;
-- odjednom mjenjamo podatke dodavanjem na ve� postoje�i sadr�aj u poljima i promjenom �anra
UPDATE Film
	SET GlavniGlumci = GlavniGlumci + ', Monica Belluci',
		SporedniGlumci = SporedniGlumci + ', Valerie Berry',
		ZanrID = 3
	WHERE ID = 1;
-- Zatim pogledajmo tablicu filmova poslije promjene podataka
SELECT * FROM Film WHERE ID = 1;

-- d zadatak Dodajte nove posudbe: 
-- Posudba 1: Skerlecz je posudio Matrix Reloaded  16.04.1914. i vratio ga tri dana kasnije te za to platio zakasninu od 15kn. 
-- Prilikom vra�anja je posudio tre�i nastavak i vratio ga za 2 dana. Prona�imo koji je �lan Skerlecz
SELECT * FROM Clan WHERE ImePrezime LIKE '%Skerlet%';
-- Prona�imo koji je film Matrix Reloaded
SELECT * FROM Film WHERE Naziv LIKE '%Matrix Reloaded%';
-- Pogledajmo tablicu posudbi prije promjene podataka	
SELECT * FROM Posudba;
-- ubacimo podatke za Matrix Reloaded sa posudbom 16.04.1914. i vra�anjem tri dana kasnije
INSERT INTO Posudba VALUES (1,8,'1914-04-16','1914-04-19');
-- Pogledajmo tablicu posudbi nakon promjene podataka	
SELECT * FROM Posudba;
-- Prona�imo koji je film tre�i nastavak Matrix-a
SELECT * FROM Film WHERE Naziv LIKE '%Matrix%';
-- ubacimo podatke za The Matrix Revolutions sa posudbom 19.04.1914. i vra�anjem 2 dana kasnije
INSERT INTO Posudba VALUES (4,8,'1914-04-19','1914-04-21');
-- Pogledajmo tablicu posudbi nakon promjene podataka	
SELECT * FROM Posudba;
-- Rije�imo i zakasninu od 15kn za Matrix Reloaded posu�en 16.04.1914. i vra�en tri dana kasnije
-- Pogledajmo tablicu zakasnina prije promjene podataka	
SELECT * FROM Zakasnina;
-- ubacimo zakasninu
INSERT INTO Zakasnina VALUES (8,1,'1914-04-19',15.00);
-- Pogledajmo tablicu zakasnina nakon promjene podataka	
SELECT * FROM Zakasnina;

-- Petar Berislavi� je posudio Prohujalo s vihorom 20.05.1799. i vratio za 10 dana pri tome plativ�i 16kn zakasnine.
-- Prona�imo koji je �lan Petar Berislavi�
SELECT * FROM Clan WHERE ImePrezime LIKE '%Petar Berislavi�%';
-- Prona�imo koji je film Prohujalo s vihorom
SELECT * FROM Film WHERE Naziv LIKE '%Prohujalo s vihorom%';
-- Pogledajmo tablicu posudbi prije promjene podataka	
SELECT * FROM Posudba;
-- ubacimo podatke za Prohujalo s vihorom sa posudbom 20.05.1799. i vra�anjem za 10 dana
INSERT INTO Posudba VALUES (11,9,'1799-05-20','1799-05-30');
-- Pogledajmo tablicu posudbi nakon promjene podataka	
SELECT * FROM Posudba;
-- Rije�imo i zakasninu od 16kn za taj film
-- Pogledajmo tablicu zakasnina prije promjene podataka	
SELECT * FROM Zakasnina;
-- ubacimo zakasninu
INSERT INTO Zakasnina VALUES (9,11,'1799-05-30',16.00);
-- Pogledajmo tablicu zakasnina nakon promjene podataka	
SELECT * FROM Zakasnina;

-- Pero Peri� je danas vratio sve posu�ene filmove i platio zakasninu od 2kn po danu.
-- Prvo prona�imo �lana Pero Peri�
SELECT * FROM Clan WHERE ImePrezime LIKE '%Pero Peri�%';
-- Prona�imo koje je filmove posudio Pero Peri�
SELECT * FROM Posudba WHERE ClanID = 1;
-- Posu�eni su oni filmovi kojima je DatumVracanja NULL - prona�imo te posudbe
SELECT * FROM Posudba WHERE ClanID = 1 AND DatumVracanja IS NULL;
-- dobili smo da je posu�en samo film sa ID-om 1
-- Vratimo te filmove sa dana�njim datumom
UPDATE Posudba
SET DatumVracanja = '2011-04-27'
WHERE ClanID = 1 AND DatumVracanja IS NULL;
-- Provjerimo promjenu
SELECT * FROM Posudba WHERE ClanID = 1 AND FilmID = 1;
-- rije�imo i zakasninu od 2kn po danu za taj film
-- provjerimo ima li kakve zakasnine po tom �lanu
SELECT	* FROM Zakasnina WHERE ClanID = 1;
-- ubacimo iznos zakasnine (ovdje je proizvoljno izra�unata)
INSERT INTO Zakasnina VALUES (1,1,'2011-04-27',100.55);
-- provjerimo ubacivanje
SELECT	* FROM Zakasnina WHERE ClanID = 1;

-- Obri�ite sve posudbe od Ane Mili�. prona�imo Anu Mili�
SELECT * FROM Clan WHERE ImePrezime LIKE '%Ana Mili�%';
-- prona�imo njene posudbe
SELECT * FROM Posudba WHERE ClanID = 2;
-- pobri�imo njene posudbe
DELETE FROM Posudba	WHERE ClanID = 2;
-- provjerimo brisanje - ne bi smjelo biti vra�enih redaka
SELECT * FROM Posudba WHERE ClanID = 2;
-----------------------------------------------------------------
-- Prebacimo se na bazu AdventureWorksOBP
USE AdventureWorksOBP;

-- 3a) Ispi�ite sve mu�ke kupce iz tablice Kupac.
-- pripremni upiti
SELECT * FROM Kupac;
-- zavr�ni upit
SELECT * FROM Kupac WHERE Ime NOT LIKE '%a';

-- 3b) Ispi�ite sve kupce kojima prezime zapo�inje s �Van�.
-- pripremni upiti
SELECT * FROM Kupac;
-- zavr�ni upit
SELECT * FROM Kupac WHERE Prezime LIKE 'Van%';

-- 3c) Dodajte kupcu Vargas Gary-ju sufiks �tre�i�.
-- pripremni upiti
SELECT * FROM Kupac WHERE Ime='Gary' AND Prezime='Vargas';
-- zavr�ni upit - IDKupac je 892
SELECT * FROM Kupac WHERE IDKupac = 892;
UPDATE Kupac
	SET Prezime = Prezime + ' tre�i' 
	WHERE IDKupac = 892;
SELECT * FROM Kupac WHERE IDKupac = 892;

-- a) Ispi�ite sve kupce koji se zovu Ana ili Tamara i iz Osijeka su.
-- pripremni upit
SELECT * FROM Grad WHERE Naziv='Osijek'

-- zavr�ni upit
SELECT *  FROM Kupac  WHERE (ime='ana' or ime='tamara') AND GradID=2

-- b) Ispi�ite sve kupce �ije prezime zapo�inje slovom "D" i prezime sadr�ava string "re�.
SELECT *  FROM Kupac WHERE Prezime LIKE 'D%re%'

-- c) Ispi�ite samo prezimena polovice prvih osoba koje se zovu "Jack�.
SELECT TOP 50 PERCENT Prezime FROM Kupac WHERE Ime='Jack'

-- 3e) Svim kupcima koji nemaju unesen sufiks, promijenite (dodajte) ga kao string �nema�.
-- pripremni upiti
SELECT * FROM Kupac WHERE Prezime NOT LIKE '% %';
-- zavr�ni upit
SELECT * FROM Kupac WHERE Prezime NOT LIKE '% %';
UPDATE Kupac
	SET Prezime = Prezime + ' nema' 
	WHERE Prezime NOT LIKE '% %';
SELECT * FROM Kupac WHERE Prezime LIKE '% nema';

--ispisite sve clanove iz tablice clan cije imeprezime zavrsava na k
select imeprezime from clan where ImePrezime like '%k'

--ispisite nazive mjesta iz tablice mjesto koja zapocinju sa Ve
select naziv from Mjesto where naziv like 'Ve%'

--ispisite sve filmove iz tablice film koji imaju rjec Matrix
select naziv from film  where naziv like '%matrix%'

--ispisite sva mjesta iz tablice mjesto ciji s enaziv sastoji od 1 rjeci
select naziv from mjesto where naziv not like '% %'

--ispisite sva mjesta iz tablice mjesto koji su iz ...
select * from mjesto where zupanija in ('zagreba�ka', 'zadarska', 'me�imurska')

--ispisite sva mejsta iz tablice mjesto koja nisu iz IS i KC
select * from mjesto where zupanija not in ('istarska', 'karlova�ka')

--dodajte clanu pero peric sufiks mladi
select * from clan where ImePrezime ='pero peri�'
update clan set ImePrezime=ImePrezime + ' mla�i' where ImePrezime ='pero peri�'

--iz tablice clan ispisite sve clanove s nazivima stupaca kao na slici
select ImePrezime as 'Ime i prezime', ulica + ' ' + KucniBroj as Adresa
from Clan
-----------------------
Zadatak 1: Hotel
Korisnički zahtjevi: Treba napraviti bazu podataka koja će omogućiti praćenje zauzeća nekog hotela. Pritom je hotel klasificiran određenim brojem zvjezdica. Broj zvjezdica može biti od 1 do 5, predefinirana vrijednost je 3 zvjezdice. Hotel ima sobe od kojih svaka ima svoju oznaku i broj kreveta. Gosti obavezno imaju OIB.
CREATE DATABASE Hotel
USE Hotel
CREATE TABLE Hotel (
	IDHotel	INT IDENTITY(1,1),
	Naziv	NVARCHAR(25) NOT NULL,
	BrojZvjezdica	INT NOT NULL 
		CONSTRAINT DF_BrojZvjezdica DEFAULT 3
		CONSTRAINT CH_BrojZvjezdica CHECK (BrojZvjezdica BETWEEN 1 AND 5),
	Adresa	NVARCHAR(25) NOT NULL,
	Grad	NVARCHAR(25) NOT NULL
	CONSTRAINT PK_Hotel PRIMARY KEY (IDHotel)
)
CREATE TABLE Soba (
	IDSoba	INT IDENTITY(1,1),
	Oznaka	CHAR(5) NOT NULL,
	Tip		NVARCHAR(25) NOT NULL,
	BrojGostiju INT NOT NULL,	
	HotelID	INT NOT NULL
	CONSTRAINT PK_Soba PRIMARY KEY (IDSoba),
	CONSTRAINT FK_Soba_Hotel FOREIGN KEY (HotelID) REFERENCES Hotel(IDHotel)
)
CREATE TABLE Gost (
	IDGost	INT IDENTITY(1,1),
	Ime	NVARCHAR(25) NOT NULL,
	Prezime	NVARCHAR(25) NOT NULL,
	OIB CHAR(11) NOT NULL CONSTRAINT UQ_OIB UNIQUE,
	CONSTRAINT PK_Gost PRIMARY KEY (IDGost)
)
CREATE TABLE Zauzece (
	IDZauzece	INT IDENTITY(1,1),
	GostID	INT NOT NULL,
	SobaID	INT NOT NULL,
	DatumOd	DATETIME NOT NULL,
	DatumDo	DATETIME NOT NULL,
	CONSTRAINT PK_Zauzece PRIMARY KEY (IDZauzece),
	CONSTRAINT FK_Zauzece_Gost FOREIGN KEY (GostID) REFERENCES Gost(IDGost),
	CONSTRAINT FK_Zauzece_Soba FOREIGN KEY (SobaID) REFERENCES Soba(IDSoba),
	CONSTRAINT UQ_Zauzece UNIQUE (GostID, SobaID, DatumOd, DatumDo)
)