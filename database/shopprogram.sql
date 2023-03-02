ALTER PROCEDURE [dbo].[register] 
(
	@username VARCHAR(65),
	@password VARCHAR(65)
) 
AS BEGIN
	IF ((SELECT COUNT(*) FROM [dbo].[user] AS U WHERE U.username = @username) <> 0)
	BEGIN
		SELECT -1;
		RETURN;
	END;
	INSERT INTO [dbo].[user] ([username], [password]) VALUES (@username, HASHBYTES('SHA2_256', @password));
	SELECT 0
END; GO;

CREATE PROCEDURE [dbo].[login]
(
	@username VARCHAR(65),
	@password VARCHAR(65)
)
AS BEGIN
	IF ((SELECT COUNT(U.id) FROM [dbo].[user] U WHERE U.[password] = HASHBYTES('SHA2_256', @password) AND U.[username] = @username) <> 1)
	BEGIN
		SELECT -1;
		RETURN;
	END;
	SELECT 0;
END; GO;