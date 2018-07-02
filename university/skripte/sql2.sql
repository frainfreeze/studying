use AdventureWorksOBP
go

-- Ishod 4
-- Zadatak 1: koristeci unutarnje spajanje ispisite datume racuna
-- koje su kreirali komerijalisti koji nisu stalno zaposleni, 1 upitom!
select r.DatumIzdavanja 
from Racun as r
    inner join Komercijalist as k
        on k.IDKomercijalist = r.KomercijalistID
where k.StalniZaposlenik = 0

-- Zadatak 2: unutarnja spajanja ispiste proizvode kategorije bicikl i djelovi
select k.Naziv, p.Naziv 
from Kategorija as k
    inner join Potkategorija as pk
        on pk.KategorijaID = k.IDKategorija
    inner join Proizvod as p
        on p.PotkategorijaID = pk.IDPotkategorija
where k.Naziv = 'bicikli' or k.Naziv = 'dijelovi'

-- Zadatak 3: koristeci desno vanjsko spajanje ispisi sve kupce (ime, prez)
-- i uz svakog kupca datum izdavanja racuna kojeg je pojedini kupac realizirao
-- ako postoje prikazi i kupce koji nikad nisu kupovali
-- rezultat sortiraj rastuce po prezimenima
select k.Ime, k.Prezime, r.DatumIzdavanja
from Racun as r
    right outer join Kupac as k
        on k.IDKupac = r.KupacID
order by 1

-- Zadatak 4: koristeci puno vanjsko spajanje ispisite samo gradove koji nemaju
-- definiranu drzavu i drzave za koje nema niti jednog definiranog grada, ako 
-- takvih nema u bazi umetnite drzavu bez gradova i grad bez drzave
-- ako tablica nedopusta unos null vrijednsoti u drzavaid promjenite to
ALTER TABLE Grad
ALTER COLUMN DrzavaID int NULL -- Za omoguciti NULL vrijednosti u Grad.DrzavaID

INSERT INTO Drzava(Naziv)
VALUES ('Italija')
INSERT INTO Grad (Naziv)
VALUES ('Honolulu')

select g.Naziv as GradBezDrzave, d.Naziv as DrzavaBezGradova 
from Grad as g
    full outer join Drzava as d
        on d.IDDrzava = g.DrzavaID
where g.DrzavaID is null or d.IDDrzava NOT IN (g.DrzavaID)
order by 1 desc

-- Zadatak 5: ispisite potkategorije proizvoda koji su prodavani ali samo onih
-- koji su prodavani kupcima iz osjeka, i to one koje je prodao pasko pasic
-- ili one prodavane kupcima iz osjeka ali koji nemaju definiranog komerijalista
-- prikazani moraju biti naziv potkategorije, ime i prez komercijaliste, datum 
-- izdavanja racuna i naziv grada. rezultat sortirajte rastuce po imenu komerci.
select pk.Naziv as Potkategorija, km.Ime as ImeKomercijaliste, 
    km.Prezime PrezimeKomercijaliste,
    r.DatumIzdavanja as DatumIzdavanjaRacuna, g.Naziv Grad
from Potkategorija as pk
    inner join Proizvod as p
        on p.PotkategorijaID = pk.IDPotkategorija
    inner join Stavka as s
        on s.ProizvodID = p.IDProizvod
    inner join Racun as r
        on r.IDRacun = s.RacunID
    inner join Kupac as k
        on k.IDKupac = r.KupacID
    inner join Grad as g
        on g.IDGrad = k.GradID
    right outer join Komercijalist as km
        on km.IDKomercijalist = r.KomercijalistID
where g.Naziv = 'osijek' and (km.Prezime = 'Pasic' or r.KomercijalistID is null)
order by km.Prezime asc

-- Ishod 5.
--?

-- Ishod 6
-- Zadatak 1: ispiste imena i prezimena kupaca i u trecem stupcu kombinirani prikaz
-- spojene preve polovice imena i druge prezumena. ako ima neparan broj slova pola
-- se smatra nizi cjeli broj slova
select 
    k.Ime , k.prezime , 
    LEFT (k.Ime, LEN(k.Ime) / 2) + RIGHT(k.Prezime, LEN(k.Prezime) / 2)
from Kupac as k

-- Zadatak 2: ispisite IDRacuna, ID kreditne kartice i u trecem stupcu kombinirani
-- podatak koji bi prikazivao podatak idracun spojen sa kredkarticaid
select r.IDRacun, r.KreditnaKarticaID, CAST(r.IDRacun as nvarchar) + '-' + CAST(r.KreditnaKarticaID as nvarchar)
from Racun as r

-- Zadatak 3: ispisite rang listu tipova kreditnih kartica koje su se koristile
-- za placanje racuna u 1. tjednu ili 3. kvartalu bilo koje godine, rezultat treba
-- prikazivati tipove kreditnih kartica bez ponavljanja i sume iznosa svih racuna
-- placenih kreditnim karticama, rez treba sortirati desc po sumama iznosa i 
-- prikazati samo prve tri kartice s najvecim ostvarenim prometom
select distinct top 3 kk.Tip, SUM(s.UkupnaCijena)
from KreditnaKartica as kk
    inner join Racun as r
        on r.KreditnaKarticaID = kk.IDKreditnaKartica
    inner join Stavka as s
        on s.RacunID = r.IDRacun
where DATEPART(week, r.DatumIzdavanja) = 1 or (DATEPART(month, r.DatumIzdavanja) IN (7, 8, 9))
group by kk.Tip
order by 2 desc

-- Zadatak 4: napravite upit kojim cete ispisati samo brojku koliko ima
-- jedinstvenih kupaca koji nikad nisu kupili ni jedan proizvod iz kat. carape
select distinct count(*)
from Kupac as k
    left outer join Racun as r
        on r.KupacID = k.IDKupac
    inner join Stavka as s
        on s.RacunID = r.IDRacun
    inner join Proizvod as p
        on p.IDProizvod = s.ProizvodID
    inner join Potkategorija as pk
        on p.PotkategorijaID = pk.IDPotkategorija
where pk.Naziv != 'carape'

--Zad5: ispisite koliko iz svake kategorije ima proizvoda koji nisu nikad prodani
select k.Naziv,COUNT(pr.IDProizvod) as KolikoProizvoda 
from Kategorija as k
    inner join Potkategorija as pk 
        on k.IDKategorija=pk.KategorijaID
    inner join Proizvod as pr 
        on pr.PotkategorijaID=pk.IDPotkategorija
    left join Stavka as s 
        on s.ProizvodID = pr.IDProizvod
where s.IDStavka is NULL
group by k.Naziv

--ISHOD 6
--Zad2: ispisite ime prezime i inicijale svih komercijalista koji nisu
--stalno zaposleni. inicijale ispisite u jednom stupcu (npr A.H. za anu horvat)
select k.Ime,k.Prezime, LEFT(k.Ime,1)+'.'+Left(k.Prezime,1) as Inicijali 
from Komercijalist as k
where StalniZaposlenik = 0

--Zad3: ispisite u prvom stupcu razliku u godinama od prvog izdanog racuna do
--danas te u drugom razliku u godinama od posljednjeg izdanog racuna do danas
select 
    DATEDIFF(YEAR,MIN(r.DatumIzdavanja),GETDATE()) as FirstBillTilltoday,
    DATEDIFF(YEAR,MAX(r.DatumIzdavanja),GETDATE()) as LastBilltillToday 
from Racun as r

--Zad4: ispisite koliko je izdanih racuna te koliki je pritom promet napravljen
--(suma ukupne cjene) prikazano po godinama, ali gledano samo po racunima 
--izdanima u prosincu
select Year(r.datumIzdavanja), COUNT(r.IDRacun) as Howmany,SUM(s.UkupnaCijena) as UkupnaCijena 
from Racun as r
    Inner Join stavka as s 
        on s.RacunID=r.IDRacun
group by Year(r.datumIzdavanja) 

--Zad5: ispisite koliko iz svake kategorije ima proizvoda koji nisu nikad prodani
select k.Naziv,COUNT(pr.IDProizvod) as KolikoProizvoda 
from Kategorija as k
    inner join Potkategorija as pk 
        on k.IDKategorija=pk.KategorijaID
    inner join Proizvod as pr 
        on pr.PotkategorijaID=pk.IDPotkategorija
    left join Stavka as s 
        on s.ProizvodID = pr.IDProizvod
where s.IDStavka is NULL
group by k.Naziv


--ISHOD 7
--Zad6: ispisite imena i prezimena kupaca koji nikad nosu nista kupili
select k.Ime,k.Prezime 
from Kupac as k
where k.IDKupac not in (
    select r.KupacID from Racun as r
) 

--Zad7: ispisite za sve racune izdane IDeve, 
--datum izdavanja racuna i ukupne iznose po racunu
select r.IDRacun,r.DatumIzdavanja,(
    select SUM(s.UkupnaCijena) 
    from Stavka as s 
    where r.IDRacun=s.RacunID
) 
from Racun as r

--Zad8: ispisite iz kojih su sve gradova kupci kupovali 
-- karticom 'Visa'
select g.Naziv from Grad as g
where g.IDGrad in (
    select k.GradID 
    from Kupac as k 
    where k.IDKupac in (
        select r.KupacID 
        from Racun as r 
        where r.KreditnaKarticaID in (
            select kk.IDKreditnaKartica 
            from KreditnaKartica as kk 
            where kk.Tip='Visa'
        )
    )
) --No clue if this one works but it should

--Zad9: ispisite kategorije proizvoda kojima je prosjecna cijena
--pripadajucih proizvoda manja od prosjecne cijene svih proizvoda
--proizvode bez potkategorije nemojte uzimati u obzir 
select k.Naziv from Kategorija as k
where (
    select AVG(p.CijenaBezPDV) 
    from Proizvod as p 
    where p.PotkategorijaID is not NULL)>(
        select AVG(p2.CijenaBezPDV) 
        from Proizvod as p2 
        where p2.PotkategorijaID in(
            select pk.IDPotkategorija 
            from Potkategorija as pk 
            where pk.KategorijaID=k.IDKategorija
        )
    )
)

-- Ishod 7 - rjesiti podupitima bez spajanja
-- Zadatak 1: ispisite imena komercijalista koji nemaju svojih racuna
select km.Ime, km.Prezime
from Komercijalist as km
where km.IDKomercijalist not IN
    (select distinct r.KomercijalistID
     from Racun as r
     where r.KomercijalistID is not null)

-- Zadatak 2: ispisite za sve gradove ukupni ostvareni promet gledano po polju
-- ukupnacijena u tablici stavka, po pojedinom gradu, rezultat sort desc po prometu
select  g.Naziv as Grad, (
    select SUM(s.UkupnaCijena) 
    from Stavka as s 
    where s.RacunID IN (
        select r.IDRacun 
        from Racun as r 
        where r.KupacID IN (
            select k.IDKupac 
            from Kupac as k 
            where k.GradID = g.IDGrad
          )
      )
  ) as UkupnaCijena 
from Grad as g 
order by 2 desc

-- Zadatak 3: ispisite nazive gradova kupaca (bez ponavljanja) kojima su
-- prodavali komercijalisti koji nisu stalno zaposleni.
select distinct g.Naziv
from Grad as g
where g.IDGrad IN(
    select k.GradID
    from Kupac as k
    where k.IDKupac IN(
        select r.KupacID
        from Racun as r
        where r.KomercijalistID IN(
            select km.IDKomercijalist
            from Komercijalist as km
            where km.StalniZaposlenik = 0
            )
        )
    )

-- Zadatak 4: ispisite 5 naziva potkategorija koje imaju najvecu kolicinu 
-- proizvoda crne ili nedfinirane boje gledano po polju kolicina u tavlici 
-- stavka. u istom upitu prikazite i ostvaremi promet pojedine potkategorije
-- gledano po polju ukupna cijena u tablici stavka
select top 5 pk.Naziv as Kategorija,(
    select SUM(s.Kolicina)
    from Stavka as s
    where s.ProizvodID IN(
        select p.IDProizvod
        from Proizvod as p
        where p.PotkategorijaID = pk.IDPotkategorija and (p.Boja = null or p.Boja = 'crna')
    )
) as BrojProdanihProizvoda,(
    select SUM(s.UkupnaCijena)
    from Stavka as s
    where s.ProizvodID IN(
        select p.IDProizvod
        from Proizvod as p
        where p.PotkategorijaID = pk.IDPotkategorija and (p.Boja = null or p.Boja = 'crna')
    )
) as UkupanIznosProdaje
from Potkategorija as pk
order by 2 desc