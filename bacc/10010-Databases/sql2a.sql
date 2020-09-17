--umetanje
INSERT INTO tablica(dtupac_1,...)
VALUES (vrijednsot_1,...) 

--mjenjanje
UPDATE tablica
SET stupac_1=vrijednost_1,...
WHERE uvijet

--brisanje
DELETE FROM tablica

--odabiranje stupca...
SELECT stupac FROM tablica
WHERE stupac='vrijednost u redu' AND a='b' --...i reda

--funcije
WHERE datum BETWEEN 2000 and 2001
WHERE zanr IN ('pop','rock')
SELECT max(iznos) FROM racuni

--podupiti, upiti za pojedine stvari, spojeni
SELECT izvodac 
FROM albumi 
WHERE datum_izdanja = (
    SELECT max(datum_izdanja) 
    from albumi
)

--spajanje
SELECT iz.ime, tr.ime  -- <-ovisi o sredistu
FROM izvodaci as iz    --srediste
INNER JOIN trake as tk --srediste
    ON izvodaci.imeID = trake.id -- <-ovisi o sredistu 

-- Prebacimo se na bazu LosFilm4
USE LosFilm4;

--Zadatak 1.
--a) Ispišite naziv, trajanje i žanr svih filmova u bazi
SELECT 
	Film.Naziv AS 'Film', 
	Film.Trajanje, 
	Zanr.Naziv AS 'Žanr'
	FROM Film
	INNER JOIN Zanr ON Zanr.ID = Film.ZanrID;

--b) Ispišite ime i prezime, adresu, kućni broj, poštanski broj i naselje svakog od članova u videoteci
SELECT 
	Clan.ImePrezime AS 'Ime i prezime', 
	Clan.Ulica + ' ' + Clan.KucniBroj AS 'Adresa',
	Mjesto.PostanskiBroj AS 'Poštanski broj',
	Mjesto.Naselje
	FROM Clan
	INNER JOIN Mjesto ON Mjesto.ID = Mjesto.ID;

--c) Ispišite naziv, trajanje i žanr svih filmova u bazi koji su snimljeni na DVD-u
-- pripremni upiti - nalaženje ID-a medija koji je DVD
SELECT ID FROM Medij WHERE Medij.Naziv = 'DVD';
-- završni upit
SELECT 
	Film.Naziv AS 'Film', Film.Trajanje, Zanr.Naziv AS N'Žanr'
	FROM Film
	INNER JOIN Zanr ON Zanr.ID = Film.ZanrID
	WHERE Film.MedijID = 1;
	
---------------------------------------------------------------------------------------
--Zadatak 2.
--a) Ispišite sve nazive filmova i pripadne medije (naziv medija) za svaki film.
-- pripremni upiti
SELECT * FROM Film;
SELECT * FROM Medij;
-- završni upit
SELECT
	Film.Naziv AS 'Naziv filma',
	Medij.Naziv AS 'Naziv medija'
FROM Film
INNER JOIN Medij ON Film.MedijID = Medij.ID;


--b) Ispišite sve nazive filmova, pripadne medije i žanr svakog filma.
-- pripremni upiti
SELECT * FROM Film;
SELECT * FROM Medij;
SELECT * FROM Zanr;
-- završni upit
SELECT
	Film.Naziv AS 'Naziv filma',
	Medij.Naziv AS 'Naziv medija',
	Zanr.Naziv AS 'Naziv žanra'	
FROM Film
INNER JOIN Medij ON Film.MedijID = Medij.ID
INNER JOIN Zanr  ON Film.ZanrID  = Zanr.ID;


--c) Ispišite za jednog člana sve filmove koje je posudio (člana biramo po njegovoj ID oznaci).
-- pripremni upiti
SELECT * FROM Clan;
SELECT * FROM Film;
SELECT * FROM Posudba;
-- završni upit za člana sa ID-om 1
SELECT DISTINCT
	Posudba.ClanID,
	Film.Naziv
FROM Posudba
INNER JOIN Film ON Film.ID = Posudba.FilmID
WHERE ClanID = 1;


--d) Za neki film ispišite sve članove koji su ga posuđivali, složeno po imenu i prezimenu člana.
-- pripremni upiti
SELECT * FROM Film;
SELECT * FROM Clan;
SELECT * FROM Posudba;
-- završni upit
SELECT DISTINCT
	Film.Naziv,
	Clan.ImePrezime
FROM Posudba
INNER JOIN Film ON Film.ID = Posudba.FilmID
INNER JOIN Clan ON Clan.ID = Posudba.ClanID
WHERE Film.ID = 1
ORDER BY Clan.ImePrezime;

--e) Ispišite imena i prezimena te pune adrese svih članova koji su platili zakasninu.
-- pripremni upiti
SELECT * FROM Clan;
SELECT * FROM Mjesto;
SELECT * FROM Zakasnina;
-- završni upit
SELECT DISTINCT
	Clan.ImePrezime,
	Clan.Ulica + ' ' + 
		RTRIM(CAST(Clan.KucniBroj AS NVARCHAR)) + ', ' + 
			CAST(Mjesto.PostanskiBroj AS NVARCHAR) + ' ' + 
				Mjesto.Naselje
					AS 'Puna adresa'
FROM Zakasnina
INNER JOIN Clan ON Clan.ID = Zakasnina.ClanID
INNER JOIN Mjesto ON Mjesto.ID = Clan.MjestoID;

--f) Ispišite nazive svih filmova i u koja sva mjesta su posuđivani.
-- pripremni upiti
SELECT * FROM Film;
SELECT * FROM Clan;
SELECT * FROM Mjesto;
SELECT * FROM Posudba;
-- završni upit
SELECT DISTINCT
	Film.Naziv AS 'Naziv filma',
	Mjesto.Naziv AS 'Naziv mjesta'
FROM Posudba
INNER JOIN Film   ON Film.ID   = Posudba.FilmID
INNER JOIN Clan   ON Clan.ID   = Posudba.ClanID
INNER JOIN Mjesto ON Mjesto.ID = Clan.ID;

--g) Ispišite ime i prezime člana te koje je sve žanrove filmova posuđivao (pazite na ‘dupliće’).
-- pripremni upiti
SELECT * FROM Film;
SELECT * FROM Zanr;
SELECT * FROM Clan;
SELECT * FROM Posudba;
-- završni upit
SELECT DISTINCT
	Clan.ImePrezime,
	Zanr.Naziv	
FROM Posudba
INNER JOIN Film ON Film.ID = Posudba.FilmID
INNER JOIN Zanr ON Zanr.ID = Film.ID
INNER JOIN Clan ON Clan.ID = Posudba.ClanID;

--h) Ispišite imena i prezimena te pune adrese svih članova koji su platili zakasninu za neki film i koji je to film (3 spajanja).
-- pripremni upiti
SELECT * FROM Clan;
SELECT * FROM Mjesto;
SELECT * FROM Zakasnina;
SELECT * FROM Film;
-- završni upit
SELECT DISTINCT
	Clan.ImePrezime,
	Clan.Ulica + ' ' + 
		RTRIM(CAST(Clan.KucniBroj AS NVARCHAR)) + ', ' + 
			CAST(Mjesto.PostanskiBroj AS NVARCHAR) + ' ' + 
				Mjesto.Naselje
					AS 'Puna adresa',
	Film.Naziv
FROM Zakasnina
INNER JOIN Clan ON Clan.ID = Zakasnina.ClanID
INNER JOIN Mjesto ON Mjesto.ID = Clan.MjestoID
INNER JOIN Film ON Film.ID = Zakasnina.FilmID;


--i) Ispišite naziv filma i naziv mjesta u koje je posuđen dani film (3 spajanja).
-- pripremni upiti
SELECT * FROM Clan;
SELECT * FROM Mjesto;
SELECT * FROM Posudba;
SELECT * FROM Film;
-- završni upit
SELECT DISTINCT
	Film.Naziv AS 'Naziv filma',
	Mjesto.Naziv AS 'Naziv mjesta'
FROM Posudba
INNER JOIN Clan ON Clan.ID = Posudba.ClanID
INNER JOIN Mjesto ON Mjesto.ID = Clan.MjestoID
INNER JOIN Film ON Film.ID = Posudba.FilmID
WHERE Film.ID = 1;



-- Zadatak 3
-- Prebacimo se na bazu AdventureWorksOBP
USE AdventureWorksOBP;

-----------------------------------------------------------------
-- 3a) Ispi�ite popis ra�una (datum, ukupan iznos, naziv kupca)
-- pripremni upiti
SELECT * FROM Kupac;
SELECT * FROM Racun;
SELECT * FROM Stavka;
-- zavr�ni upit
SELECT DISTINCT
	Racun.DatumIzdavanja AS 'Datum',
	Stavka.UkupnaCijena AS 'Ukupan iznos',
	Kupac.Ime+' '+Kupac.Prezime AS 'Kupac'
FROM Racun
INNER JOIN Kupac  ON Kupac.IDKupac  = Racun.KupacID
INNER JOIN Stavka ON Stavka.RacunID = Racun.IDRacun;
-----------------------------------------------------------------

-----------------------------------------------------------------
-- 3b) Za nekog kupca ispi�ite svu robu koju je kupovao.
-- pripremni upiti
SELECT * FROM Kupac;
SELECT * FROM Racun;
SELECT * FROM Stavka;
SELECT * FROM Proizvod;
-- zavr�ni upit
SELECT DISTINCT
	Kupac.Ime+' '+Kupac.Prezime AS 'Kupac',
	Proizvod.Naziv AS 'Proizvod'
FROM Racun
INNER JOIN Kupac    ON Kupac.IDKupac  = Racun.KupacID
INNER JOIN Stavka   ON Stavka.RacunID = Racun.IDRacun
INNER JOIN Proizvod ON Proizvod.IDProizvod = Stavka.ProizvodID
WHERE Kupac.IDKupac = 1;
-----------------------------------------------------------------

-----------------------------------------------------------------
-- 3c) Za nekog kupca ispi�ite koje je sve kategorije robe ikada naru�io.
-- pripremni upiti
SELECT * FROM Kupac;
SELECT * FROM Racun;
SELECT * FROM Stavka;
SELECT * FROM Proizvod;
SELECT * FROM Potkategorija;
-- zavr�ni upit
SELECT DISTINCT
	Kupac.Ime+' '+Kupac.Prezime AS 'Kupac',
	Potkategorija.Naziv AS 'Kategorija'
FROM Racun
INNER JOIN Kupac         ON Kupac.IDKupac  = Racun.KupacID
INNER JOIN Stavka        ON Stavka.RacunID = Racun.IDRacun
INNER JOIN Proizvod      ON Proizvod.IDProizvod = Stavka.ProizvodID
INNER JOIN Potkategorija ON Proizvod.PotkategorijaID = Potkategorija.IDPotkategorija
WHERE Kupac.IDKupac = 1;
-----------------------------------------------------------------

-----------------------------------------------------------------
-- 3d) Za neki proizvod ispi�ite sve njegove podkategorije i kategorije.
-- pripremni upiti
SELECT * FROM Proizvod;
SELECT * FROM Potkategorija;
SELECT * FROM Kategorija;
-- zavr�ni upit
SELECT DISTINCT
	Proizvod.Naziv AS 'Naziv proizvoda',
	Kategorija.Naziv AS 'Kategorija',
	Potkategorija.Naziv AS 'Potkategorija'
FROM Proizvod
INNER JOIN Potkategorija ON Proizvod.PotkategorijaID = Potkategorija.IDPotkategorija
INNER JOIN Kategorija    ON Potkategorija.KategorijaID = Kategorija.IDKategorija
WHERE Proizvod.IDProizvod = 771;
-----------------------------------------------------------------

use AdventureWorksOBP

-- Koriste�i lijevo vanjsko spajanje prikazati nazive proizvoda i nazive njihovih potkategorija i kategorija. 
select p.Naziv, pk.Naziv, k.Naziv
from Proizvod as p
left outer join Potkategorija as pk
	on p.PotkategorijaID=pk.IDPotkategorija
left outer join Kategorija as k
	on pk.KategorijaID=k.IDKategorija


-- Koriste�i lijevo vanjsko spajanje dohvatiti sve proizvode koji nisu nikad prodani.
select p.Naziv, s.Kolicina
from Proizvod as p
left outer join Stavka as s
	on p.IDProizvod=s.ProizvodID
where s.RacunID is null

-- Koriste�i desno vanjsko spajanje dohvatiti sve proizvode koji nisu nikad prodani.
select p.Naziv, s.Kolicina
from stavka as s
right outer join Proizvod as p
	on s.ProizvodID=p.IDProizvod
where s.RacunID is null

use AdventureWorksOBP

/* 1)
Ispisati nazive proizvoda koji su na nekoj stavci ra�una prodani u vi�e od 35 komada. 
Svaki proizvod navesti samo jednom.
*/

select distinct p.Naziv
from Proizvod as p
inner join stavka as s
	on p.IDProizvod=s.ProizvodID
where s.Kolicina>35


/* 2)
Dohvatiti imena i prezimena svih kupaca koji su ne�to kupovali 
i uz svakog ispisati naziv grada i dr�ave.
*/

select k.Ime, k.Prezime, g.Naziv as 'Grad', d.Naziv as 'Dr�ava'
from Kupac as k
inner join Racun as r
	on r.KupacID=k.IDKupac
inner join Grad as g
	on k.GradID=g.IDGrad
inner join Drzava as d
	on d.IDDrzava=g.DrzavaID


/* 3)
Za sve ra�une izdane 01.08.2002. i pla�ene American Expressom ispisati njihove ID-eve i brojeve 
te ime i prezime i grad kupca, ime i prezime komercijaliste te broj 
i podatke o isteku kreditne kartice. Rezultate sortirati prema prezimenu kupca.
*/

select r.IDRacun, r.BrojRacuna, kc.Ime, kc.Prezime, kp.Ime, kp.Prezime
from racun as r
inner join KreditnaKartica as k
	on r.KreditnaKarticaID=k.IDKreditnaKartica
inner join Komercijalist as kc
	on kc.IDKomercijalist=r.KomercijalistID
inner join kupac as kp
	on kp.IDKupac = r.KupacID
inner join KreditnaKartica as kk
	on r.KreditnaKarticaID=kk.IDKreditnaKartica
where r.DatumIzdavanja='20020801'
and k.Tip='American Express'
order by 4

