## I1
1. Navedite barem četiri vanjskih čimbenika interoperabilnosti. (2 BODA)
2. Na što se odnosi konceptualna razina interoperabilnosti? (2 BODA)
3. Nacrtati trokut upravljanja interoperabilnošću. (2 BODA)
4. Što uključuje struktura HROI-a? (2 BODA)
5. Nacrtajte scenarij interakcije europskih javnih usluga. (2 BODA)


## I2
### Zadatak 1 (7 BODOVA)
Napraviti validaciju pomoću XSD (XML Scheme) automobil.xsd prema
sljedećim pravilima:
1. ugraditi u validaciju prema XSD uz atribute `<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">`
2. element automobil je kompleksni tip
3. element proizvodnja je kompleksni tip sa točno jednim elementom
drzava i jednim elementom datum
4. element drzava je jednostavni tip sa enumeracijom: Njemacka,
Francuska, USA
5. element datum je tipa date
6. element marka je tipa string sa atributom skracenica koji je skracenica
od marke vozila
7. element motor je kompleksni tip
8. element potrosnja je tipa integer koji je između 4 i 10, također ima
atribut jedinica koja tipa string

### Zadatak 2 (3 BODA)
Napraviti validni zapis automobil2.xml prema pravilima iz zadatka 1. sa
proizvoljnim vrijednostima.


## I3
1. Objasniti razliku između sigurnih i nesigurnih metoda kod HTTP
protokola? (2 BODA)
2. Što označava HTTP statusni kod 401? (2 BODA)
3. Što sve sadrži aplikacijski sloj troslojnog modela? (2 BODA)
4. Koja scenarij interoperabilnosti različitih slojeva je najčešći, a koji
najrjeđi i zašto? (2 BODA)
5. Na što se odnosi „bridging“ tehnologija izvedbe interoperabilnosti? (2
BODA)


## I4
1. Navedite i opišite korake u korištenju usluga weba. (3 BODA)
2. Navesti i opisati što sve sadrži tijelo SOAP poruke. (1 BOD)
3. Koje dijelove usluge WSDL ne opisuje? (2 BODA)
  * Sučelja usluge
  * Informacije poslužitelja
  * Protokol
  * Oblik podataka
  * Adresne informacije
  * Sigurnosne informacije
4. Što opisuje WSDL element „binding“? (2 BODA)
5. Što uključuje specifikacija WS-Policy zajedno s WS-PolicyAssertion i WS-
PolicyAttachments? (2 BODA)


## I5

U datoteci „PetiIshod.zip“ nalazi se solution „Zadatak“ i „AlgebraAPI“ mapa. U
„AlgebraAPI“ mapi postoji API.exe koji će pokretanjem stvoriti endpoint na
http://localhost:5000.

### Zadatak 1 (2 BODA)
Kreirati klasu Predmet koji sadrži svojstvo „naziv“ tipa String, svojstvo „smjer“
tipa String, svojstvo „brojEctsBodova“ tipa int i „prosjekOcjena“ tipa double.
Kreirati nekoliko auta spremite ih u listu i na endpointu „/api/predmet“
pozivom HTTP metode GET ispišite listu stvorenih predmeta.

### Zadatak 2 (3 BODA)
Kreirati endpoint na koji je potrebno poslati proizvoljnu godinu npr.
„/api/predmet/IIS“ koji pozivom metode GET ispisuje listu stvorenih
predmeta koji imaju broj ECTS bodova veću ili jednaku od poslane vrijednosti.
(npr. svi predmeti koji imaju broj ECTS bodova veću ili jednaku 5)

### Zadatak 3 (2 BODA)
Kreirati HTML stranicu koja poziva akciju „/api/predmet“ s POST metodom,
koja šalje naziv, smjer, broj ECTS bodova i prosjek. Poslati proizvoljni odgovor
na „submit“ te forme.

### Zadatak 4 (3 BODA)
Kreirati endpoint „/api/predmet“ kada se zove metodom POST da spremi
novi objekt tipa „Predmet“ u listu predmeta. Testirati poziv na ovaj endpoint
HTML formom iz zadatka 3.

### Zadatak 5 (3 BODA)
Dovršiti Algebra.cs u mapi „api“ i spremiti dohvat sa http://localhost:5000 u
objekt unutar programskog koda. Kreirati endpoint koji šalje broj ECTS bodova
prema kojem se određuje koliko prosječno sati se mora uložiti u učenje
predmeta da bi prosječan student ostvario prosječnu ocjenu (broj ECTS-a
pomnožen s 30), npr. „/api/predmet/IIS“ gdje se pozivom metode GET
dobiva ispis naziva predmeta i broj sati potrebnih za učenje.


## I6
1. Navedite barem pet ciljeva normizacije. (3 BODA)
2. Objasnite fazu javne rasprave kod donošenja norme u RH. (2 BODA)
3. Što je to ebXML? (2 BODA)
4. Skicirajte tehnološku arhitekturu e-Računa. (3 BODA)
5. Objasnite strukturu UTF-8 kao vrste kodiranja. (2 BODA)


## I7
1. Nabrojite barem pet zahtjeva nad sigurnošću. (2 BODA)
2. Navedite osnovne razlike između kriptografskih algoritama s
asimetričnim i simetričnim ključem. (2 BODA)
3. Što je to kvalificirani certifikat? (2 BODA)
4. Za koji od navedenih modela kriptoanalitičkih napada vrijedi da se koristi
napad grubom silom koji ne koristi sve moguće ključeve, već isprobava
samo određeni skup ključeva? (2 BODA)
  * Napad poznatim izvornim tekstom
  * Napad pogađanjem ključeva ili lozinki grubom silom
  * Napad rječnikom
  * Napad poznatim kriptiranim tekstom
  * Napad odabranim izvornim tekstom
  * Napad odabranim kriptiranim tekstom
5. Što je to SAML? (2 BODA)