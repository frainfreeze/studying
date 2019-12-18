/********
creates tables and inserts admin account
********/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--------------------------------- tables ---------------------------------

CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](30) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NULL,
	CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserId] ASC)
)
GO

CREATE TABLE [dbo].[Administrators](
	[UserId] [int] NOT NULL,
    CONSTRAINT [PK_Administrators] PRIMARY KEY CLUSTERED ([UserId] ASC)
)

GO


--------------------------------- procedures ---------------------------------

CREATE PROCEDURE [dbo].[Insert_User]
	@Username NVARCHAR(20),
	@Password NVARCHAR(20),
	@Email NVARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT UserId FROM Users WHERE Username = @Username)
	BEGIN
		SELECT -1 -- Username exists.
	END
	ELSE IF EXISTS(SELECT UserId FROM Users WHERE Email = @Email)
	BEGIN
		SELECT -2 -- Email exists.
	END
	ELSE
	BEGIN
		INSERT INTO [Users] ([Username],[Password],[Email],[CreatedDate])
		VALUES              (@Username, @Password, @Email, GETDATE())

		SELECT SCOPE_IDENTITY() -- UserId			   
     END
END

GO


CREATE  PROCEDURE [dbo].[Validate_User]
	@Username NVARCHAR(20),
	@Password NVARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @UserId INT, @LastLoginDate DATETIME
	
	SELECT @UserId = UserId, @LastLoginDate = LastLoginDate 
	FROM Users WHERE Username = @Username AND [Password] = @Password
	
	IF @UserId IS NOT NULL
	BEGIN
		IF EXISTS(SELECT UserId FROM Administrators WHERE UserId = @UserId)
		BEGIN
			UPDATE Users
			SET LastLoginDate =  GETDATE()
			WHERE UserId = @UserId
			SELECT @UserId [UserId] -- User Valid
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

--------------------------------- other ---------------------------------

-- create the admin account
INSERT INTO Users
SELECT 'admin', '12345', 'admin@diabpro.com', GETDATE(), NULL
GO

INSERT INTO Administrators
SELECT UserID FROM Users WHERE Username = 'admin'
GO


--checks
SELECT * FROM Administrators
GO

SELECT * FROM Users WHERE UserId = (SELECT * FROM Administrators)
GO