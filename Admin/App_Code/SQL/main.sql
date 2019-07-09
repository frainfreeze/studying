USE [master]
GO

/********
creates tables and inserts admin account
********/

CREATE DATABASE [TKucarAppDB]
GO

USE [TKucarAppDB]
GO

SET XACT_ABORT ON -- if a Transact-SQL statement raises a run-time error, the entire transaction is terminated and rolled back

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--------------------------------- tables ---------------------------------
--user related domain tables
CREATE TABLE [dbo].[ActivityLevel](
	IDActivityLevel int CONSTRAINT PK_ActivityLevel PRIMARY KEY IDENTITY,
	[Desc] varchar(128) not null unique
)
GO
CREATE TABLE [dbo].[DiabetesType](
	IDDiabetesType int CONSTRAINT PK_DiabetesType PRIMARY KEY IDENTITY,
	[Desc] varchar(128) not null unique
)
GO
CREATE TABLE [dbo].[Gender](
	IDGender int CONSTRAINT PK_Gender PRIMARY KEY IDENTITY,
	[Desc] varchar(128) not null unique
)
GO

CREATE TABLE [dbo].[User](
	[IDUser] int CONSTRAINT PK_Users PRIMARY KEY IDENTITY,
	[Username] nvarchar(20) NOT NULL,
	[Password] nvarchar(MAX) NOT NULL,
	[Email] nvarchar(30) NOT NULL,

	[Name] nvarchar(20) NOT NULL,
	[Surname] nvarchar(20) NOT NULL,
	[DOB] date NOT NULL,
	[Weight] nvarchar(20) NOT NULL,
	[Height] nvarchar(20) NOT NULL,

	[IDActivityLevel] int CONSTRAINT FK_User_ActivityLevel FOREIGN KEY REFERENCES ActivityLevel(IDActivityLevel) NULL,
	[IDDiabetesType] int CONSTRAINT FK_User_DiabetesType FOREIGN KEY REFERENCES DiabetesType(IDDiabetesType) NULL,
	[IDGender] int CONSTRAINT FK_User_Gender FOREIGN KEY REFERENCES Gender(IDGender) NULL
)
GO

CREATE TABLE [dbo].[Administrator](
	[IDUser] [int] NOT NULL,
    CONSTRAINT [PK_Administrators] PRIMARY KEY CLUSTERED ([IDUser] ASC)
)
GO

-- helper app tables
CREATE TABLE [dbo].[MealName](
	IDMealName int CONSTRAINT PK_MealName PRIMARY KEY IDENTITY,
	[Desc] varchar(128) not null unique,
	[Enabled] bit not null
)
GO
CREATE TABLE [dbo].[GroceryType](
	IDGroceryType int CONSTRAINT PK_GroceryType PRIMARY KEY IDENTITY,
	[Desc] varchar(128) not null unique
)
GO
CREATE TABLE [dbo].[Unit](
	IDUnit int CONSTRAINT PK_Unit PRIMARY KEY IDENTITY,
	[Desc] varchar(128) not null unique,
	[Enabled] bit not null
)
GO
CREATE TABLE [dbo].[Grocery](
	IDGrocery int CONSTRAINT PK_Grocery PRIMARY KEY IDENTITY,
	[Name] varchar(128) not null unique,
	[kJ] int not null,
	[kcal] int not null,
	[IDGroceryType] int CONSTRAINT FK_Grocery_GroceryType FOREIGN KEY REFERENCES GroceryType(IDGroceryType) NULL,
	[IDUnit] int CONSTRAINT FK_Grocery_Unit FOREIGN KEY REFERENCES Unit(IDUnit) NULL,
	[Quantity] int,
	[Enabled] bit not null
)
GO

--main app part
CREATE TABLE [dbo].[Menu](
	IDMenu int CONSTRAINT PK_Menu PRIMARY KEY IDENTITY,
	[Created] datetime NOT NULL,
	[MealCount] int NOT NULL,
	[IDUSer] int CONSTRAINT FK_Menu_User FOREIGN KEY REFERENCES [User](IDUser) NULL,
	[Enabled] bit not null
)
GO
CREATE TABLE [dbo].[Meal](
	IDMeal int CONSTRAINT PK_Meal PRIMARY KEY IDENTITY,
	[IDMenu] int CONSTRAINT FK_Meal_Menu FOREIGN KEY REFERENCES [Menu](IDMenu) NULL,
	[IDMealName] int CONSTRAINT FK_Meal_MealName FOREIGN KEY REFERENCES MealName(IDMealName) NULL,
	[IDGrocery] int CONSTRAINT FK_Meal_Grocery FOREIGN KEY REFERENCES Grocery(IDGrocery) NULL,
	[Enabled] bit not null
)
GO

--combinations
CREATE TABLE [dbo].[Combination](
	IDCombination int CONSTRAINT PK_Combination PRIMARY KEY IDENTITY,
	[NumMeals] int not null,
	[DateCreated] date,
	[ValidUntil] date,
)
GO
CREATE TABLE [dbo].[CombinationHelper](
	IDCombinationHelper int CONSTRAINT PK_CombinationHelper PRIMARY KEY IDENTITY,
	[IDMealName] int CONSTRAINT FK_CombinationHelper_MealName FOREIGN KEY REFERENCES MealName(IDMealName) NULL,
	[PercentFat] int not null,
	[PercentCarb] int not null,
	[PercentProtein] int not null,
	[Total] int not null,
	[IDCombination] int CONSTRAINT FK_CombinationHelper_Combination FOREIGN KEY REFERENCES Combination(IDCombination) NULL
)
GO



--------------------------------- procedures ---------------------------------

CREATE PROCEDURE [dbo].[Insert_User]
	@Username NVARCHAR(20),
	@Password NVARCHAR(20),
	@Email NVARCHAR(30),
	
	@Name nvarchar(20),
	@Surname nvarchar(20),
	@DOB date,
	@Weight nvarchar(20),
	@Height nvarchar(20),

	@IDActivityLevel int,
	@IDDiabetesType int,
	@IDGender int
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT [IDUser] FROM [User] WHERE Username = @Username)
	BEGIN
		SELECT -1 -- Username exists.
	END
	ELSE IF EXISTS(SELECT [IDUser] FROM [User] WHERE Email = @Email)
	BEGIN
		SELECT -2 -- Email exists.
	END
	ELSE
	BEGIN
		INSERT INTO [Users] ([Username],[Password],[Email], [Name],[Surname],[DOB],[Weight],[Height], [IDActivityLevel],[IDDiabetesType],[IDGender])
		VALUES              (@Username, @Password, @Email,  @Name, @Surname, @DOB, @Weight, @Height,  @IDActivityLevel, @IDDiabetesType, @IDGender)

		SELECT SCOPE_IDENTITY() -- UserId			   
     END
END

GO


CREATE PROCEDURE [dbo].[Validate_User]
	@Username NVARCHAR(20),
	@Password NVARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IDUser INT
	
	SELECT @IDUser = IDUser
	FROM [User] WHERE Username = @Username AND [Password] = @Password
	
	IF @IDUser IS NOT NULL
	BEGIN
		IF EXISTS(SELECT IDUser FROM Administrator WHERE IDUser = @IDUser)
		BEGIN
			SELECT @IDUser [IDUser] -- User Valid
		END
		ELSE
		BEGIN
			SELECT -2 -- Account is not admin.
		END
	END
	ELSE
	BEGIN
		SELECT -1 -- User invalid.
	END
END
GO


CREATE PROCEDURE GetUsersForCSV
AS
BEGIN
	SELECT u.[IDUser],u.[Name],u.[Surname],u.[Username],u.[Email],u.[DOB],u.[Weight],u.[Height] ,g.[Desc] as [Gender],d.[Desc] as [Tip Dijabetesa], a.[Desc] as [Raz.Fiz. aktivnosti]
	FROM [User] as u
	inner join [Gender] as g on u.IDGender = g.IDGender
	inner join [DiabetesType] as d on u.IDDiabetesType = d.IDDiabetesType
	inner join [ActivityLevel] as a on u.IDActivityLevel = a.IDActivityLevel
END
GO


CREATE PROCEDURE GetBuiltinTables
AS
BEGIN
	SELECT * FROM Gender
	SELECT * FROM DiabetesType
	SELECT * FROM ActivityLevel
END
GO


CREATE PROCEDURE GetGroceries
AS
BEGIN
	SELECT g.[IDGrocery] as [IDGrocery], g.[Name] as [Name], g.[kJ] as [kJ], g.[kcal] as [kcal], gt.[Desc] as [Grocery Type], u.[Desc] as [Unit], g.[Quantity] as [Quantity], g.[Enabled] as [Enabled]
	FROM [Grocery] as g
	inner join [GroceryType] as gt on g.IDGroceryType = gt.IDGroceryType
	inner join [Unit] as u on g.IDUnit = u.IDUnit
END
GO


CREATE PROCEDURE GetCombination
	@IDCombination int
AS
BEGIN
select m.[Desc] as MealName, c.PercentCarb as Carbs, c.PercentFat as Fat, c.PercentProtein as Protein, c.Total from CombinationHelper as c
join MealName as m on c.IDMealName=m.IDMealName
where IDCombination = @IDCombination
END
GO

--fetches menu for given date, todo: require user id to fetch menus for correct user
CREATE PROCEDURE GetMenu
	@date1 date
AS
BEGIN
select mn.[Desc], g.[Name], g.kcal, g.kJ, u.[Desc], g.Quantity 
from Meal as m inner join MealName as mn on m.IDMealName=mn.IDMealName 
inner join Grocery as g on m.IDGrocery=g.IDGrocery 
inner join Unit as u on g.IDUnit=u.IDUnit 
where m.IDMenu = (
	select IDMenu from Menu 
	where Created=@date1
	)
END
GO

--------------------------------- populate tables ---------------------------------
-- fill user related tables
INSERT INTO [ActivityLevel] (
	[Desc]
)
VALUES
	('Slaba aktivnost'),
	('Umjerena aktivnost'),
	('Intezivna aktivnost')
GO
INSERT INTO [DiabetesType] (
	[Desc]
)
VALUES
	('Tip 1'),
	('Tip 2')
GO
INSERT INTO [Gender] (
	[Desc]
)
VALUES
	('Zena'),
	('Muskarac')
GO

-- create test accounts
INSERT INTO [User] (
	[Username],[Password],[Email],[Name],[Surname],[DOB],[Weight],[Height], [IDActivityLevel],[IDDiabetesType],[IDGender]
)
VALUES
	('admin', '12345', 'admin@diabpro.com', '','','1/1/2001','','',3,1,1),
	('tom123', '12345', 'tom@tom.com', 'Tomislav','Kucar','3/1/1998','75.1','193',2,1,2),
	('johnny', 'pwd', 'john@gmail.com', 'John','Smith','1/1/1996','82','189',1,2,1),
	('tom', '12345', 'tom@tom.com', 'Tomislav','Kucar','1/1/1998','75.1','193',2,1,2),
	('tom12', '12345', 'tom@tom.com', 'Tomislav','Kucar','2/1/1998','75.1','193',2,1,2),
	('tom1234', '12345', 'tom@tom.com', 'Tomislav','Kucar','4/1/1998','75.1','193',2,1,2),
	('tom12345', '12345', 'tom@tom.com', 'Tomislav','Kucar','5/29/1998','75.1','193',2,1,2),
	('kelj0x0f', '12345', 'kk@diabpro.com', 'Keljo','keglevich','9/21/1998','75.1','193',2,1,1),
	('kelj0x03', '12345', 'kk@diabpro.com', 'Keljo','keglevich','9/22/1998','75.1','193',2,1,1),
	('kelj0x02', '12345', 'kk@diabpro.com', 'Keljo','keglevich','9/23/1998','75.1','193',2,1,1),
	('kelj0x01', '12345', 'kk@diabpro.com', 'Keljo','keglevich','9/24/1998','75.1','193',2,1,1),
	('kelj0x00', '12345', 'kk@diabpro.com', 'Keljo','keglevich','9/25/1998','75.1','193',2,1,1),
	('grgaalinecvarak1', '12345', 'rr@diabpro.com', 'Grga','NotCvarak','1/1/1998','75.1','193',2,1,2),
	('grgaalinecvarak2', '12345', 'rr@diabpro.com', 'Grga','NotCvarak','1/1/1998','75.1','193',2,1,2),
	('grgaalinecvarak3', '12345', 'rr@diabpro.com', 'Grga','NotCvarak','1/1/1998','75.1','193',2,1,2),
	('grgaalinecvarak4', '12345', 'rr@diabpro.com', 'Grga','NotCvarak','1/1/1998','75.1','193',2,1,2)
GO

-- enable admin account
INSERT INTO Administrator
SELECT IDUser FROM [User] WHERE Username = 'admin'
GO

--meal helper tables
INSERT INTO [MealName] (
	[Desc],[Enabled]
)
VALUES
    ('Zajutrak',1),
	('Dorucak',1),
	('Rucak',1),
	('Vecera',1),
	('Marenda',0)
GO

INSERT INTO [GroceryType] (
	[Desc]
)
VALUES
    ('Ugljikohidrati'),
    ('Bjelancevine'),
    ('Masti')
GO

INSERT INTO [Unit] (
	[Desc],[Enabled]
)
VALUES
    ('g',1),
    ('kom',1),
    ('salica',1),
    ('zlica',1)
GO


-- groceries
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Mlijeko',167,40,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Jogurt',360,40,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Kiselo vrhnje',800,192,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Puding',560,134,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Sirni namaz',480,115,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Topljeni sir',1275,385,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Tvrdi sir',1555,372,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Svježi kravlji sir',101,72,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Zrnati sir',396,92,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Janjetina',875,211,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Jetra',575,137,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Kunić',550,132,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Mljeveno, miješano meso',1060,253,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Piletina',600,144,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Puretina',970,231,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Slanina',2530,605,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Srnetina',515,123,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Svinjetina',1445,345,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Šunka dimljena i pršut',1653,385,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Šunka (kuhana)',1145,274,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Šunka pureća/pileća',525,128,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Teletina',390,105,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Bakalar',295,76,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Dagnja',270,66,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Grgeč',295,75,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Haringa',650,155,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Inćun',310,89,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Jastog',305,86,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Lignja',295,77,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Losos',910,217,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Pastrva',470,112,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Sardine',1005,240,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Skuša',820,195,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Šaran',270,65,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Škampi',310,91,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Štuka',305,85,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Tuna',1270,303,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Crni kruh',1046,250,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Dvopek',1590,397,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Griz',1550,370,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Kolači od samog tijesta',1315,314,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Kokice',1580,376,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Kruh sa cijelim zrnima',1004,240,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Kukuruzni kruh',915,220,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Kukuruzne pahuljice',1625,388,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Musli',1550,371,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Polubijeli kruh',1055,252,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Riža ljuštena',1540,368,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Riža neljuštena',1550,371,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Soja u zrnu',1785,427,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Sojin sir (tofu)',285,72,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Tjestenina sa jajima',1630,390,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Zobene pahuljice',1680,402,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Čips od krumpira',2375,568,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Krumpir',355,85,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Njoki',490,117,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Pomfrit',1130,270,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Ananas',230,56,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Banane',410,99,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Borovnice',260,62,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Breskve',192,46,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Dinje',100,24,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Grožđe',295,70,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Grejp',180,42,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Jabuka',218,52,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Jagode',150,36,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Kivi',230,55,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Kruške',230,55,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Lubenica',100,24,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Maline',170,40,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Mandarine',200,48,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Marelice',230,54,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Naranče',226,54,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Ribizl (crveni)',190,45,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Ribizl (crni)',260,63,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Šljive',245,58,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Trešnje',240,57,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Artičoke',90,23,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Brokula',140,33,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Cikla',150,37,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Cvjetača',117,28,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Celer',159,38,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Grah',480,110,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Grašak',389,93,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Kelj',190,46,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Krastavci',42,10,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Kupus (kiseli)',109,26,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Kupus (slatki)',218,52,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Luk',175,42,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Mrkva',146,35,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Paprika',117,28,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Patlidžan',110,26,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Poriluk',160,38,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Rajčica',80,19,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Šampinjoni',101,24,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Šparoga',80,20,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Špinat',96,23,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Zelena salata',59,14,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Zelje',100,25,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Maslac',3190,755,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Margarin',3040,720,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Majoneza',3200,761,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Majoneza light',1440,341,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Svinjska mast',3800,900,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Biljna mast',3150,753,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Tartar umak',1975,480,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Ulje maslinovo',3800,900,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Ulje repino',3800,900,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Ulje od suncokreta',3885,928,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Ulje od kukuruznih klica',3891,930,3,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Cijelo jaje',700,167,2,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Biskvit masni',1945,462,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Bomboni tvrdi obični',1630,390,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Bomboni voćni',1220,292,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Čokolada mliječna',2355,563,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Čokolada za kuhanje',2355,564,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Čokoladni bomboni',1985,490,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Čokoladni namaz - nutella',2220,534,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Guma za žvakanje',1170,280,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Gumeni bomboni',1450,345,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Keks sa čokoladnim preljevom',2200,530,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Marmelada',1090,261,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Med',1275,303,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Napolitanke',2305,550,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Piškoti',1635,393,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Plazma keks',1810,440,1,1,100,1);
INSERT INTO [Grocery]([Name],[kJ],[kcal],[IDGroceryType],[IDUnit],[Quantity],[Enabled]) VALUES ('Puding u prahu',1600,380,1,1,100,1);
GO

--combinations
--- v1
insert into Combination values(3,'1/1/2002','1/1/2021')
go

insert into CombinationHelper values(1,25,25,50,25,1)
insert into CombinationHelper values(2,25,25,50,50,1)
insert into CombinationHelper values(3,25,25,50,25,1)
GO

--- v2
insert into Combination values(4,'1/1/2002','1/1/2022')
go

insert into CombinationHelper values(1,25,25,50,25,2)
insert into CombinationHelper values(2,25,25,50,25,2)
insert into CombinationHelper values(3,25,25,50,25,2)
insert into CombinationHelper values(3,25,25,50,25,2)
GO

--- test user menu
--created, mealcount, iduser, enabled
insert into Menu values ('10/1/2019',3,4,1)
--idmenu, idmealname, idgrocery, enabled
insert into Meal values (1,2,46,1)
insert into Meal values (1,3,10,1)
insert into Meal values (1,4,65,1)
go

--- test user menu2
--created, mealcount, iduser, enabled
insert into Menu values ('5/5/2019',4,4,1)
--idmenu, idmealname, idgrocery, enabled
insert into Meal values (2,2,46,1)
insert into Meal values (2,3,10,1)
insert into Meal values (2,4,65,1)
insert into Meal values (2,4,65,1)
go

select (Convert(nvarchar(50), Created)) from menu