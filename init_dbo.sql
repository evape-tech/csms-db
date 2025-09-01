-- ...existing code...
IF DB_ID(N'benson_csms_db') IS NULL
BEGIN
    CREATE DATABASE [benson_csms_db];
END
GO

USE [benson_csms_db];
GO
/****** Object:  Table [dbo].[cartitems]    Script Date: 2025/8/23 下午 09:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cartitems](
	[id] [int] IDENTITY(2,1) NOT NULL,
	[CartId] [int] NULL,
	[ProductId] [int] NULL,
	[quantity] [int] NULL,
	[createdAt] [datetime2](0) NOT NULL,
	[updatedAt] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_cartitems_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[carts]    Script Date: 2025/8/23 下午 09:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[carts](
	[id] [int] IDENTITY(2,1) NOT NULL,
	[UserId] [int] NULL,
	[createdAt] [datetime2](0) NOT NULL,
	[updatedAt] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_carts_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cp_gun_datas]    Script Date: 2025/8/23 下午 09:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cp_gun_datas](
	[id] [bigint] IDENTITY(3,1) NOT NULL,
	[gunid] [nvarchar](45) NOT NULL,
	[cpsn] [nvarchar](45) NOT NULL,
	[connector_num] [nvarchar](45) NOT NULL,
	[connector] [nvarchar](45) NOT NULL,
	[last_heartbeat] [nvarchar](45) NULL,
	[online] [nvarchar](45) NULL,
	[brand] [nvarchar](45) NULL,
	[loc] [nvarchar](max) NULL,
	[station_name] [nvarchar](45) NULL,
	[local_cp_num] [nvarchar](45) NULL,
	[current_status] [nvarchar](45) NULL,
	[charging_current_a] [nvarchar](45) NULL,
	[charging_voltage] [nvarchar](45) NULL,
	[charging_start_time] [datetime2](0) NULL,
	[charging_end_time] [datetime2](0) NULL,
 CONSTRAINT [PK_cp_gun_datas_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cp_logs]    Script Date: 2025/8/23 下午 09:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cp_logs](
	[id] [bigint] IDENTITY(837,1) NOT NULL,
	[cpid] [nvarchar](45) NULL,
	[cpsn] [nvarchar](45) NULL,
	[log] [nvarchar](max) NULL,
	[inout] [nvarchar](45) NULL,
	[time] [datetime2](0) NULL,
	[createdAt] [datetime2](0) NULL,
	[updatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_cp_logs_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[guns]    Script Date: 2025/8/23 下午 09:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[guns](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[connector] [nvarchar](45) NULL,
	[cpid] [nvarchar](45) NULL,
	[cpsn] [nvarchar](45) NULL,
	[guns_status] [nvarchar](45) NULL,
	[createdAt] [date] NULL,
	[updatedAt] [date] NULL,
	[guns_metervalue1] [nvarchar](45) NULL,
	[guns_metervalue2] [nvarchar](45) NULL,
	[guns_metervalue3] [nvarchar](45) NULL,
	[guns_metervalue4] [nvarchar](45) NULL,
	[guns_metervalue5] [nvarchar](45) NULL,
	[guns_metervalue6] [nvarchar](45) NULL,
	[guns_memo1] [nvarchar](45) NULL,
	[guns_memo2] [nvarchar](45) NULL,
	[transactionid] [nvarchar](45) NULL,
	[acdc] [nvarchar](2) NULL,
	[max_kw] [int] NULL,
 CONSTRAINT [PK_guns_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderitems]    Script Date: 2025/8/23 下午 09:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderitems](
	[id] [int] IDENTITY(2,1) NOT NULL,
	[OrderId] [int] NULL,
	[ProductId] [int] NULL,
	[price] [int] NULL,
	[quantity] [int] NULL,
	[createdAt] [datetime2](0) NOT NULL,
	[updatedAt] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_orderitems_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 2025/8/23 下午 09:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [int] IDENTITY(2,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[phone] [nvarchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[amount] [int] NULL,
	[sn] [nvarchar](255) NULL,
	[shipping_status] [nvarchar](255) NULL,
	[payment_status] [nvarchar](255) NULL,
	[UserId] [int] NULL,
	[createdAt] [datetime2](0) NOT NULL,
	[updatedAt] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_orders_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payments]    Script Date: 2025/8/23 下午 09:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[payment_method] [nvarchar](255) NULL,
	[isSuccess] [smallint] NULL,
	[failure_message] [nvarchar](max) NULL,
	[payTime] [datetime2](0) NULL,
	[OrderId] [int] NULL,
	[createdAt] [datetime2](0) NOT NULL,
	[updatedAt] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_payments_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 2025/8/23 下午 09:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [int] IDENTITY(40,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[price] [int] NULL,
	[image] [nvarchar](255) NULL,
	[createdAt] [datetime2](0) NOT NULL,
	[updatedAt] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_products_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sequelizemeta]    Script Date: 2025/8/23 下午 09:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sequelizemeta](
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_sequelizemeta_name] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [sequelizemeta$name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[site_settings]    Script Date: 2025/8/23 下午 09:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[site_settings](
	[id] [int] IDENTITY(3,1) NOT NULL,
	[ems_mode] [nvarchar](32) NOT NULL,
	[max_power_kw] [decimal](10, 2) NOT NULL,
	[updated_at] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_site_settings_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM dbo.site_settings)
BEGIN
    INSERT INTO dbo.site_settings (ems_mode, max_power_kw, updated_at)
    VALUES (N'static', 480.00, GETDATE());
END
GO
/****** Object:  Table [dbo].[users]    Script Date: 2025/8/23 下午 09:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(7,1) NOT NULL,
	[email] [nvarchar](255) NULL,
	[password] [nvarchar](255) NULL,
	[role] [nvarchar](255) NULL,
	[createdAt] [datetime2](0) NOT NULL,
	[updatedAt] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_users_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM dbo.users WHERE email = N'evape@gmail.com')
BEGIN
    INSERT INTO dbo.users ([email],[password],[role],[createdAt],[updatedAt])
    VALUES (N'evape@gmail.com', N'123456', N'admin', GETDATE(), GETDATE());
END
GO
ALTER TABLE [dbo].[cartitems] ADD  DEFAULT (NULL) FOR [CartId]
GO
ALTER TABLE [dbo].[cartitems] ADD  DEFAULT (NULL) FOR [ProductId]
GO
ALTER TABLE [dbo].[cartitems] ADD  DEFAULT (NULL) FOR [quantity]
GO
ALTER TABLE [dbo].[carts] ADD  DEFAULT (NULL) FOR [UserId]
GO
ALTER TABLE [dbo].[cp_gun_datas] ADD  DEFAULT (NULL) FOR [last_heartbeat]
GO
ALTER TABLE [dbo].[cp_gun_datas] ADD  DEFAULT (NULL) FOR [online]
GO
ALTER TABLE [dbo].[cp_gun_datas] ADD  DEFAULT (NULL) FOR [brand]
GO
ALTER TABLE [dbo].[cp_gun_datas] ADD  DEFAULT (NULL) FOR [station_name]
GO
ALTER TABLE [dbo].[cp_gun_datas] ADD  DEFAULT (NULL) FOR [local_cp_num]
GO
ALTER TABLE [dbo].[cp_gun_datas] ADD  DEFAULT (NULL) FOR [current_status]
GO
ALTER TABLE [dbo].[cp_gun_datas] ADD  DEFAULT (NULL) FOR [charging_current_a]
GO
ALTER TABLE [dbo].[cp_gun_datas] ADD  DEFAULT (NULL) FOR [charging_voltage]
GO
ALTER TABLE [dbo].[cp_gun_datas] ADD  DEFAULT (NULL) FOR [charging_start_time]
GO
ALTER TABLE [dbo].[cp_gun_datas] ADD  DEFAULT (NULL) FOR [charging_end_time]
GO
ALTER TABLE [dbo].[cp_logs] ADD  DEFAULT (NULL) FOR [cpid]
GO
ALTER TABLE [dbo].[cp_logs] ADD  DEFAULT (NULL) FOR [cpsn]
GO
ALTER TABLE [dbo].[cp_logs] ADD  DEFAULT (NULL) FOR [inout]
GO
ALTER TABLE [dbo].[cp_logs] ADD  DEFAULT (NULL) FOR [time]
GO
ALTER TABLE [dbo].[cp_logs] ADD  DEFAULT (NULL) FOR [createdAt]
GO
ALTER TABLE [dbo].[cp_logs] ADD  DEFAULT (NULL) FOR [updatedAt]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [connector]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [cpid]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [cpsn]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [guns_status]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [createdAt]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [updatedAt]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [guns_metervalue1]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [guns_metervalue2]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [guns_metervalue3]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [guns_metervalue4]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [guns_metervalue5]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [guns_metervalue6]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [guns_memo1]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [guns_memo2]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (NULL) FOR [transactionid]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT (N'AC') FOR [acdc]
GO
ALTER TABLE [dbo].[guns] ADD  DEFAULT ((0)) FOR [max_kw]
GO
ALTER TABLE [dbo].[orderitems] ADD  DEFAULT (NULL) FOR [OrderId]
GO
ALTER TABLE [dbo].[orderitems] ADD  DEFAULT (NULL) FOR [ProductId]
GO
ALTER TABLE [dbo].[orderitems] ADD  DEFAULT (NULL) FOR [price]
GO
ALTER TABLE [dbo].[orderitems] ADD  DEFAULT (NULL) FOR [quantity]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (NULL) FOR [phone]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (NULL) FOR [address]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (NULL) FOR [amount]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (NULL) FOR [sn]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (NULL) FOR [shipping_status]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (NULL) FOR [payment_status]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (NULL) FOR [UserId]
GO
ALTER TABLE [dbo].[payments] ADD  DEFAULT (NULL) FOR [payment_method]
GO
ALTER TABLE [dbo].[payments] ADD  DEFAULT (NULL) FOR [isSuccess]
GO
ALTER TABLE [dbo].[payments] ADD  DEFAULT (NULL) FOR [payTime]
GO
ALTER TABLE [dbo].[payments] ADD  DEFAULT (NULL) FOR [OrderId]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT (NULL) FOR [price]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT (NULL) FOR [image]
GO
ALTER TABLE [dbo].[site_settings] ADD  DEFAULT (N'static') FOR [ems_mode]
GO
ALTER TABLE [dbo].[site_settings] ADD  DEFAULT ((480.00)) FOR [max_power_kw]
GO
ALTER TABLE [dbo].[site_settings] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [email]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [password]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [role]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'benson_csms_db.cartitems' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'cartitems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'benson_csms_db.carts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'carts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'benson_csms_db.cp_gun_datas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'cp_gun_datas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'benson_csms_db.cp_logs' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'cp_logs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'benson_csms_db.guns' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'guns'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'benson_csms_db.orderitems' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'orderitems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'benson_csms_db.orders' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'orders'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'benson_csms_db.payments' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'payments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'benson_csms_db.products' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'products'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'benson_csms_db.sequelizemeta' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sequelizemeta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'benson_csms_db.site_settings' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'site_settings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'benson_csms_db.users' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users'
GO

