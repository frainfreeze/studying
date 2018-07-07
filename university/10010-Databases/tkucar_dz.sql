create database zadaca
go
use zadaca
go

create table Lokacija
(
	IDLokacija int primary key identity,
	Grad nvarchar(50),
	Adresa nvarchar(50)
)

create table TipAparata
(
	IDTipAparata int primary key identity,
	NazivTipAparata nvarchar(50)
)

create table Aparat
(
	IDAparat int primary key identity,
	TipAparataID int foreign key references TipAparata(IDTipAparata)
)

create table Klijent
(
	IDKlijent int primary key identity,
	ImeKlijenta nvarchar(50) not null,
	OIBKlijenta nvarchar(11) constraint UQ_OIBKlijent unique not null,
	LokacijaID int foreign key references Lokacija(IDLokacija)
)

create table Povijest
(
	IDPovijest int primary key identity,
	KlijentID int foreign key references Klijent(IDKlijent),
	AparatID int foreign key references Aparat(IDAparat),
	PocetniDatum date not null,
	KranjiDatum date,
	Constraint CHK_KranjiDatum CHECK(KranjiDatum>PocetniDatum)
)