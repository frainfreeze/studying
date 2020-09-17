- [ASBP / 1. MI](#asbp--1-mi)
    - [Ispitna pitanja: 1. predavanje: Imenici, imenički servisi, X.500, LDAP](#ispitna-pitanja-1-predavanje-imenici-imeni%C4%8Dki-servisi-x500-ldap)
        - [Objasni pojam Middleware!](#objasni-pojam-middleware)
        - [Što je imenik (directory) i po čemu se razlikuje od klasične baze podataka?](#%C5%A1to-je-imenik-directory-i-po-%C4%8Demu-se-razlikuje-od-klasi%C4%8Dne-baze-podataka)
        - [Koje imeničke standarde (protokole) poznajete?](#koje-imeni%C4%8Dke-standarde-protokole-poznajete)
        - [U kontekstu X.500 standarda, objasnite što je RDN?](#u-kontekstu-x500-standarda-objasnite-%C5%A1to-je-rdn)
        - [U kontekstu X.500 standarda, objasnite što je DIT?](#u-kontekstu-x500-standarda-objasnite-%C5%A1to-je-dit)
        - [U kontekstu X.500/LDAP standarda: objasnite što je entry (zapis) a što ObjectClass (razred objekta)?](#u-kontekstu-x500ldap-standarda-objasnite-%C5%A1to-je-entry-zapis-a-%C5%A1to-objectclass-razred-objekta)
        - [Što je LDIF?](#%C5%A1to-je-ldif)
        - [Opiši kako teče komunikacija izmedju LDAP klijenta i poslužitelja!](#opi%C5%A1i-kako-te%C4%8De-komunikacija-izmedju-ldap-klijenta-i-poslu%C5%BEitelja)
        - [Što je imenička shema?](#%C5%A1to-je-imeni%C4%8Dka-shema)
        - [Zašto je važno pridržavati se izvornih definicija atributa iz neke imeničke sheme?](#za%C5%A1to-je-va%C5%BEno-pridr%C5%BEavati-se-izvornih-definicija-atributa-iz-neke-imeni%C4%8Dke-sheme)
    - [Ispitna pitanja: 2. predavanje: AAA, IdM, AAI](#ispitna-pitanja-2-predavanje-aaa-idm-aai)
        - [Objasni što označava kratica AAA!](#objasni-%C5%A1to-ozna%C4%8Dava-kratica-aaa)
        - [Objasnite razliku između procesa autentikacije i autorizacije](#objasnite-razliku-izme%C4%91u-procesa-autentikacije-i-autorizacije)
        - [Opišite model AAI!](#opi%C5%A1ite-model-aai)
        - [Navedite 3 moguća scenarija za autorizaciju (nakon uspješne autentikacije)!](#navedite-3-mogu%C4%87a-scenarija-za-autorizaciju-nakon-uspje%C5%A1ne-autentikacije)
        - [Zbog čega je za AAI sustave bitna kontrola sjednice (session control)?](#zbog-%C4%8Dega-je-za-aai-sustave-bitna-kontrola-sjednice-session-control)
        - [Čemu služe protokoli RADIUS i SAML?](#%C4%8Demu-slu%C5%BEe-protokoli-radius-i-saml)
        - [Objasnite razliku između SSO i SLO u kontekstu AAI?](#objasnite-razliku-izme%C4%91u-sso-i-slo-u-kontekstu-aai)
        - [Što je Shibboleth?](#%C5%A1to-je-shibboleth)
        - [Objasnite što je eduroam!](#objasnite-%C5%A1to-je-eduroam)
        - [Objasnite koncept VO (virtualnih organizacija)!](#objasnite-koncept-vo-virtualnih-organizacija)
    - [ASBP priprema](#asbp-priprema)
        - [Dio kojeg standarda je DSP?](#dio-kojeg-standarda-je-dsp)
        - [Navedite najmanje dva proširenja koja je Microsoft unio u LDAP da bi stvorio AD DS?](#navedite-najmanje-dva-pro%C5%A1irenja-koja-je-microsoft-unio-u-ldap-da-bi-stvorio-ad-ds)
        - [Koji protokol AD DS koristi kako bi implementirao sigurnu komunikaciju?](#koji-protokol-ad-ds-koristi-kako-bi-implementirao-sigurnu-komunikaciju)
        - [Ima li AD DS API?](#ima-li-ad-ds-api)
        - [Navedi najmanje tri cilja replikacijske topologije AD:](#navedi-najmanje-tri-cilja-replikacijske-topologije-ad)
        - [Koje dvije particije AD koriste istu topologiju za replikaciju?](#koje-dvije-particije-ad-koriste-istu-topologiju-za-replikaciju)
        - [Što je to cijena replikacije?](#%C5%A1to-je-to-cijena-replikacije)
        - [Što je to latencija replikacije?](#%C5%A1to-je-to-latencija-replikacije)
        - [Zašto replikacija ima latenciju?](#za%C5%A1to-replikacija-ima-latenciju)
        - [Kod replikacije, je li bolje imati manju ili veću latenciju?](#kod-replikacije-je-li-bolje-imati-manju-ili-ve%C4%87u-latenciju)
        - [Replikacija izmežu sajtova je optimizirana za ___________ dok je untar sajta optimizacija usmjerena prema __________](#replikacija-izme%C5%BEu-sajtova-je-optimizirana-za--dok-je-untar-sajta-optimizacija-usmjerena-prema)
        - [Želimo li veću brzinu replikacije podatke:](#%C5%BEelimo-li-ve%C4%87u-brzinu-replikacije-podatke)
        - [AD posjeduje mehanizam koji se zove KCC. Koja je njegova uloga?](#ad-posjeduje-mehanizam-koji-se-zove-kcc-koja-je-njegova-uloga)
        - [U slučaju ispada ili nedostupnosti DC, AD će __________________ kako bi osigurao ______________](#u-slu%C4%8Daju-ispada-ili-nedostupnosti-dc-ad-%C4%87e--kako-bi-osigurao)
        - [Afinitet klijenata je bitna karakteristika koja utječe na brzinu rada. Ukratko objasnite o čemu je riječ.](#afinitet-klijenata-je-bitna-karakteristika-koja-utje%C4%8De-na-brzinu-rada-ukratko-objasnite-o-%C4%8Demu-je-rije%C4%8D)
        - [Nabrojite najmanje tri objekta u topologiji AD DS!](#nabrojite-najmanje-tri-objekta-u-topologiji-ad-ds)
        - [Za bilo koji inter-site link koliko DC zna za njega?](#za-bilo-koji-inter-site-link-koliko-dc-zna-za-njega)
        - [Koja tri transportna mehanizma znate?](#koja-tri-transportna-mehanizma-znate)
        - [Unutar sitea se uvijek koristi ___________________ za transport](#unutar-sitea-se-uvijek-koristi--za-transport)
        - [SMTP je protokol koji se osim za replikaciju koristi i za jedan drugi važni proces. Koji?](#smtp-je-protokol-koji-se-osim-za-replikaciju-koristi-i-za-jedan-drugi-va%C5%BEni-proces-koji)
        - [Postoji li ograničenje što je moguće replicirati putem SMTP? Objasnite svojim riječima zašto.](#postoji-li-ograni%C4%8Denje-%C5%A1to-je-mogu%C4%87e-replicirati-putem-smtp-objasnite-svojim-rije%C4%8Dima-za%C5%A1to)
        - [Koja je razlika između sinkrone i asinkrone replikacije?](#koja-je-razlika-izme%C4%91u-sinkrone-i-asinkrone-replikacije)
        - [Koju vrstu replikacije koriste brzi a koju spori linkovi?](#koju-vrstu-replikacije-koriste-brzi-a-koju-spori-linkovi)
        - [Što je to multimaster replikacija?](#%C5%A1to-je-to-multimaster-replikacija)
        - [Što znači ako kažemo da je replikacija po PULL principu?](#%C5%A1to-zna%C4%8Di-ako-ka%C5%BEemo-da-je-replikacija-po-pull-principu)
        - [Što je to store and forward?](#%C5%A1to-je-to-store-and-forward)
        - [Što znači da je replikacija bazirana na „stanju“ (state based replication)?](#%C5%A1to-zna%C4%8Di-da-je-replikacija-bazirana-na-%E2%80%9Estanju-state-based-replication)
        - [Repliciraju li svi DCovi sve particije AD? Repliciraju li se promjene objekata koji nemaju promjena?](#repliciraju-li-svi-dcovi-sve-particije-ad-repliciraju-li-se-promjene-objekata-koji-nemaju-promjena)
        - [Postoje 4 particije unutar AD. Nabrojite najmanje tri od njih i VRLO kratko opišite što sadrže:](#postoje-4-particije-unutar-ad-nabrojite-najmanje-tri-od-njih-i-vrlo-kratko-opi%C5%A1ite-%C5%A1to-sadr%C5%BEe)
        - [Promjene koje se propagiraju se događaju na razini:](#promjene-koje-se-propagiraju-se-doga%C4%91aju-na-razini)
        - [Jedno od navedenog nije tip promjene u AD:](#jedno-od-navedenog-nije-tip-promjene-u-ad)
        - [Što je to UTD?](#%C5%A1to-je-to-utd)
        - [Što je to High watermark?](#%C5%A1to-je-to-high-watermark)
        - [Od trenutka promjene atributa do notifikacije partnera o potrebi za replikacijom dolazi:](#od-trenutka-promjene-atributa-do-notifikacije-partnera-o-potrebi-za-replikacijom-dolazi)
        - [Za lociranje i identifikaciju partnera u replikaciji najbitniji je:](#za-lociranje-i-identifikaciju-partnera-u-replikaciji-najbitniji-je)
        - [Replikacija promjene passworda i hitna replikacija odvijaju se identičnim mehanizmom](#replikacija-promjene-passworda-i-hitna-replikacija-odvijaju-se-identi%C4%8Dnim-mehanizmom)
- [ASBP / 2. MI](#asbp--2-mi)
- [Other](#other)
    - [My Notes](#my-notes)
    - [Links and resources](#links-and-resources)

![](https://imgur.com/ymPgvQp.png")


# ASBP / 1. MI
## Ispitna pitanja: 1. predavanje: Imenici, imenički servisi, X.500, LDAP
### Objasni pojam Middleware!
Middleware je skup temeljnih programskih komponenti koje omogucuju skalabilnost aplikacija i mreza. 
Osnovni middleware: identifikatori, imenici, certifikati, AAA

### Što je imenik (directory) i po čemu se razlikuje od klasične baze podataka?
Imenik (Directory) je baza podataka specijalizirana za citanje i pristup podacima o osobama, 
ustanovama, servisima etc. Od klasicne baze podataka razlikuje se po brzom citanju, 
efikasanijem pristupu, jednostavnom azuriranju, statickom pogledu na podatke.

### Koje imeničke standarde (protokole) poznajete?
Whois, x.500, LDAP

### U kontekstu X.500 standarda, objasnite što je RDN?
Na svakom nivou hijerarhije zapis ima različit RDN
npr. RDN: c = HR; RDN: o:=algebra; RDN: cn = pero

### U kontekstu X.500 standarda, objasnite što je DIT?
Directory Information tree. U tom stablu se podaci spremaju kao zapisi uređeni kao čvorovi te ono opisuje podatkovni model.

### U kontekstu X.500/LDAP standarda: objasnite što je entry (zapis) a što ObjectClass (razred objekta)?
Zapis sadrži informacije I opisuje osobu. Sadrži više atributa te svaki atribut ima svoj tip I vrijednost. 
ObjectClass je vrsta atributa koji definira vrstu podatka koji se sprema u imenik te određuje skup atributa 
koje taj zapis može imati.

### Što je LDIF?
Format za razmjenu podataka

### Opiši kako teče komunikacija izmedju LDAP klijenta i poslužitelja!
Klijent uspostavlja vezu s LDAP poslužiteljem procedurom bind.
Klijentu je potrebna adresa I port(389) te ukoliko se želi autenticirati korisničko ime I lozinka.
Za svakog korisnika je definiran skup pravila koja definiraju operacije koje korisnik smije pokretati na poslužitelju.

### Što je imenička shema?
Skup razreda I atributa s njihovom sintaksom.

### Zašto je važno pridržavati se izvornih definicija atributa iz neke imeničke sheme?
Zato što je teško modificirati attribute koji nisu definirani pomoću izvorne specifikacije.

## Ispitna pitanja: 2. predavanje: AAA, IdM, AAI
### Objasni što označava kratica AAA!
- Autentikacija   
- Autorizacija
- Accounting(auditing)

### Objasnite razliku između procesa autentikacije i autorizacije
Autentikacijom se provjerava elektronicki identitet korisnika a autorizacijom
se korisniku dodjeljuje odnosno oduzima utvrdena razina prava prstupa resursu.

### Opišite model AAI!
![](https://imgur.com/7Yv8x4G.png)

### Navedite 3 moguća scenarija za autorizaciju (nakon uspješne autentikacije)!
- AuthZ = AuthN
- AuthZ = AuthN + dodatni atributi (iz imenika)
- AuthZ = AuthN + dodatni atributi (iz imenika) + informacije koje pamti resurs lokalno

### Zbog čega je za AAI sustave bitna kontrola sjednice (session control)?
Ona pridonosi performantnosti AAI te omogucava identifikaciju klijenta.

### Čemu služe protokoli RADIUS i SAML?
Remote Authentication Dial In User Service je protokol koji omogućuje upravljanje AAA procesom.
Security Assertion Markup Language cjeloviti je okvir za razmjenu povjerljivih informacija 
temeljen na potvrdama te se oslanja na XML, SOAP i http.

### Objasnite razliku između SSO i SLO u kontekstu AAI?
AAI sustavi obicno omogucuju SSO (single sing on). 
Logout (SLO - Single LogOut) je sigurnosni rizik. SAML 2.0 ima Single Logout Profile 

### Što je Shibboleth?
Shibboleth je distribuirani, federativni koncept, tj. sustav orijentiran na web aplikacije.
On uvodi SAML u primjenu. o autentifikaciji i isporuci atributa odlucuju maticne ustanove.
Vlasnici resursa(davatelji usluge) traze podatke od maticnih ustanova i na temelju dobivenog
donose odluke. Maticna ustanova i korisnik mogu kontrolirati sto se zbiva s podatcima iz
imenika.

###  Objasnite što je eduroam!
eduroam is an international roaming service for users in research, higher education and further 
education. It provides researchers, teachers, and students easy and secure network access when 
visiting an institution other than their own.

###  Objasnite koncept VO (virtualnih organizacija)!
Virtualne organizacije su dodatni repozitoriji (izvori) atributa koji su nastali zbog potrebe
da se korisnici grupiraju (u virtualnu organizaciju).


## ASBP priprema
### Dio kojeg standarda je DSP?
- x.500 standarda
### Navedite najmanje dva proširenja koja je Microsoft unio u LDAP da bi stvorio AD DS? 
- account lockout, paxxword expiration

### Koji protokol AD DS koristi kako bi implementirao sigurnu komunikaciju? 
?

### Ima li AD DS API? 
- ima, C-binding

### Navedi najmanje tri cilja replikacijske topologije AD: 
- povezati sve replike imenika
- kontrolirati latenciju i cijenu aplikacije
- preusmjeravati replikaciju izmedu site-ova

### Koje dvije particije AD koriste istu topologiju za replikaciju? 
- Schema i konfiguracija

### Što je to cijena replikacije? 
- administrativna vrijednost koja može definirati latenciju izmedu domain kontrolera

### Što je to latencija replikacije?
- posljedica multimaster modela 

### Zašto replikacija ima latenciju? 
- jer ISTG koristi cijenu kao faktor odluicivanja prilikom replikacije

### Kod replikacije, je li bolje imati manju ili veću latenciju? 
- manje je bolje

###   Replikacija izmežu sajtova je optimizirana za ___________ dok je untar sajta optimizacija usmjerena prema __________
- izmedu za brzinu
- unutar za što manje trošenje bandwitha

### Želimo li veću brzinu replikacije podatke: 
a) Treba kompresirati
b) Ne treba kompresirati 
c) Podatke treba poslati odmah
d) Podatke treba slati preko više različitih linkova

- b)

### AD posjeduje mehanizam koji se zove KCC. Koja je njegova uloga? 
- KCC koristi informacije iz AD-a da bi odredio najjeftiniju rutu za replikaciju izmedu sitova

### U slučaju ispada ili nedostupnosti DC, AD će __________________ kako bi osigurao ______________
- izabrati sljedecu dostupnu rutu
- nastavak replikacije

### Afinitet klijenata je bitna karakteristika koja utječe na brzinu rada. Ukratko objasnite o čemu je riječ.
- klijenti koriste SRV zapise u DNS da vi locirali kontrolere u svome site-u

### Nabrojite najmanje tri objekta u topologiji AD DS!
- Site - jedan ili vise Subneta
- Subnet object 
- Server object
- NTDS object

### Za bilo koji inter-site link koliko DC zna za njega? 
- ???

### Koja tri transportna mehanizma znate? 
- jednaka velika brzina unutar site-a
- Point-to-point, spori RPC over IP izmedu site-ova
- Spori, asinhronizirani SMTP izmedu site-ova

### Unutar sitea se uvijek koristi ___________________ za transport
- RPC over IP

### SMTP je protokol koji se osim za replikaciju koristi i za jedan drugi važni proces. Koji?  
- ???

###  Postoji li ograničenje što je moguće replicirati putem SMTP? Objasnite svojim riječima zašto. 
- da, moguce je replicirati samo schemu, configuration i global katalog particija jer bi veca kolicina replikacije rezultirala povecanjem vremena trajanja

### Koja je razlika između sinkrone i asinkrone replikacije? 
- sinkrona - Source DC ceka potvrdu o primljenoj replikaciji
           - brzi linkovi
- asinkrona - Source DC ne ceka potvrdu
            - Spori linkovi

### Koju vrstu replikacije koriste brzi a koju spori linkovi? 
- Brzi koriste sinkronu, Spori koriste Asinkronu

### Što je to multimaster replikacija? 
- replikacija koja omogucuje spremanje podataka od grupe racunala

### Što znači ako kažemo da je replikacija po PULL principu? 
- Da je na korisniku da se poveze s distributerom i preuzme sve podatke spremne za replikaciju

### Što je to store and forward? 
- tehnika u kojoj se informacije salju na posredničku stanicu gdje se cuvaju i kasnije šalju na konočno odrediste

### Što znači da je replikacija bazirana na „stanju“ (state based replication)? 
- ???

### Repliciraju li svi DCovi sve particije AD? Repliciraju li se promjene objekata koji nemaju promjena?
- ne, radi se re-transmisija

### Postoje 4 particije unutar AD. Nabrojite najmanje tri od njih i VRLO kratko opišite što sadrže:
- ???

### Promjene koje se propagiraju se događaju na razini:
a) Objekta
b) Atributa
c) Sheme
d) Particije

 - b) ?!(notsure)

### Jedno od navedenog nije tip promjene u AD:
a) ADD
b) COPY
c) MOVE
d) DELETE

- ???

### Što je to UTD? 
- ???
  
### Što je to High watermark? 
- ???


### Od trenutka promjene atributa do notifikacije partnera o potrebi za replikacijom dolazi:
a) Trenutno
b) Nakon 15 s
c) Nakon 5 minuta

- a) 

### Za lociranje i identifikaciju partnera u replikaciji najbitniji je: 
DNS
SSH
DC
TFTP

- DC

### Replikacija promjene passworda i hitna replikacija odvijaju se identičnim mehanizmom
Točno
Netočno

- netocno

Koje portove koriste redom:
LDAP: 389
Kerberos: 88
DNS: 53


# ASBP / 2. MI
later.

# Other
## My Notes
- Imenicki servis (Directory Service) – omogucuje pristup, pregled i odrzavanje podataka u imeniku. Vrste: globalni ili lokalni, distribuirani ili centralizirani.
- Dobar imenicki servis omogucuje brz i efikasan pristup, pretrazivanje i azuriranje, osigurava kontrolu pristupa i privatnost

X.500 – ITU/ISO imenicki standard
              Distribuirani, globalni
	  Postuje OSI, dobar koncept i design. Slozen i lose primjenjiv.
	  Namjena: korisnicima dati uslugu directory service-a, aplikacijama dati podatke u
              definiranom formatu za upravljanje porukama, prijenos podataka i slaganje X.400
	  adresa
	  Bez ogranicenja na kolicinu podataka i broj posluzitelja (spajanjem na bilo koji client
	  ima se pristup svim podacima, podaci svuda izgledaju isto)
	  Otvoreni podatkovni model (za sve tipove podataka)
	  Podaci se spremaju kao zapisi -> slozeni u cvorove u DIT (Directory Information
	  Tree)

DIT –  Stablo imenickih informacija, precizno organiziran
	Zapis (entry) opisuje objekt (osobu, organizaciju, servis...)
	Zapis ima svoje jedinstveno ime (DN – Distinguished Name) i relativno jedinstveno
	ime (RDN – Relative Distinguished Name) na svakom nivou hijerarhije

## Links and resources
- [Open LDAP](https://www.openldap.org)
- [SAML](https://developers.onelogin.com/saml)
- [SOAP](https://en.wikipedia.org/wiki/SOAP)
- [centos installation](https://www.tecmint.com/centos-7-installation/)
