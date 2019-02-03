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
