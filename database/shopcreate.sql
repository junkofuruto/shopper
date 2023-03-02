CREATE TABLE [dbo].[user]
(
	[id]			BIGINT NOT NULL IDENTITY(1, 1),
	[username]		VARCHAR(65) NOT NULL,
	[password]		VARCHAR(65) NOT NULL,

	PRIMARY KEY([id])
)