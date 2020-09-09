## Ishod 4
### 1. Mana soap poruka i kako bi se mogla unaprijediti
Soap koristi samo xmla ne sve cesce prihvaceni json. 
SOAP zahtjeva visoku razinu couplinga izmedu servera i klijenta. 
SOAP je samo nacin komnikacije sto znaci da se ne brine 
za sigurnost poruke - to je zadaca implementatora sustava.

### 2. kako najlakse pristupiti wsdl dokumentu soap servisa
tako da nadodamo sufiks ?WSDL na kraj url-a usluge

### 3. Na koji nacin je moguce integrirati web servise sa tehnologijom za opis poslovnih procesa
Morali bi definirati BPEL(business process execution language)

### 4. odabrati i navesti primjere formata podataka koje je moguce prenositi putem soap poruka
Soap poruka podrzava podatke samo u xml formatu

### 5. utvrditi na koje sve specifikacije ima utjecaj UDDI
UDDI ima utjecaj na WS-basic profile

### 6. odabrati prvi korak kod projektiranja usluga weba kako bi se osigurao pouzdan rad
Moramo odrediti pravila za isporuku poruka i osigurati potvrde 
dolaska paketa, definirati kojim redom dolaze prouke, odrediti 
sigurnosne politike i poslovna pravila


## Ishod 4
### 1. najvaznije tehnologije na kojima se temelji omotnica soap poruke
Omotnica soap poruke je root element svake soap poruke, temelji se na xml-u 
te sadrzi dva pod elementa, zaglavlje (header) i tjelo (body).

### 2. Utvrditi najcesce tehnologije pomocu kojih je moguce slat soap poruke
Najcesce tehnologije slanja soap poruka su http(s) i protokoli 
aplikacijskog sloja OSI modela poput ftp-a

### 3. Na kojim sve mjestima je potrebno definirati URL i protokol kod definicije web usluge
elementi binding i service

### 4. U kojem WSDL elementu se definira naziv usluge
 u elementu description

### 5. nedostatci wsdl-a, navesti primjer kako ih je moguce otkloniti
Nedostatci wsdl-a su da je potrebno definirati dokumentaciju o usluzi 
posto wsdl daje samo informacije o tipovima i oblicima poruka te 
protokole i adrese. to mozemo otkloniti element dokumentacijom 
uvedenom u wsdl-u 2.0

### 6. cetiri najvaznije ws-* specifikacije i usporediti ih
- WS-security 
- WS-Transaction
- WS-Basic proifle
- WS-Reliable mesaging


## I4
### Navedite i opišite korake u korištenju usluga weba. (3 boda)
  - prvi korak je medusobno otkrivanje sudionika u procesu
  - usuglasavanje nacina komunikacije medu agentimazahtjevatelja i pruzatelja usluge
  - usuglasene uvjete programski ugraditi u svaki od agenata
  - agenti mogu poceti medusobno izmjenjivati poruke
### Navesti i opisati što sve sadrži tijelo SOAP poruke. (1 bod)
  - tijelo soap poruke sadrzi samu poruku i opcionalno pogresku koja se mogla dogoditi tijekom 
  prijenosa ili obrade informacije
### Koje dijelove usluge WSDL ne opisuje? (2 boda)
  - Informacije poslužitelja
  - Sigurnosne informacije
### Što opisuje WSDL element „binding“? (2 boda)
  - element biding je konkretan nacin izvedbe usluge, definira protokol koji se koristi za 
  slanje te nacin koristenja i izgled poruke SOAP
### Što uključuje specifikacija WS-Policy zajedno s WS-PolicyAssertion i WS-PolicyAttachments? (2 boda)
  - ukljucuje skup vlastitih poslovnih pravila, sigurnosnih politika i ostalih
  propisanih postupaka objedinjeni u jedinstvenom skupu politika


## Ishod 4
### Zadan je informacijski sustav za prikupljanje otpada za recikliranje, pri cemu klijenti (korisnici) koriste mobilne aplikacije za komunikaciju sa centralnim sustavom. Utvrditi i opisati usluge koje bi takav sustav mogao nuditi korisnicima koji je u skladu sa definicijom usluge weba (3 boda)
?

### Utvrditi i opisati sudionike u uslugama iz prvog zadatka (2 boda)
?

### Utvrditi i opisati korake koji bi bili nuzni u slucaju koristenja inforamcijskog sustava iz prva dva zadatka (2 boda)
?

### Odabrati i navesti primjere koristenja WS-* specifikacija koje bi bile nuzne za uspostavu informacijskog sustava opisanog u prva tri zadatka (3 boda)
?


## Ishod 4 
### Zadan je informacijski sustav koji ukljucuje mobilnu aplikaciju kojom se moze odrediti jeli tko od korisnika bio u neposrednoj blizini drugog korisnika koji takoder koristi tu mobilnu aplikaciju, a zarazen je virusom covid-19. Utvrditi i opisati koje ugovore o korisenju usluge je potrebo definirati i uvazavati prilikom koristenja te usluge (3 boda)
?

### Utvrditi i opisati minimalni skup usluga koji je potrebno implementirati kako bi se osigurala opisana funkcionalnost sustava opisanog u prvom zadatku (2 boda)
?

### Odabrati i opisati sve tehnologije i specifikacije te opisati njihovu ulogu prilikom implementacije sustava iz prvog zadatka (3 boda)
?

### Utvrditi i opisati odnose izmedu specifikacija iz treceg zadatka (2 boda)
?


## Dodatno
### Sadrzaj soap poruke
?

### Koje djelove usluge opisuje WSDL
?

### Elementi WSDL-a
?

### Usluge weba 2.0
?

