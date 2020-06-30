Tomislav Kucar, 3RP2
Ishod 1
- Grgec je na faksu/


Ishod 2: zadatak


Ishod 3
- /
- Mi mozemo primjerice isprogramirati nas posluzitelj da izvrsava odredene radnje prilikom dohvata resursa (metoda GET) no to se smatra losom praksom.
- Prezentacijski sloj
- Asinkronu komunikaciju mozemo postici na razne nacinu u raznim tehnologijama. Npr u pythonu je to async and await keywords, u web aplikacijama (javascript) je to najcesce AJAX
- Na serveru imamo service, agenta koji odgovara na zahtjeve koje salje klijentska web aplikacija. Aplikacija posalje zahtjev i dok ceka nastavi dalje izvrsavanje, kad server odgovori aplikacija preuzme podatke i nesto napravi s njima ono sto smo specificirali.


Ishod 4
- Omotnica SOAP poruke je XML
- SOAP poruke mozemo slati na bezbroj nacina no najcesce ih saljemo HTTP-om.
- U elementima binding i service
- U elementu opis "description"
(defintion - naziv usluge, types - tipovi podataka, message - poruke, portype(interface), binding - nacin izvedbe usluge, service - adresa usluge)

Ishod 5: zadatak


Ishod 6
- Pod normizacijom podrazumjevamo neki definirani skup pravila (standardi). Osnovno nacelo je da se norme temelje na znanstvenim, strucnim i provjerenim rezultatima
- Otvorenost normi i tehnickih specifikacija je bitna jer potice potencijalne korisnike da ih korsite (sto bi bilo manje u slucaju skupih privatnih normi) cime se ostvaruje veca komatibilnost i interoperatibilnost izmedu clanova trzista, sustava i sl. Primjerice, xml, cesto koristeni i popularni format strukturiranja podataka. Kada nebi bio standardiziran i javan vecina tvrtki bi koristila ili neki drugi format ili izmislile svoj vlastiti, sto bi otezalo interoperatibilnost sustava koji proizvode.
- Faze kod donosenja normu u RH su:
    - potreba za novom normom ili prihvacanje neke medunarodne odnosno europske norme
    - priprema nacrta hrvatske norme
    - nacrt odbora
    - javna rasprava na kojoj se nacrt norme razmatra i ako se ne pronade primjedba prelazi se na:
    - odobbravanje konacnog nacrta hrvatske norme
    - norma se objavljuje
- U hrvatskoj imamo sustav velikih placanja za medubankovne transakcije te nacionalni klirinski sustav za izvodenje malih i masivnih placanja
postoje i target2-hr i euroNKS za transakcije sepa kreditnim transferima u eurima
- Znakovi u unicode notaciji se oznacavaju sa prefiskom U+ nakon cega slijedi hex kod za znak koji zelimo. Unicode se proporucuje i koristi bilo gdje gje imamo tekst, ali najvise za web.


Ishod 7
- Sigurnost kriptografksi algoritama sa simetricnim i asimetricnim kljucem ovisi o duzini kljuca i sigurnoj pohrani kljuca. Kod simetricnih algoritama je takoder bitan nacin razmjene kljuca.
- Kad zelimo generirati elektronicki potpis moramo generirati sazetak poruke i onda ga kriptirati svojim privatnim kljucem, dok kod generiranja omotnice moramo generirati kljuc i njime enkriptirati poruku, nakon cega kriptiramo taj kljuc javnim kljucem primatelja i naposljetku saljemo kljuc i poruku zajedno. (npr PGP)
- Kod napada kriptiranim tekstom napadac poznaje samo kriptirani tekst, mozemo deducirati text ili cak key pomocu kripto i frequency analysis
- DoS (denial of service) je tip napada u kojem racunalo "napada" drugo racunalo ili sustav slanjem poplave tcp i ili udp paketa. DDoS napada je verzija DoS napada u kojoj vise napadaca (racunala) napada jedno racunalo ili sustav, distribuirani napad. Od DDoS-a se ne mozemo u potpunosti zastiti no mozemo ga mitigirati pomocu rate-limitinga, load balancingom ili koristenjem servisa poput cloudflare.
- SAML se temelji na XML jeziku i shemama te se moze osloniti na HTTP, SOAP, TLS/SSL protokole. Primjer koristenja je autentifikacija i autorizacija izmedu dvije sigurnosne domene kako bi prenjeli podatke.