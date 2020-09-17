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
--tablica je 1NF ako ima primarni kljuc, ne sadrzi ponavljajuce 
--grupe stupaca, ni jedan stupac ne sadrzava skupove poidataka,
--tablica je 2NF ako je 1NF + svaki nekljucan stupac ovisi o
--cijelom primarnom kljucu a ne samo o djelu
--tablica je 3NF ako svaki nekljucni stupac ovisi samo o kljucu
--tj ako ne pripada nekom drugom entitetu
-----------------------
--p1: IDStudent, IDKolegij, Datum, Ocjena, NastavnikID
--(primarni ključ čine stupci IDStudent i IDKolegij)? 3NF
-----
--p2: IDStudent, IDKolegij, Datum, Ocjena, ImeNastavnika, PrezimeNastavnika 
--(primarni ključ čine stupci IDStudent i IDKolegij)? 2NF
-----
--p3: IDStudent, IDKolegij, Datum, Ocjena, NastavnikID, ECTSBodova 
--(primarni ključ čine stupci IDStudent i IDKolegij)? 1NF
-----
--p4: IDStudent, IDKolegij, Datum, Ocjena, BodovaI1, BodovaI2, BodovaI3, 
--BodovaI4 (primarni ključ čine stupci IDStudent i IDKolegij)? 1NF
-----
--p5: IDKolegij, Naziv, BrojEctsBodova (primarni ključ je stupac IDKolegij)? 3NF


-- Ishod 6
-------------------------------kupci----------------------------
-- Zadatak 1: ispiste imena i prezimena kupaca i u trecem stupcu kombinirani prikaz
-- spojene preve polovice imena i druge prezumena. ako ima neparan broj slova pola
-- se smatra nizi cjeli broj slova
select 
    k.Ime , k.prezime , 
    LEFT (k.Ime, LEN(k.Ime) / 2) + RIGHT(k.Prezime, LEN(k.Prezime) / 2)
from Kupac as k

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

--z2: kupcima cija prezimena sadrze y treba ispisati imena i odvojeno crticom sva 
--slova prezimena koja se nalaze lijevo od y, npr za milton albury -  Milton Albur
select k.Ime+'-'+Left(k.Prezime,CHARINDEX('y',k.Prezime)-1) as Inicijali 
from Kupac as k
where k.Prezime like '%y%'

--z7: ispisi ime, prezime i inicijale svih kupaca kojima ime zavrsava na slovo a
--inicijale ispisi u jednom stupcu, npr za Ana Horvat u jednom stupcu je A.H.
select k.Ime,k.Prezime, LEFT(k.Ime,1)+'.'+Left(k.Prezime,1)+'.' as Inicijali 
from Kupac as k
where k.Ime like '%a'

--z9: ispisi IDeve kupaca, imena i prez. te broj pripadajucih racuna (kolicina racuna
--pojedinog kupca), prikazano po kupcima koji su 2002g imali dvije ili vise kupnji (dva
--ili vise izdanih racuna). rezultat sortiraj padajuce po broju izdanih racuna
select k.IDKupac, k.ime, k.Prezime, COUNT(distinct r.IDRacun) as BrojRacuna
from kupac as k
inner join grad as g
on g.IDGrad=k.GradID
inner join racun as r
on r.KupacID=k.IDKupac
where year(r.DatumIzdavanja)=2002
group by k.IDKupac, k.Ime, k.Prezime
having COUNT(distinct r.IDRacun) > 2
order by BrojRacuna desc

--z10: ispiste koliko iz svake drzave ima kupaca koji nikad nisu nista kupili
select d.Naziv as Drzava, COUNT(distinct k.IDKupac) as BrojKupaca
from kupac as k
inner join grad as g
on g.IDGrad=k.GradID
inner join Drzava as d
on g.DrzavaID=d.IDDrzava
where k.IDKupac not in (select KupacID from Racun)
group by d.Naziv


----------------------------komercijalisti----------------------------
--Zad2: ispisite ime prezime i inicijale svih komercijalista koji nisu
--stalno zaposleni. inicijale ispisite u jednom stupcu (npr A.H. za anu horvat)
select k.Ime,k.Prezime, LEFT(k.Ime,1)+'.'+Left(k.Prezime,1) as Inicijali 
from Komercijalist as k
where StalniZaposlenik = 0

--z4: ispisi imena i prez. komercijalista i pripadajuci broj izdanih racuna po
--pojedinom komercijalisti za one komercijaliste koji su napravili vise od 400 racuna.
-- sortirati po imenima komercijalista
select kom.ime, kom.prezime, count(distinct r.IDRacun) as BrojIzdanihRacuna
from racun as r
inner join Komercijalist as kom
on kom.IDKomercijalist=r.KomercijalistID
inner join stavka as s 
on s.RacunID=r.IDRacun
group by kom.ime, kom.Prezime
having count(distinct r.IDRacun) > 400
order by kom.Ime


---------------------------kreditne kartice----------------------------
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

--z5: ispisi ID-eve i brojeve kreditnih kartica kojima je ukupni iznos izdanih
--racuna (suma ukupne cijene u stavkama) manji od 3kn
select k.IDKreditnaKartica, k.Broj
from racun as r
inner join KreditnaKartica as k
on k.IDKreditnaKartica=r.KreditnaKarticaID
inner join stavka as s 
on s.RacunID=r.IDRacun
group by k.IDKreditnaKartica, k.Broj
having sum(s.UkupnaCijena) < 3


----------------------------racuni----------------------------
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

--z3: ispisi IDracuna, brojracuna i datum izdavanja racuna. datum izdavanja treba 
--biti u obliku dan-mjesec-godina, a godina treba pisati sa dvije znamenke. u rjesenju
--ne smiju biti prikazane praznine. npr 2001-07-19 je 19-7-01 http://www.sql-server-helper.com/tips/date-formats.aspx
select r.IDRacun, r.BrojRacuna, CONVERT(VARCHAR(8), r.DatumIzdavanja, 5) AS [Datum izdavanja]
from Racun as r

--z8: ispisi u prvom stupcu razliku u mjesecima izmedu prvog i poslijednjeg datuma
--izdavanja racuna, u drugom stupcu koliko je god proslo od posljenje izdanog racuna
select DATEDIFF(MONTH, MIN(r.DatumIzdavanja),MAX(r.DatumIzdavanja)) as mjeseci,
       DATEDIFF(YEAR, MAX(r.DatumIzdavanja), GETDATE()) as godine
from Racun as r

----------------------------proizvodi----------------------------
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
--Zad6: ispisite imena i prezimena kupaca koji nikad nisu nista kupili
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

--ISHOD 7
--Zad11: ispisite za sve komercijaliste ime prezime i
--datum zadnjeg pripadajuceg racuna
select k.Ime, k.Prezime,(
    select MAX(r.DatumIzdavanja) 
    from Racun as r 
    where r.KomercijalistID=k.IDKomercijalist
) 
from Komercijalist as k

--Zad12: ispisite nazive gradova kupaca kojima je prodaje
--realizirao komercijalist mirko miric
select * from Grad
select g.Naziv from Grad as g
where g.IDGrad in (
    select k.GradID 
    from Kupac as k 
    where k.IDKupac in (
        select r.KupacID 
        from Racun as r
        where r.KomercijalistID=268
    )
)

--Zad13: ispisite rang listu koja prikazuje popis prozivoda
--bez ponavljanja i kolicinu u kojoj je pojedini proizvod 
--prodan a da nije palcen kreditnom karticom.
--sortiraj padajuci po kolicini prodanih proizvoda
select distinct p.Naziv,(
    select COUNT(s.Kolicina) 
    from Stavka as s 
    where s.ProizvodID=p.IDProizvod and (
        select r.KreditnaKarticaID 
        from Racun as r 
        where s.RacunID=r.IDRacun) is null
    ) 
as Kolicina 
from Proizvod as p
order by Kolicina desc

--Zad14: ispisite 5 naziva gradova koji imaju najveci broj
--racuna(kolicinu ne BrojRacuna) placenih kreditnim karticama.
--u istom upitu prikazite i najnoviji datum izdavanja racuna
--u pripadajucem gradu (o polju FarumIzavanja u tablici racun)
select g.Naziv,(
    select COUNT(*) from Racun as r 
    where r.KreditnaKarticaID is not null and r.KupacID in (
        select k.IDKupac from Kupac as k 
        where k.GradID=g.IDGrad)) as BrojRacuna
,    (select MAX(r.DatumIzdavanja) from Racun as r 
     where r.KupacID in (
        select k.IDKupac from Kupac as k 
        where k.GradID=g.IDGrad)) as ZadnjiRacunuGradu
from Grad as g
