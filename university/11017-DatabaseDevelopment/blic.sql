/* Zadatak - ishod 4
Napravite proceduru koja ce kroz ulazne parametre primati podatke
o nekom kupcu: ime, prezime, email, telefon, te naziv grada i drzave kupca.

Procedura provjerava postoji li taj kupac, njegov grad i njegova drzava u bazi.
Postojanje kupca provjeriti pomocu imena, prezimena i emaila.
Ukoliko neki od podataka nedostaje procedura ga treba upisati.
Podatke koji vec postoje ne treba ponovo upisivati.

Neovisno o tome jesu li podatci postojali ili ih je procedura upisala,
kroz izlazni parametar treba vratiti jednu od poruka, ovisno o tome
sto je procedura napravila;

"novi kupac (IDKupac), novi grad(IDGrad), nova drzava (IDDrzava)"
"novi kupac (IDKupac), novi grad(IDGrad), postojeca drzava (IDDrzava)"
"novi kupac (IDKupac), postojeci grad(IDGrad), postojeca drzava (IDDrzava)"
"postojeci kupac (IDKupac), postojeci grad(IDGrad), postojeca drzava (IDDrzava)"
Pritom su IDKupac, IDGrad i IDDrzava u gornjim porukama stvarni podatci iz baze.

Napraviti jedan primjer poziva procedure koji ce ispisati vrijednost 
izlaznog parametra procedure. */

create proc p1
    @ime nvarchar(50), @prezime nvarchar(50), @email nvarchar(50),
    @telefon nvarchar(25), @grad nvarchar(50), @drzava nvarchar(50)
as
    declare @idkupac int, @idgrad int, @iddrzava int

    select @idkupac = k.IDKupac
    from Kupac as k
    where k.Ime = @ime and k.Prezime = @prezime and k.Email = @email

    select @idgrad = g.IDGrad
    from Grad as g
    where g.Naziv = @grad

    select @iddrzava = d.IDDrzava
    from Drzava as d
    where d.Naziv = @drzava

    IF @idkupac is null and @idgrad is null and @iddrzava is null
    BEGIN
        insert into Drzava(Naziv)
        values (@drzava)
        set @iddrzava = SCOPE_IDENTITY()
        
        insert into Grad(Naziv, DrzavaID)
        values (@grad, @iddrzava)
        set @idgrad = SCOPE_IDENTITY()
        
        insert into Kupac(Ime, Prezime, Email, Telefon, GradID)
        values (@ime, @prezime, @email, @telefon, @idgrad)
        set @idkupac = SCOPE_IDENTITY()
        
        print 'Novi Kupac(' + cast(@idkupac as nvarchar(50)) + '), novi grad(' + cast(@idgrad as nvarchar(50)) + '), nova drzava(' + cast(@iddrzava as nvarchar(50)) + ').'
    END
    ELSE IF @idkupac is null and @idgrad is null and @iddrzava is not null
    BEGIN
        insert into Grad(Naziv, DrzavaID)
        values (@grad, @iddrzava)
        set @idgrad = SCOPE_IDENTITY()
        
        insert into Kupac(Ime, Prezime, Email, Telefon, GradID)
        values (@ime, @prezime, @email, @telefon, @idgrad)
        set @idkupac = SCOPE_IDENTITY()
        
        print 'Novi Kupac(' + cast(@idkupac as nvarchar(50)) + '), novi grad(' + cast(@idgrad as nvarchar(50)) + '), postojeca drzava(' + cast(@iddrzava as nvarchar(50)) + ').'
    END
    ELSE IF @idkupac is null and @idgrad is not null and @iddrzava is not null
    BEGIN
        insert into Kupac(Ime, Prezime, Email, Telefon, GradID)
        values (@ime, @prezime, @email, @telefon, @idgrad)
        set @idkupac = SCOPE_IDENTITY()
        
        print 'Novi Kupac(' + cast(@idkupac as nvarchar(50)) + '), postojeci grad(' + cast(@idgrad as nvarchar(50)) + '), postojeca drzava(' + cast(@iddrzava as nvarchar(50)) + ').'
    END
    ELSE
        BEGIN
        print 'Postojeci Kupac(' + cast(@idkupac as nvarchar(50)) + '), postojeci grad(' + cast(@idgrad as nvarchar(50)) + '), postojeca drzava(' + cast(@iddrzava as nvarchar(50)) + ').'
    END

-- Declare a variable to return the results of the function. 
DECLARE @ret nvarchar(50);   

-- Execute the function while passing a value to the @status parameter
EXEC @ret = dbo.p1("Ivan", "Ivanovic", "ivan@example.com", "056067253", "zagreb", "hrvatska") 

-- View the returned value.  The Execute and Select statements must be executed at the same time.  
SELECT N'Function returned: ' + @ret; 