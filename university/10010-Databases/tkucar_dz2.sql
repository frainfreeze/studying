use AutoSkola
go
--1. Ispišite imena, prezimena i adrese polaznika koji duguju od 4000 do 5000 kn
--   (uključite i te vrijednosti u rezultat upita).
select p.Ime, p.Prezime, a.Ulica, a.Grad 
	from Polaznik as p
	inner join Adresa as a on a.id = p.AdresaID
	where p.Duguje >= 4000 and p.Duguje <= 5000

--2. Ispišite imena i prezimena polaznika te opise i tipove vozila koja su vozili na
--   lekcijama, bez duplikata u rezultatima.
select distinct p.Ime, p.Prezime, tv.Opis as TipVozila, v.Opis
	from Polaznik as p
	inner join Lekcija   as l  on l.PolaznikID = p.id
	inner join Vozilo    as v  on v.id = l.VoziloID
	inner join TipVozila as tv on tv.id = v.TipVozilaID

use AdventureWorksOBP
go
--3. Ispišite za račune izdane u prvih 6 mjeseci 2002. godine ID računa, datum izdavanja
--   računa i koliko je dana prošlo od datuma izdavanja računa do današnjeg datuma.
select r.IDRacun, r.DatumIzdavanja, DATEDIFF(day, r.DatumIzdavanja, GETDATE())
	from Racun as r
	where YEAR(r.DatumIzdavanja) = 2002 and MONTH(r.DatumIzdavanja) < 7

--4. Ispišite jednim upitom imena i prezimena kupaca i koliko ima izdanih računa po
--   pojedinom kupcu za račune izdane u 2001. i 2003. godini, sortirano padajuće po
--   količini izdanih računa. Rješenje treba imati tri stupca: Ime, Prezime i KolikoRačuna.
select k.Ime, k.Prezime, count(r.DatumIzdavanja) as [Broj Racuna]
	from Kupac as k
	inner join Racun as r on r.KupacID = k.IDKupac
	where YEAR(r.DatumIzdavanja) = 2001 or YEAR(r.DatumIzdavanja) = 2003
	group by k.Prezime, k.Ime
	order by 3 desc
