# koBel sauce
## Ishod 3 - sigurnost na sql serveru
1. (3b)
Korisniku koji vec ima kreiran win acc abp-vm2\Matej omogucite pristup bazi adw2014
zatim mu dajte pravo da pregledava podatke iz tablice dbo.Do??
u toj bazi nesmije imati nikakva druga prava 

2. (3b)
korisniku koji ima vec kreiran win acc abp-vm2\Dominik na najednostavniji nacin omogucite da 
moze citati sve podatke iz baze adw2014 osim iz tablice Sales.CreditCard

3. (3b)
Kreirajte novi sql login Lorena na instanci abp-vm2 sa lozinkom pa$$w0rd
podesite sve sto je potrebno da se lorena moze spojiti na tu instancu

4. (2b)
korisniku koji vec ima kreiran win acc abp-vm2\Vedran dodjelite maksimalna prava u bazi adw2014


## Ishod 4 - sigurnosne kopije i oporavak baza na sql serveru
1. (2b)
Baza DF_adworks2 na instanci abp-vm2 testna je baza. u slucaju kvara bit ce
zadovoljavajuce vratiti je u stanje u kakvoj je bila kad je zavrsio neki njezin backup
napisite u kojem recovery modelu baza treba raditi a ond aje tako i podesite

2. (4b)
napravite ??? backup baze df_adw3 na instancu abp-vm2 i restaurirajte ga na istu
instancu u bazu df_adw_restored

3. (3b)
u donjoj tablici prikazan je redoslijed dogadaja nad bazom df_ad6 na isntanci vm2
...
backupi se nalaze na c:\... restaurirajte bazu na instancu tako da bude iz trenutka 17

4. (3b)
korisnik u svojoj tvrtki ima nekoliko baza podataka na sql serveru, medu kojima 
je i jedna manja baza od 500mb nad kojom nema puno transakcija. u slucaju kvara baze bit
ce zadovoljavajuce da je vratite u jucerasnje stanje jer ce se transakcije koje su
od tad nastale moci rekonstruirati iz drugih izvora. na diku nije potrebno cuvati backupove
starije od jednog dana. predlozite odgovarajuci recovery model i pogodnu strategiju izrade
sigurnosnih kopija za tu bazu.


## Ishod 5 - nadgledanje stanja sustava
razmislite koji su vam alati potrebni i kako ce te ih podesiti da biste mogli 
odgovoriti na slijedeca pitanja o radnom opterecenju sql upitima iz
aplikacije worloader:

1. (4b)
Utvrdite koliki je udio pojedine SQL serverove instance u opterecenju procesora 
i memorije. napisite naziv countera koji ste mjerili i njihovu maksimalnu
vrijednost u cjelom mjerenom intervalu.

2. (4b)
Medu upitim akoji su se izvodili nad abp-vm2.advworks2014 bio je i jedan koji
sadrzi tekst SymQuantity. odgovorite(?) koji je to upit i pospremite ga 
u c:\vase ime i prezime\alal
ako se taj upit moze optimizirati koristenjem nekog indeska kreirajte ga

program workloader pokrece se klikom na ikonu [] u taskbaru. u njemu treba
odabrati opciju ispit i upisati sifru ??: M/V...
Napomena: workloader mozete pokrenuti jednom za rjesavanje prvog zadatka,
drugi put za rjesavanje drugog zadatka itd.


# Priprema za ispit
Instalacija SQL Servera (I4)
1. pri instalaciji odabrati pravu komponentu ako SQL Server želimo koristiti za rad s relacijskim bazama podataka
2. pri instalaciji odabrati željenu komponentu
3. podesiti naziv imenovanoj instanci
4. postaviti servisni account servisima SQL Server i SQL Server Agent
5. odabrati zadani collation na kojem će instanca raditi
6. znati što znače autentikacijski modovi i kada koji odabrati
7. podesiti koji accounti nakon instalacije mogu administrirati instancu
8. promijeniti defaultne lokacije za podatkovne i log datoteke te za datoteke sistemske baze TempDB

Konfiguracija SQL Servera (I4
1. podesiti maksimalnu količinu memorije na instanci SQL Servera
2. podesiti da se kod izrade backupa po defaultu izrađuju kompresirani backupi
3. podesiti da se SQL Server Agent starta prilikom pokretanja poslužitelja
4. podesiti na kojem će mrežnom protokolu instanca SQL Servera raditi
5. podesiti TCP port na kojem će raditi instanca SQL Servera
6. omogućiti da klijenti prilikom spajanja na imenovanu instancu ne moraju navoditi TCP port
7. provjeriti na kojem portu neka instanca trenutačno radi

Nadogradnja SQL Servera (I4)
1. koristeći pogodan alat detektirati potencijalne probleme prije nadogradnje na novu verziju SQL Servera

Instalacija Reporting Servicesa (I4)
1. instalirati Reporting Services na postojeću instancu SQL Servera
2. podesiti lokaciju sistemskih baza za Reporting Services i korisnički račun za pristup tim bazama
3. rezervirati URL-ove za korisnički i administratorski portal
4. backupirati i restaurirati encryption key

Upravljanje sigurnošću na SQL Serveru (I5)
1. Dozvoliti / zabraniti čitanje / promjenu podataka određenom korisniku u zadanoj tablici
2. Omogućiti korisniku čitanje podataka iz bilo koje tablice, odnosno promjenu podataka u bilo kojoj tablici u bazi primjenom ugrađenih database rola
3. Podesiti potrebne postavke da bi se na instancu SQL Servera mogli spajati i SQL logini
4. Dodijeliti korisniku maksimalna prava na instanci SQL Servera
5. Dodijeliti korisniku maksimalna prava u zadanoj bazi
6. Povezati login s postojećim database userom nakon restauriranja baze na drugu instancu

Građa baze (I5)
1. Kreirati bazu sa zadanim filegrupama i datotekama. Rasporediti datoteke u filegrupe
2. Podesiti inicijalnu veličinu datoteka baze, opcije automatskog rasta i maksimalnu veličinu
3. Pregledati zauzeće prostora u bazi (unallocated, used, unused space)
4. Pregledati veličinu tablica u bazi. Dropati tablicu
5. Koristiti naredbu DBCC SHRINKFILE i njezine parametre
6. Koristiti naredbu DBCC SHRINKDATABASE i njezine parametre
7. Povećati datoteku baze na zadanu veličinu

Sigurnosne kopije i oporavak baza (I5)
1. S obzirom na zadane zahtjeve za oporavkom staviti bazu u odgovarajući recovery model
2. Napraviti full, diferencijalni i log backup baze
3. Restaurirati bazu iz postojećih full, log i diferencijalnih backupa. Pritom treba znati kako restaurirati bazu preko postojeće baze, odnosno kako restauriranjem kreirati novu bazu na istoj ili drugoj instanci
4. Za bazu kojoj se pokvarila podatkovna datoteka napraviti oporavak do točke pada
5. Koristeći postojeće backupe oporaviti bazu u zadanu točku u vremenu
6. S obzirom na postavljene zahtjeve za oporavkom (maksimalno dozvoljena količina izgubljenih podataka, koliko se najdalje u prošlost možemo vratiti) predložiti odgovarajuću strategiju izrade backupa
7. Riješiti problem zastoja u radu baze zbog transakcijskog loga koji je popunio cijeli disk

Nadgledanje sustava (I6)
1. Pomoću pogodnog alata nadgledati stanje sustava u kraćem vremenskom intervalu i utvrditi
sljedeće:
a. koliko je opterećenje procesora, memorije i diska
b. koliki je SQL Serverov udio u ukupnom opterećenju procesora, memorije i diska
c. kolika je efikasnost SQL Serverovog međuspremnika
d. koliko se skupina (batcheva) SQL naredbi izvršavalo u sekundi
Potrebno je utvrditi kolike su bile minimalne, maksimalne ili prosječne vrijednosti pojedinih
pokazatelja unutar tog mjernog intervala. Nagledanje raditi tako da se izmjerene vrijednosti
pospreme u log datoteku.
2. Utvrditi nad kojim se datotekama baze događa najviše I/O operacija
3. Utvrditi postoje li na instanci SQL Servera međusobna blokiranja procesa. Utvrditi koji upiti uzrokuju blokiranje, a koji su blokirani
4. Preko pogodnog alata uhvatiti upite koji se izvode na instanci SQL Servera, a koji u sebi sadrže zadani tekst ili traju dulje od zadanog vremena. Izdvojiti pojedinačne upite ili skupine upita (batcheve) koji su najdulje trajali ili koji su imali najviše logičkih čitanja
5. Utvrditi može li se zadani upit optimizirati kreiranjem nekog indeksa. Ako može, kreirati taj indeks