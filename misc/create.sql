CREATE TABLE [dbo].[product]
(
	[product_id]	BIGINT NOT NULL IDENTITY(1, 1),
	[title]			NVARCHAR(255) NOT NULL,
	[description]	NVARCHAR(500) NOT NULL,
	[preview_src]	NVARCHAR(255) NOT NULL,

	PRIMARY KEY ([product_id])
)

CREATE TABLE [dbo].[product_image]
(
	[image_id]		BIGINT NOT NULL IDENTITY(1, 1),
	[product_id]	BIGINT NOT NULL,
	[source]		NVARCHAR(255) NOT NULL DEFAULT 'http://chopx.somee.com/placeholder.jpg',

	PRIMARY KEY ([product_id], [image_id]),
	FOREIGN KEY ([product_id]) REFERENCES [dbo].[product] ([product_id])
)

CREATE TABLE [dbo].[tags]
(
	[tag_id]		BIGINT NOT NULL IDENTITY(1, 1),
	[text]			NVARCHAR(100) NOT NULL,

	PRIMARY KEY ([tag_id])
)

CREATE TABLE [dbo].[product_tag]
(
	[product_id]	BIGINT NOT NULL,
	[tag_id]		BIGINT NOT NULL,

	PRIMARY KEY ([product_id], [tag_id]),
	FOREIGN KEY ([product_id]) REFERENCES [dbo].[product] ([product_id]),
	FOREIGN KEY ([tag_id]) REFERENCES [dbo].[tags] ([tag_id])
)

CREATE TABLE [dbo].[user]
(
	[user_id]		BIGINT NOT NULL IDENTITY(1, 1),
	[username]		NVARCHAR(65) NOT NULL,
	[password]		NVARCHAR(40) NOT NULL,
	[email]			NVARCHAR(65),
	[phone]			NVARCHAR(20) NOT NULL,
	[name]			NVARCHAR(65) NOT NULL,

	PRIMARY KEY ([user_id]),
)

CREATE TABLE [dbo].[comment]
(
	[comment_id]	BIGINT NOT NULL IDENTITY(1, 1),
	[user_id]		BIGINT NOT NULL,
	[product_id]	BIGINT NOT NULL,
	[mark]			TINYINT NOT NULL,
	[text]			NVARCHAR(500) NOT NULL,

	PRIMARY KEY ([comment_id], [user_id], [product_id]),
	FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id]),
	FOREIGN KEY ([product_id]) REFERENCES [dbo].[product] ([product_id])
)

CREATE TABLE [dbo].[company]
(
	[company_id]	BIGINT NOT NULL IDENTITY(1, 1),
	[user_id]		BIGINT NOT NULL,
	[name]			NVARCHAR(100) NOT NULL,
	[logo]			NVARCHAR(255) NOT NULL DEFAULT 'http://chopx.somee.com/placeholder.jpg',

	PRIMARY KEY ([user_id], [company_id]),
	FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id])
)

CREATE TABLE [dbo].[payment_method]
(
	[method_id]		BIGINT NOT NULL IDENTITY(1, 1),
	[title]			NVARCHAR(100) NOT NULL,

	PRIMARY KEY ([method_id])
)

CREATE TABLE [dbo].[payment]
(
	[user_id]		BIGINT NOT NULL,
	[method_id]		BIGINT NOT NULL,
	[name]			NVARCHAR(100) NOT NULL,
	[card_id]		NVARCHAR(30) NOT NULL,
	[date]			DATE NOT NULL,
	[cvc]			NVARCHAR(3) NOT NULL

	PRIMARY KEY ([user_id], [method_id]),
	FOREIGN KEY ([method_id]) REFERENCES [dbo].[payment_method] ([method_id]),
	FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id])
)

CREATE TABLE [dbo].[administration]
(
	[user_id]		BIGINT NOT NULL,
	[com_mod]		BIT NOT NULL DEFAULT 0,
	[img_mod]		BIT NOT NULL DEFAULT 0,
	[usr_mod]		BIT NOT NULL DEFAULT 0,
	[prd_mod]		BIT NOT NULL DEFAULT 0,
	[tag_mod]		BIT NOT NULL DEFAULT 0,
	[pay_mod]		BIT NOT NULL DEFAULT 0,
	[prc_mod]		BIT NOT NULL DEFAULT 0,
	[str_mod]		BIT NOT NULL DEFAULT 0,
	[prs_mod]		BIT NOT NULL DEFAULT 0,
	[trg_mod]		BIT NOT NULL DEFAULT 0,
	[comp_access]	BIT NOT NULL DEFAULT 1,		

	PRIMARY KEY ([user_id]),
	FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id])
)

CREATE TABLE [dbo].[product_prices]
(
	[product_id]	BIGINT NOT NULL,
	[set_datetime]	DATETIME NOT NULL DEFAULT GETDATE(),

	PRIMARY KEY ([product_id], [set_datetime]),
	FOREIGN KEY ([product_id]) REFERENCES [dbo].[product]
)

CREATE TABLE [dbo].[storage]
(
	[storage_id]	BIGINT,
	[address]		NVARCHAR(350) NOT NULL,

	PRIMARY KEY ([storage_id])
)

CREATE TABLE [dbo].[product_storage]
(
	[product_id]	BIGINT NOT NULL,
	[storage_id]	BIGINT NOT NULL,
	[count]			INT NOT NULL,

	PRIMARY KEY ([product_id], [storage_id]),
	FOREIGN KEY ([product_id]) REFERENCES [dbo].[product] ([product_id]),
	FOREIGN KEY ([storage_id]) REFERENCES [dbo].[storage] ([storage_id])
)

CREATE TABLE [dbo].[delivery_target]
(
	[target_id]		BIGINT NOT NULL IDENTITY (1, 1),
	[address]		NVARCHAR(350) NOT NULL,

	PRIMARY KEY ([target_id])
)

CREATE TABLE [dbo].[cart]
(
	[user_id]		BIGINT NOT NULL,
	[product_id]	BIGINT NOT NULL,
	[count]			INT NOT NULL,

	PRIMARY KEY ([user_id], [product_id]),
	FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id]),
	FOREIGN KEY ([product_id]) REFERENCES [dbo].[product] ([product_id])
)

CREATE TABLE [dbo].[order]
(
	[target_id]		BIGINT NOT NULL,
	[user_id]		BIGINT NOT NULL,
	[product_id]	BIGINT NOT NULL,
	[count]			INT NOT NULL,
	[order_dt]		DATETIME NOT NULL DEFAULT GETDATE(),
	[delivered]		BIT NOT NULL DEFAULT 0,
	[state]			NVARCHAR(200) NOT NULL,

	PRIMARY KEY ([user_id], [product_id]),
	FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id]),
	FOREIGN KEY ([product_id]) REFERENCES [dbo].[product] ([product_id]),
	FOREIGN KEY ([target_id]) REFERENCES [dbo].[delivery_target] ([target_id]),
)