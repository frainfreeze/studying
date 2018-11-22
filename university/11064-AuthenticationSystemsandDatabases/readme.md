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

## Ispitna pitanja: 2. predavanje: AAA, IdM, AAI
### Objasni što označava kratica AAA!
- Autentikacija   
- Autorizacija
- Accounting(auditing)

### Objasnite razliku između procesa autentikacije i autorizacije
Autentikacijom se provjerava elektronicki identitet korisnika a autorizacijom
se korisniku dodjeljuje odnosno oduzima utvrdena razina prava prstupa resursu.

### Opišite model AAI!
![](https://imgur.com/7Yv8x4Gl.png)

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


- [Open LDAP](https://www.openldap.org)
- [SAML](https://developers.onelogin.com/saml)
- [SOAP](https://en.wikipedia.org/wiki/SOAP)
- [centos installation](https://www.tecmint.com/centos-7-installation/)
