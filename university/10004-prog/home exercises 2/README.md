## > Vježbe 9
Zadatak 1. Napišite definiciju strukture za opis kvadra i implementirajte funkcije koje računaju njegov volumen, oplošje i duljinu prostorne dijagonale.

Zadatak 2. Napišite definicije strukture za opis kolegija na nekom fakultetu. Kolegij ima naziv, broj sati predavanja, broj sati vježbi, pridruženog profesora i asistenta. Napišite program koji učitava nekoliko kolegija te ispisuje njihove detalje na ekran.

Zadatak 3. Napišite aplikaciju za praćenje posudbi filmova u videoteci. Član videoteke može posuditi film. Može se unijeti neograničen broj posudbi. U svakom trenutku aplikacija prikazuje trenutni broj posuđenih filmova. Nakon unosa posudbi aplikacija nudi ispis svih posudbi ili posudbu s rednim brojem.

Zadatak 4. Napišite definiciju strukture Osoba koja pamti ime prezime i godinu rođenja osobe. Definirajte polje od 4 osobe, unesite podatke, te ispišite podatke unesenih osoba.



## > Dodatna nastava: Ishod 4


Tema: struktura kao pojam (kako se deklarira, inicijalizira i ispisuje)

Zadatak 1. Napišite definiciju strukture za čuvanje podataka o Automobilu. Automobil ima osnovne karakteristike naziv (string), tip (string), broj_vrata (int), obiteljski (bool) te potrosnja (double). Napravite instancu strukture, dodijelite joj vrijednosti te ih ispišite.


Tema: struktura je tip koji poput primitiva može biti smješten u polje

Zadatak 2. Napišite definiciju strukture Zaposlenik. Zaposlenik ima osnovne karakteristike ime, prezime, stalni_zaposlenik i placa. Napravite polje od 3 zaposlenika te zamolite korisnika da unese zaposlenike. Prodjite kroz polje zaposlenika while petljom i zbrojite plaće svih stalnih zaposlenika. Zbroj plaća stalnih zaposlenika ispišite na ekran.


Tema: struktura kao parametar funkcije

Zadatak 3. Napišite definiciju strukture za PravokutanTrokut. Potom napišite funkciju

pravilno_unesen koja prima strukturu PravokutanTrokut i ispituje da li su stranice a, b i c pravilno definirane (da bi trokut bio pravokutan mora biti zadovoljen uvjet c2 = a2 + b2). Funkcija neka vraća true ili false. U mainu od korisnika unesite potrebne vrijednosti za stvaranje strukture PravokutanTrokut, stvorite instancu te ju pošaljite metodi pravilno_unesen. Na temelju povratne vrijednosti ispišite da li je PravokutanTrokut pravilno unesen.


Tema: struktura kao povratna vrijednost funkcije i tip u vectoru

Zadatak 4. Napišite definiciju strukture za Film. Film ima karakteristike naziv, trajanje, redatelj, glavni_glumac i tip. Napisite funkciju kreiraj_film koja prima sve vrijednosti potrebne za istanciranje strukture. U funkciji kreiraj_film kreirajte strujkturu Film i vratite ju pozivatelju. U mainu omogućite korisniku da unese karakteristike filmova, te iste pošaljite funkciji kreiraj_film kako bi stvorili strukture. Povratne vrijednosti strukture Film spremite u vektor. Neka korisnik unaša filmove dok želi. Na koncu ispišite Filmove prolaskom kroz vektor filmova.


Tema: polje kao dio strukture

Zadatak 5. Napišite definiciju strukture Trkac. Trkac ima osnovne karakteristike ime, prezime i polje prolazno_vrijeme koje sadrzi 3 vrijednosti prolaznog vremena na 100 metara. Napravite instancu strukture i dodijelite joj vrijednosti. Neka program ispiše ime, prezime i srednje prolazno vrijeme za Trkaca.


Tema: struktura kao dio strukture

Zadatak 6. Napišite definiciju strukture za Kolegij. Kolegij ima osnovne karakteristike naziv,

ects_bodovi i obavezan. Nadalje, sadrži i strukturu Profesor. Profesor ima samo ime i prezime kao karakteristike. Napravite instancu strukture, dodijelite joj vrijednosti te ih ispišite.
