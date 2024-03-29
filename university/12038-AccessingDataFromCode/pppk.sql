﻿use [master]

DECLARE @kill varchar(8000) = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id  = db_id('PPPK_DATABASE')

EXEC(@kill);

IF EXISTS(select * from sys.databases where name='PPPK_DATABASE')
DROP DATABASE [PPPK_DATABASE]
go

create database [PPPK_DATABASE]
go

use PPPK_DATABASE
go

create table [tip_vozila] (
    [id]  int constraint PK_tip_vozila primary key identity,
    [tip] nvarchar(32) not null
)

create table [mjesto] (
    [id]    int constraint PK_mjesto primary key identity,
    [naziv] nvarchar(128) not null
)

create table [status] (
    [id]     int constraint PK_status primary key identity,
    [status] nvarchar(32) not null
)

create table [vozac] (
    [id]            int constraint PK_vozac primary key identity,
    [ime]           nvarchar(128) not null,
    [prezime]       nvarchar(128) not null,
    [broj_mobitela] nvarchar(32) not null,
    [broj_vozacke]  nvarchar(16) not null
)

create table [vozilo](
    [id]                 int constraint PK_vozilo primary key identity,
    [tip_vozila_id]      int constraint FK__tip_vozila__vozilo foreign key references [dbo].[tip_vozila](id),
    [marka]              nvarchar(128) not null,
    [godina_proizvodnje] int not null,
    [pocetni_km]         decimal(10,1) not null,
    [trenutni_km]        decimal(10,1) not null
)

create table [putni_nalog](
    [id]              int constraint PK_putni_nalog primary key identity,
    [vozac_id]        int constraint FK__vozac__putni_nalog foreign key references [dbo].[vozac](id),
    [vozilo_id]       int constraint FK__vozilo__putni_nalog foreign key references [dbo].[vozilo](id),
    [status_id]       int constraint FK__status__putni_nalog foreign key references [dbo].[status](id),
    [datum_izrade]    date not null,
    [datum_pocetka]   date not null,
    [datum_zavrsetka] date not null
)

create table [zauzece_vozilo](
    id	        int constraint PK_zauzece_vozilo primary key identity,
    [vozilo_id] int constraint FK__vozilo__zauzece_vozilo foreign key references [dbo].[vozilo](id),
    [datum]     date not null
)

create table [zauzece_vozac](
    id	        int constraint PK_zauzece_vozac primary key identity,
    [vozac_id]  int constraint FK__vozac__zauzece_vozac foreign key references [dbo].[vozac](id),
    [datum]     date not null
)

create table [servis](
    id	            int constraint PK_servis primary key identity,
    [vozilo_id]	    int constraint FK__vozilo__servis foreign key references [dbo].[vozilo](id),
    [datum_servisa] date not null,
    [naziv_servisa] nvarchar(128),
    [cijena]        decimal(10,2) not null,
    [info]          nvarchar(512) not null
)
go

create table [kupnja_goriva]
(
    id	             int constraint PK_kupnja_goriva primary key identity,
    [putni_nalog_id] int constraint FK__putni_nalog__kupnja_goriva foreign key references [dbo].[putni_nalog](id),
    [mjesto_id]      int constraint FK__mjesto__kupnja_goriva foreign key references [dbo].[mjesto](id),
    [cijena]         decimal(10,2) not null,
    [kolicina]       decimal(10,2) not null,
    [datum]          date not null
)
create table [ruta]
(
    id                 int constraint PK_ruta primary key identity,
    [putni_nalog_id]   int constraint FK__putni_nalog__ruta foreign key references [dbo].[putni_nalog](id),
    [x_koordinata_a]   decimal(20,10) not null,
    [y_koordinata_a]   decimal(20,10) not null,
    [x_koordinata_b]   decimal(20,10) not null,
    [y_koordinata_b]   decimal(20,10) not null,
    [km_izmedu_a_b]    decimal(10,2) not null,
    [prosjecna_brzina] decimal(6,2) not null
)
go


-----------------------------------------------------------------
--PROCEDURES
-----------------------------------------------------------------
create proc [dbo].[insert_vozac]
  @ime nvarchar(128),
  @prezime nvarchar(128),
  @broj_mobitela nvarchar(32),
  @broj_vozacke nvarchar(16) 
as
    insert into vozac(ime,prezime,broj_mobitela,broj_vozacke)
    values(@ime, @prezime, @broj_mobitela, @broj_vozacke)
    select SCOPE_IDENTITY()
go

create proc [dbo].[obrisi_vozaca]
    @id int
as
    if exists(select id from [dbo].[vozac] where id=@id) begin
        begin try
            begin transaction
                delete from [dbo].[zauzece_vozac] where vozac_id=@id
                delete from [dbo].[ruta] where 
                    putni_nalog_id in(
                        select id from [dbo].[putni_nalog] where vozac_id=@id
                    )
                delete from [dbo].[kupnja_goriva] where 
                    putni_nalog_id in(
                        select id from [dbo].[putni_nalog] where vozac_id=@id
                    )
		        delete from [dbo].[putni_nalog] where vozac_id=@id
                delete from [dbo].[vozac] where id=@id
			commit tran
        end try
        begin catch
            if @@TRANCOUNT > 0
                rollback tran
            select null;
        end catch
	end
	else begin
		select null
    end
go

create proc [dbo].[insert_vozilo]
    @marka nvarchar(128),
    @tip_vozila_id int,
    @pocetni_km decimal(10,1),
    @trenutni_km decimal(10,1),
    @godina_proizvodnje int
as
    insert into [dbo].[vozilo](marka,tip_vozila_id,pocetni_km,trenutni_km,godina_proizvodnje)
    values(@marka, @tip_vozila_id,@pocetni_km,@trenutni_km,@godina_proizvodnje)
    select SCOPE_IDENTITY()
go

create proc [dbo].[insert_servis]
    @naziv_servisa nvarchar(128),
    @datum datetime,
    @vozilo_id int,
    @info nvarchar(512),
    @cijena decimal(10,2)
as
      insert into [dbo].[servis](naziv_servisa,datum_servisa,vozilo_id,info,cijena)
      values(@naziv_servisa,@datum, @vozilo_id,@info,@cijena)
      select SCOPE_IDENTITY()
go

create proc [dbo].[obrisi_servis]
    @id int
as
    if exists(select id from [dbo].[servis] where id=@id) begin
        delete from [dbo].[servis] where id=@id
	end
	else begin
		select null
    end    
go

create proc [dbo].[obrisi_vozilo]
    @id int
as
     if exists(select id from [dbo].[vozilo] where id=@id) begin
        begin try
            begin transaction
                delete from [dbo].[zauzece_vozilo] where vozilo_id=@id
                delete from [dbo].[servis] where vozilo_id=@id
                delete from [dbo].[ruta] where 
                    putni_nalog_id in(
                        select id from [dbo].[putni_nalog] where vozilo_id=@id
                    )
                delete from [dbo].[kupnja_goriva] where 
                    putni_nalog_id in(
                        select id from [dbo].[putni_nalog] where vozilo_id=@id
                    )
		        delete from [dbo].[putni_nalog] where vozilo_id=@id
                delete from [dbo].[vozilo] where id=@id
            commit tran
        end try
        begin catch
            if @@TRANCOUNT > 0
                rollback tran
            select null;
        end catch
	end
	else begin
		select null
    end
go

create proc [dbo].[dohvati_putni_nalog]
    @id int
as
    if exists(select id from [dbo].[putni_nalog] where id=@id) begin
        select pn.*,s.[status],v.ime,v.prezime,vo.marka,vo.godina_proizvodnje,tv.tip from [dbo].[putni_nalog] as pn
            left join [dbo].[vozac] as v on pn.vozac_id=v.id
            left join [dbo].[vozilo] as vo on pn.vozilo_id=vo.id
            left join [dbo].[tip_vozila] as tv on vo.tip_vozila_id=tv.id
            left join [dbo].[status] as s on pn.status_id=s.id
        where pn.id=@id
    end
    else begin
        select null
    end
go

create proc [dbo].[dohvati_sve_putne_naloge]
as
    select pn.*,s.[status],v.ime,v.prezime,vo.marka,vo.godina_proizvodnje,tv.tip from [dbo].[putni_nalog] as pn
        left join [dbo].[vozac] as v on pn.vozac_id=v.id
        left join [dbo].[vozilo] as vo on pn.vozilo_id=vo.id
        left join [dbo].[tip_vozila] as tv on vo.tip_vozila_id=tv.id
        left join [dbo].[status] as s on pn.status_id=s.id
go

create proc [dbo].[insert_putni_nalog]
    @vozac_id int,
    @vozilo_id int,
    @status_id int,
    @datum_pocetka date,
    @datum_zavrsetka date
as
    insert into [dbo].[putni_nalog](vozac_id,vozilo_id,status_id,datum_izrade,datum_pocetka,datum_zavrsetka)
    values(@vozac_id,@vozilo_id,@status_id,GETDATE(), @datum_pocetka, @datum_zavrsetka)
    select SCOPE_IDENTITY()
go

create proc [dbo].[obrisi_putni_nalog]
    @id int
as
     if exists(select id from [dbo].[putni_nalog] where id=@id) begin
        begin try
            begin transaction
                delete from [dbo].[ruta] where putni_nalog_id=@id
                delete from [dbo].[kupnja_goriva] where putni_nalog_id=@id
                delete from [dbo].[putni_nalog] where id=@id
            commit tran
        end try
        begin catch
            if @@TRANCOUNT > 0
                rollback tran
            select null;
        end catch
	end
	else begin
		select null
    end
go

create proc [dbo].[insert_ruta]
    @putni_nalog_id   int,
    @x_koordinata_a   decimal(20,10),
    @y_koordinata_a   decimal(20,10),
    @x_koordinata_b   decimal(20,10),
    @y_koordinata_b   decimal(20,10),
    @km_izmedu_a_b    decimal(10,2),
    @prosjecna_brzina decimal(6,2)
as
    insert into ruta
    values(@putni_nalog_id,@x_koordinata_a,@y_koordinata_a,@x_koordinata_b,@y_koordinata_b,@km_izmedu_a_b,@prosjecna_brzina)
go

create proc [dbo].[obrisi_rute]
    @id int
as 
    delete from [dbo].[ruta] where putni_nalog_id=@id
go

create proc [dbo].[obrisi_rutu]
    @id int
as
   if exists(select id from [dbo].[ruta] where id=@id) begin
        begin try
            begin transaction
                delete from [dbo].[ruta] where id=@id
            commit tran
        end try
        begin catch
            if @@TRANCOUNT > 0
                rollback tran
            select null;
        end catch
	end
	else begin
		select null
    end  
go

create proc enable_id_insert
as
    exec sp_MSForEachTable 'SET IDENTITY_INSERT ? ON'
go

create proc disable_id_insert
as
    exec sp_MSForEachTable 'SET IDENTITY_INSERT ? OFF'
go

create proc [dbo].[insert_dummy_data]
as
    insert into [dbo].[tip_vozila]
    values ('Sedan'),('Convertible'),('Limo'), ('Coupe'), ('Minivan'), ('Jeep')
    insert into [dbo].[mjesto]
    values ('Zagreb'),('Bjelovar'),('Split'),('Karlovac'),('Dubrovnik'),('Rijeka'),('Zadar'),('Vukovar')
    insert into [dbo].[status]
    values ('Traje'),('Zavrsio')
    insert into [dbo].[vozac]
    values 
    ('Marica','Krampotic','+385912345678','12345678'),
    ('Dzon','Slow','+385912345678', '87654321')
    insert into [dbo].[vozilo]
    values
    (4,'Mazda RX-7',1979,123000,151000),
    (1,'Toyota Camry',2018,1435,15215)
    insert into [dbo].[putni_nalog]
    values
    (1,1,2,'1/10/2020','1/10/2020','1/11/2020'),
    (2,2,2,'12/10/2019','12/10/2019','12/13/2020')
    insert into [dbo].[zauzece_vozac]
    values
    (1,'1/10/2020'),
    (1,'1/11/2020'),
    (2,'12/10/2019'),
    (2,'12/11/2019'),
    (2,'12/12/2019'),
    (2,'12/13/2019')
    insert into [dbo].[zauzece_vozilo]
    values
    (1,'1/10/2020'),
    (1,'1/11/2020'),
    (2,'12/10/2019'),
    (2,'12/11/2019'),
    (2,'12/12/2019'),
    (2,'12/13/2019')
    insert into [dbo].[servis]
    values
    (1,'12/14/2019','Tokic',500.00,'Zamjena bos pumpe')
    insert into [dbo].[kupnja_goriva]
    values
    (1,1,9.81,20.00,'1/10/2020'),
    (2,2,9.7,15.00,'12/11/2019'),
    (2,3,9.90,20.00,'12/12/2019')
    insert into [dbo].[ruta]
    values
    (1,50.1241241,40.1241251,40.5215121,50.512411,20.1,110.2),
    (1,60.1241241,10.1241251,40.5215121,90.512411,30.21,90.2),
    (2,70.1241241,30.1241251,30.5215121,60.512411,40.31,70.2),
    (2,80.1241241,40.1241251,20.5215121,70.512411,50.41,70.2)
go

create proc [dbo].[clean_database]
as
    delete from [dbo].[zauzece_vozac]
    delete from [dbo].[zauzece_vozilo]
    delete from [dbo].[ruta]
    delete from [dbo].[kupnja_goriva]
    delete from [dbo].[mjesto]
    delete from [dbo].[servis]
    delete from [dbo].[putni_nalog]
    delete from [dbo].[status]
    delete from [dbo].[vozilo]
    delete from [dbo].[tip_vozila]
    delete from [dbo].[vozac]
    exec sp_MSforeachtable 'DBCC CHECKIDENT ([?], reseed, 0)'
	SET NOCOUNT ON 
	DECLARE @time VARCHAR(16)
	SET @time = CONVERT(VARCHAR(16),GETDATE(),114)
	RAISERROR( 'Cleaned database at %s', 2, 1, @time) WITH NOWAIT
go

exec [dbo].[insert_dummy_data]