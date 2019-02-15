--Ishod ucenja 3
/* Zadatak 1
	Uklonite sve neklastrirane indekse sa tablice proizvod, ako ih ima. Unutar sql skripte napisite 
	odgovore na pitanja te naredbe kojima ste do njih dosl:
	- na koliko stanica su smjesteni podatci iz tablice proizvod [2]
	- koja je vrijednost stupca IDProizvod za prvi a koja za poslijednji proizvod na podatkovnoj stanici [1]
	- na kojoj stranici se nalazi proizvod s IDProizvod jednak 777 [1]
	- umetnite novi proizvod, na koju stranicu je dodan [1] */

/* Zadatak 2
	Uklonite sve neklasterirane indekse sa tablice KreditnaKartica, ako ih ima. Optimizirajte upit sto bolje:
	SELECT IDKreditnaKartica, Broj, Tip
	FROM KreditnaKartica
	Where Tip LIKE 'Master%'
	AND IstekGodina = 2007 | [5 bodova] */

--Ishod ucenja 3 drugi ispit
/* Zadatak 1
	Uklonite sve neklastrirane indekse sa tablice racun, ako ih ima. Unutar sql skripte napisite 
	odgovore na pitanja te naredbe kojima ste do njih dosl:
	- na koliko stanica su smjesteni podatci iz tablice racun [1]
    - na koliko stanica su smjesteni indeksi iz tablice racun [1]
	- koja je vrijednost stupca IDRacun za prvi a koja za poslijednji proizvod na podatkovnoj stanici [1]
	- na kojoj stranici se nalazi racun s IDRacun jednak 43818 [1]
	- umetnite novi racun, na koju stranicu je dodan [1] */

/* Zadatak 2
	Uklonite sve neklasterirane indekse sa tablice Kupac, ako ih ima. Optimizirajte upit sto bolje:
	SELECT IDKupac, Ime, Prezime
	FROM Kupac
	Where Prezime LIKE 'A%'
	AND GradID = 9 | [5 bodova] */    

--Ishod ucenja 4
/* Zadatak 1
	Napisite proceduru koja prima ime i prezime komercijaliste, umece novog komercijalistu u tablicu komercijalist 
	i kroz izlazni parametar vraca vrijednost primarnog kljuca umetnutog retka. Ako vec postojao komercijalist zadanog 
	imena i prezimena, ne treba ga upisivati ponovo i u tom slucaju kroz izlazni parametar vratite vrijednost -1.
	pozovite proceduru dvaput s istim imenom i prezimenom te ispisite vracenu vrijednost [5] */
	

/* Zadatak 2
	Napisite proceduru koja prima ID proiyvoda i provjerava postoji li takav proizvod i jeli ikad prodan. ako proizvod
	koji je poslan proceduri ne postoji procedura treba pomocu return parametra vratiti -1. ako proizvod postoji
	ali nije prodan ni u jednom primjerku treba vratiti putem return parametra 0. ako proizvod postoji i prodavan je, 
	procedura treba putem return parametra vratiti 1. pozovite proceduru tri puta kako bi prikazali navedene slucajeve. [5]*/

/* Zadatak 3
	Implementirajte CRUD operacije na tablici potkategorija pomocu jedne procedure. napravite umetanje, iymjenu, dohvacanje
	i brisanje jedne potkategorije [5] */

--Ishod ucenja 8
/* 1. napisite jedan upit za izracunavanje ukupne zarade (SUM(Stavka.UkupnaCijena)) po kategorijama i nazivima
proizvoda. treba biti vidljivo i koliko je ukupno zaradila pojedina kategorija te grand total (2.5b) */

/* 2. napisite jedan upit za prikaz koliko ima kupaca iz pojedine drzave i grada. rezultate treba rangirati s nekom od
funkcija po izboru kako bi na vrhu bile drzave i gradovi u kojima ima najvise kupaca (2.5) */

/* 3. napisite upit za prikaz postotnog udjela cijene pojedinog proizvoda u iznosu prosjecne cijene svih proizvoda.
prikazite samo proizvode kojima je cijena veca od nule. nije dozvoljeno koristenje podupita (2.5) */

/* 4. naisite upit za prikaz naziva proizvoda i cijena proizvoda bez pdv-a sortirano rastuce po cijeni. neka u trecem
stupcu vude prikazana razlika cijene trenutnog i prethodno prikazanog proizvoda (2.5) */