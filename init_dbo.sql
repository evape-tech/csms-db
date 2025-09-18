IF DB_ID(N'benson_csms_db') IS NULL
BEGIN
    CREATE DATABASE [benson_csms_db];
END
GO

USE [benson_csms_db];
GO


-- Table: tariffs
IF OBJECT_ID(N'dbo.tariffs', N'U') IS NOT NULL
    DROP TABLE dbo.tariffs;
GO

CREATE TABLE dbo.tariffs (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX) NULL,
    tariff_type NVARCHAR(20) NOT NULL DEFAULT N'FIXED_RATE' 
        CHECK (tariff_type IN (N'FIXED_RATE', N'TIME_OF_USE', N'PROGRESSIVE', N'SPECIAL_PROMOTION', N'MEMBERSHIP', N'CUSTOM')),
    base_price DECIMAL(10,2) NOT NULL,
    service_fee DECIMAL(10,2) NULL,
    minimum_fee DECIMAL(10,2) NULL,
    peak_hours_start NVARCHAR(5) NULL,
    peak_hours_end NVARCHAR(5) NULL,
    peak_hours_price DECIMAL(10,2) NULL,
    off_peak_price DECIMAL(10,2) NULL,
    weekend_price DECIMAL(10,2) NULL,
    tier1_max_kwh DECIMAL(10,2) NULL,
    tier1_price DECIMAL(10,2) NULL,
    tier2_max_kwh DECIMAL(10,2) NULL,
    tier2_price DECIMAL(10,2) NULL,
    tier3_price DECIMAL(10,2) NULL,
    discount_percentage DECIMAL(5,2) NULL,
    promotion_code NVARCHAR(50) NULL,
    valid_from DATETIME2(0) NULL,
    valid_to DATETIME2(0) NULL,
    ac_only BIT NOT NULL DEFAULT 0,
    dc_only BIT NOT NULL DEFAULT 0,
    membership_required BIT NOT NULL DEFAULT 0,
    is_active BIT NOT NULL DEFAULT 1,
    is_default BIT NOT NULL DEFAULT 0,
    created_by NVARCHAR(100) NULL,
    createdAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    updatedAt DATETIME2(0) NOT NULL DEFAULT GETDATE()
);
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','方案名稱', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','name';
EXEC sp_addextendedproperty 'MS_Description','方案描述', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','description';
EXEC sp_addextendedproperty 'MS_Description','方案類型', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','tariff_type';
EXEC sp_addextendedproperty 'MS_Description','基本費用', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','base_price';
EXEC sp_addextendedproperty 'MS_Description','服務費', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','service_fee';
EXEC sp_addextendedproperty 'MS_Description','最低收費', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','minimum_fee';
EXEC sp_addextendedproperty 'MS_Description','尖峰開始時間(HH:MM)', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','peak_hours_start';
EXEC sp_addextendedproperty 'MS_Description','尖峰結束時間(HH:MM)', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','peak_hours_end';
EXEC sp_addextendedproperty 'MS_Description','尖峰價格', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','peak_hours_price';
EXEC sp_addextendedproperty 'MS_Description','離峰價格', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','off_peak_price';
EXEC sp_addextendedproperty 'MS_Description','週末價格', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','weekend_price';
EXEC sp_addextendedproperty 'MS_Description','分層1最大電量', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','tier1_max_kwh';
EXEC sp_addextendedproperty 'MS_Description','分層1價格', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','tier1_price';
EXEC sp_addextendedproperty 'MS_Description','分層2最大電量', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','tier2_max_kwh';
EXEC sp_addextendedproperty 'MS_Description','分層2價格', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','tier2_price';
EXEC sp_addextendedproperty 'MS_Description','分層3價格', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','tier3_price';
EXEC sp_addextendedproperty 'MS_Description','折扣百分比', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','discount_percentage';
EXEC sp_addextendedproperty 'MS_Description','促銷碼', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','promotion_code';
EXEC sp_addextendedproperty 'MS_Description','有效開始時間', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','valid_from';
EXEC sp_addextendedproperty 'MS_Description','有效結束時間', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','valid_to';
EXEC sp_addextendedproperty 'MS_Description','僅限AC', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','ac_only';
EXEC sp_addextendedproperty 'MS_Description','僅限DC', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','dc_only';
EXEC sp_addextendedproperty 'MS_Description','需會員', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','membership_required';
EXEC sp_addextendedproperty 'MS_Description','是否啟用', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','is_active';
EXEC sp_addextendedproperty 'MS_Description','是否預設', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','is_default';
EXEC sp_addextendedproperty 'MS_Description','建立者', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','created_by';
EXEC sp_addextendedproperty 'MS_Description','創建時間', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','createdAt';
EXEC sp_addextendedproperty 'MS_Description','更新時間', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','updatedAt';
GO

INSERT INTO dbo.tariffs
(name, description, tariff_type, base_price, service_fee, minimum_fee,
 peak_hours_start, peak_hours_end, peak_hours_price, off_peak_price, weekend_price,
 tier1_max_kwh, tier1_price, tier2_max_kwh, tier2_price, tier3_price,
 discount_percentage, promotion_code, valid_from, valid_to,
 ac_only, dc_only, membership_required, is_active, is_default, created_by, createdAt, updatedAt)
VALUES
(N'標準費率', N'適用于所有充電站的基本固定單價費率', N'FIXED_RATE', 2.50, 0.50, 5.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 0, 0, 0, 1, 1, N'system', GETDATE(), GETDATE()),

(N'峰谷電價', N'根據時段不同收取不同費用的分時費率', N'TIME_OF_USE', 2.80, 0.50, 5.00,
 N'09:00', N'22:00', 3.50, 1.80, 2.20,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 0, 0, 0, 1, 0, N'system', GETDATE(), GETDATE()),

(N'累進電價', N'用電量越多單價越高的階梯式費率', N'PROGRESSIVE', 2.50, 0.50, 5.00,
 NULL, NULL, NULL, NULL, NULL,
 10.00, 2.20, 30.00, 2.80, 3.50,
 NULL, NULL, NULL, NULL,
 0, 0, 0, 1, 0, N'system', GETDATE(), GETDATE()),

(N'會員專享', N'會員專享優惠費率', N'MEMBERSHIP', 2.50, 0.00, 0.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 20.00, NULL, NULL, NULL,
 0, 0, 1, 1, 0, N'system', GETDATE(), GETDATE()),

(N'DC快充費率', N'適用於直流快充的專用費率', N'FIXED_RATE', 3.20, 1.00, 10.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 0, 1, 0, 1, 0, N'system', GETDATE(), GETDATE()),

(N'AC慢充費率', N'適用於交流慢充的專用費率', N'FIXED_RATE', 2.30, 0.50, 5.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 1, 0, 0, 1, 0, N'system', GETDATE(), GETDATE()),

(N'新用戶首充優惠', N'新用戶首次充電特惠價格', N'SPECIAL_PROMOTION', 2.00, 0.00, 0.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 50.00, N'FIRST_CHARGE', CAST('2025-07-01' AS DATETIME2), CAST('2025-07-01' AS DATETIME2),
 0, 0, 0, 1, 0, N'system', GETDATE(), GETDATE());
GO

CREATE INDEX IX_tariffs_name ON dbo.tariffs(name);
CREATE INDEX IX_tariffs_tariff_type ON dbo.tariffs(tariff_type);
CREATE INDEX IX_tariffs_is_active ON dbo.tariffs(is_active);
CREATE INDEX IX_tariffs_is_default ON dbo.tariffs(is_default);
GO

/****** Table: stations ******/
IF OBJECT_ID(N'dbo.stations', N'U') IS NOT NULL
    DROP TABLE dbo.stations;
GO

CREATE TABLE dbo.stations (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,        -- 內部主鍵ID
    station_code NVARCHAR(50) NOT NULL,              -- 自定義場域編號
    name NVARCHAR(100) NULL,                         -- 場域名稱
    address NVARCHAR(255) NULL,                      -- 地址
    floor NVARCHAR(50) NULL,                          -- 樓層
    operator_id NVARCHAR(50) NULL,                   -- 營運商/業主ID
    tariff_id INT NULL,                               -- 預設費率ID (tariffs.id)
    updated_at DATETIME2(0) NOT NULL DEFAULT GETDATE(), -- 更新時間
    CONSTRAINT UQ_stations_station_code UNIQUE (station_code),
    CONSTRAINT FK_stations_tariff FOREIGN KEY (tariff_id) REFERENCES dbo.tariffs(id) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);
GO

EXEC sp_addextendedproperty 'MS_Description','內部主鍵ID', 'SCHEMA','dbo','TABLE','stations','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','自定義場域編號', 'SCHEMA','dbo','TABLE','stations','COLUMN','station_code';
EXEC sp_addextendedproperty 'MS_Description','場域名稱', 'SCHEMA','dbo','TABLE','stations','COLUMN','name';
EXEC sp_addextendedproperty 'MS_Description','地址', 'SCHEMA','dbo','TABLE','stations','COLUMN','address';
EXEC sp_addextendedproperty 'MS_Description','樓層', 'SCHEMA','dbo','TABLE','stations','COLUMN','floor';
EXEC sp_addextendedproperty 'MS_Description','營運商/業主ID', 'SCHEMA','dbo','TABLE','stations','COLUMN','operator_id';
EXEC sp_addextendedproperty 'MS_Description','更新時間', 'SCHEMA','dbo','TABLE','stations','COLUMN','updated_at';
GO

-- 初始化預設場站
IF NOT EXISTS (SELECT 1 FROM dbo.stations WHERE station_code = N'STN001')
BEGIN
    INSERT INTO dbo.stations (station_code, name, address, floor, operator_id, updated_at)
    VALUES (N'STN001', N'XX大樓', N'台北市松山區松江路220號', N'4F', N'OP01', GETDATE());
END
GO


/****** Table: meters ******/
IF OBJECT_ID(N'dbo.meters', N'U') IS NOT NULL
    DROP TABLE dbo.meters;
GO

CREATE TABLE dbo.meters (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,        -- 主鍵ID
    station_id INT NOT NULL,                          -- 關聯場域ID (stations.id)
    meter_no NVARCHAR(50) NOT NULL,                  -- 電表編號
    ems_mode NVARCHAR(32) NOT NULL DEFAULT N'static',-- EMS模式
    max_power_kw DECIMAL(10,2) NOT NULL DEFAULT 480.00, -- 最大功率(kW)
    billing_mode NVARCHAR(32) NULL,                  -- 計費模式 (independent/shared/split)
    owner_id NVARCHAR(50) NULL,                      -- 電表所有人(如租戶ID)
    updated_at DATETIME2(0) NOT NULL DEFAULT GETDATE(), -- 更新時間
    CONSTRAINT UQ_station_meter UNIQUE (station_id, meter_no), -- 場站+電表唯一
    CONSTRAINT FK_meters_station FOREIGN KEY (station_id) REFERENCES dbo.stations(id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','meters','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','關聯場域ID (stations.id)', 'SCHEMA','dbo','TABLE','meters','COLUMN','station_id';
EXEC sp_addextendedproperty 'MS_Description','電表編號', 'SCHEMA','dbo','TABLE','meters','COLUMN','meter_no';
EXEC sp_addextendedproperty 'MS_Description','EMS模式', 'SCHEMA','dbo','TABLE','meters','COLUMN','ems_mode';
EXEC sp_addextendedproperty 'MS_Description','最大功率(kW)', 'SCHEMA','dbo','TABLE','meters','COLUMN','max_power_kw';
EXEC sp_addextendedproperty 'MS_Description','計費模式 (independent/shared/split)', 'SCHEMA','dbo','TABLE','meters','COLUMN','billing_mode';
EXEC sp_addextendedproperty 'MS_Description','電表所有人(如租戶ID)', 'SCHEMA','dbo','TABLE','meters','COLUMN','owner_id';
EXEC sp_addextendedproperty 'MS_Description','更新時間', 'SCHEMA','dbo','TABLE','meters','COLUMN','updated_at';
GO

CREATE INDEX IX_meters_station_id ON dbo.meters(station_id);
CREATE INDEX IX_meters_meter_no ON dbo.meters(meter_no);
CREATE INDEX IX_meters_billing_mode ON dbo.meters(billing_mode);
CREATE INDEX IX_meters_owner_id ON dbo.meters(owner_id);
GO

-- 插入初始電表資料
IF NOT EXISTS (SELECT 1 FROM dbo.meters WHERE meter_no = N'MTR001')
BEGIN
    INSERT INTO dbo.meters (station_id, meter_no, ems_mode, max_power_kw, billing_mode, owner_id, updated_at)
    VALUES (1, N'MTR001', N'static', 480.00, N'independent', NULL, GETDATE());
END
GO


/****** Table: guns ******/
IF OBJECT_ID(N'dbo.guns', N'U') IS NOT NULL
    DROP TABLE dbo.guns;
GO

CREATE TABLE dbo.guns (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    connector NVARCHAR(45) NULL,
    cpid NVARCHAR(255) NULL,
    cpsn NVARCHAR(255) NULL,
    guns_status NVARCHAR(45) NULL,
    createdAt DATE NULL,
    updatedAt DATE NULL,
    guns_metervalue1 NVARCHAR(255) NULL,
    guns_metervalue2 NVARCHAR(255) NULL,
    guns_metervalue3 NVARCHAR(255) NULL,
    guns_metervalue4 NVARCHAR(255) NULL,
    guns_metervalue5 NVARCHAR(255) NULL,
    guns_metervalue6 NVARCHAR(255) NULL,
    guns_memo1 NVARCHAR(255) NULL,
    guns_memo2 NVARCHAR(255) NULL,
    transactionid NVARCHAR(255) NULL,
    acdc NVARCHAR(2) NULL DEFAULT N'AC',
    max_kw INT NULL DEFAULT 0,

    -- 新增欄位：meter_id，對應 meters.id
    meter_id INT NULL,
    CONSTRAINT FK_guns_meter FOREIGN KEY (meter_id) REFERENCES dbo.meters(id)
);
GO

-- 加入欄位說明
EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','guns','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','充電槍編號', 'SCHEMA','dbo','TABLE','guns','COLUMN','connector';
EXEC sp_addextendedproperty 'MS_Description','充電樁ID', 'SCHEMA','dbo','TABLE','guns','COLUMN','cpid';
EXEC sp_addextendedproperty 'MS_Description','充電樁序號', 'SCHEMA','dbo','TABLE','guns','COLUMN','cpsn';
EXEC sp_addextendedproperty 'MS_Description','充電槍狀態', 'SCHEMA','dbo','TABLE','guns','COLUMN','guns_status';
EXEC sp_addextendedproperty 'MS_Description','建立日期', 'SCHEMA','dbo','TABLE','guns','COLUMN','createdAt';
EXEC sp_addextendedproperty 'MS_Description','更新日期', 'SCHEMA','dbo','TABLE','guns','COLUMN','updatedAt';
EXEC sp_addextendedproperty 'MS_Description','電表數值1', 'SCHEMA','dbo','TABLE','guns','COLUMN','guns_metervalue1';
EXEC sp_addextendedproperty 'MS_Description','電表數值2', 'SCHEMA','dbo','TABLE','guns','COLUMN','guns_metervalue2';
EXEC sp_addextendedproperty 'MS_Description','電表數值3', 'SCHEMA','dbo','TABLE','guns','COLUMN','guns_metervalue3';
EXEC sp_addextendedproperty 'MS_Description','電表數值4', 'SCHEMA','dbo','TABLE','guns','COLUMN','guns_metervalue4';
EXEC sp_addextendedproperty 'MS_Description','電表數值5', 'SCHEMA','dbo','TABLE','guns','COLUMN','guns_metervalue5';
EXEC sp_addextendedproperty 'MS_Description','電表數值6', 'SCHEMA','dbo','TABLE','guns','COLUMN','guns_metervalue6';
EXEC sp_addextendedproperty 'MS_Description','備註1', 'SCHEMA','dbo','TABLE','guns','COLUMN','guns_memo1';
EXEC sp_addextendedproperty 'MS_Description','備註2', 'SCHEMA','dbo','TABLE','guns','COLUMN','guns_memo2';
EXEC sp_addextendedproperty 'MS_Description','交易ID', 'SCHEMA','dbo','TABLE','guns','COLUMN','transactionid';
EXEC sp_addextendedproperty 'MS_Description','AC/DC類型', 'SCHEMA','dbo','TABLE','guns','COLUMN','acdc';
EXEC sp_addextendedproperty 'MS_Description','最大功率(kW)', 'SCHEMA','dbo','TABLE','guns','COLUMN','max_kw';
EXEC sp_addextendedproperty 'MS_Description','對應電表ID', 'SCHEMA','dbo','TABLE','guns','COLUMN','meter_id';
GO

-- 建立索引
CREATE INDEX IX_stations_operator_id ON dbo.stations(operator_id);
CREATE INDEX IX_stations_name ON dbo.stations(name);
GO


/****** Table: users ******/
IF OBJECT_ID(N'dbo.users', N'U') IS NOT NULL
    DROP TABLE dbo.users;
GO

CREATE TABLE dbo.users (
    id INT IDENTITY(7,1) NOT NULL PRIMARY KEY,
    uuid NVARCHAR(36) NULL,
    email NVARCHAR(255) NULL,
    password NVARCHAR(255) NULL,
    role NVARCHAR(255) NULL,
    createdAt DATETIME2(0) NOT NULL,
    updatedAt DATETIME2(0) NOT NULL
);
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','users','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','用戶UUID', 'SCHEMA','dbo','TABLE','users','COLUMN','uuid';
EXEC sp_addextendedproperty 'MS_Description','用戶Email', 'SCHEMA','dbo','TABLE','users','COLUMN','email';
EXEC sp_addextendedproperty 'MS_Description','密碼', 'SCHEMA','dbo','TABLE','users','COLUMN','password';
EXEC sp_addextendedproperty 'MS_Description','角色', 'SCHEMA','dbo','TABLE','users','COLUMN','role';
EXEC sp_addextendedproperty 'MS_Description','創建時間', 'SCHEMA','dbo','TABLE','users','COLUMN','createdAt';
EXEC sp_addextendedproperty 'MS_Description','更新時間', 'SCHEMA','dbo','TABLE','users','COLUMN','updatedAt';
GO

-- 創建觸發器生成 UUID
CREATE TRIGGER TR_users_generate_uuid
ON dbo.users
AFTER INSERT
AS
BEGIN
    UPDATE dbo.users
    SET uuid = NEWID()
    WHERE id IN (SELECT id FROM inserted WHERE uuid IS NULL);
END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.users WHERE email = N'evape@gmail.com')
BEGIN
    INSERT INTO dbo.users (email, password, role, createdAt, updatedAt)
    VALUES (N'evape@gmail.com', N'123456', N'admin', GETDATE(), GETDATE());
END
GO

/****** Table: charging_transactions ******/
IF OBJECT_ID(N'dbo.charging_transactions', N'U') IS NOT NULL
    DROP TABLE dbo.charging_transactions;
GO

CREATE TABLE dbo.charging_transactions (
 id BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    transaction_id NVARCHAR(50) NOT NULL UNIQUE,
    start_time DATETIME2(0) NOT NULL,
    end_time DATETIME2(0) NULL,

    -- 充電樁資訊
    cpid NVARCHAR(255) NOT NULL,
    cpsn NVARCHAR(255) NOT NULL,
    connector_id INT NOT NULL,

    -- 用戶識別
    user_id NVARCHAR(36) NULL,
    id_tag NVARCHAR(20) NOT NULL,

    -- 電表數據
    meter_start DECIMAL(10,3) NULL,
    meter_stop DECIMAL(10,3) NULL,
    energy_consumed DECIMAL(10,3) NULL,

    -- 即時充電數據（由 MeterValues 更新）
    current_power DECIMAL(8,3) NULL,   -- 當前功率 (kW)
    current_voltage DECIMAL(8,2) NULL, -- 當前電壓 (V)
    current_current DECIMAL(8,2) NULL, -- 當前電流 (A)
    last_meter_update DATETIME2(0) NULL, -- 最後電表更新時間

    -- 充電時長（秒）
    charging_duration INT NULL,

    -- 狀態資訊
    status NVARCHAR(20) NOT NULL DEFAULT N'ACTIVE' 
        CHECK ([status] IN (N'ACTIVE', N'COMPLETED', N'STOPPED', N'ERROR', N'CANCELLED')),
    stop_reason NVARCHAR(100) NULL,

    -- 時間戳
    createdAt DATETIME2(0) NOT NULL,
    updatedAt DATETIME2(0) NOT NULL,
    CONSTRAINT FK_charging_transactions_user_uuid FOREIGN KEY (user_id) REFERENCES dbo.users(uuid)
);
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','交易編號', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','transaction_id';
EXEC sp_addextendedproperty 'MS_Description','交易開始時間', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','start_time';
EXEC sp_addextendedproperty 'MS_Description','交易結束時間', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','end_time';
EXEC sp_addextendedproperty 'MS_Description','充電樁ID', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','cpid';
EXEC sp_addextendedproperty 'MS_Description','充電樁序號', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','cpsn';
EXEC sp_addextendedproperty 'MS_Description','充電槍ID', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','connector_id';
EXEC sp_addextendedproperty 'MS_Description','用戶UUID', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','user_id';
EXEC sp_addextendedproperty 'MS_Description','身份識別ID Tag', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','id_tag';
EXEC sp_addextendedproperty 'MS_Description','電表起始數值', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','meter_start';
EXEC sp_addextendedproperty 'MS_Description','電表結束數值', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','meter_stop';
EXEC sp_addextendedproperty 'MS_Description','消耗電量', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','energy_consumed';
EXEC sp_addextendedproperty 'MS_Description','當前功率(kW)', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','current_power';
EXEC sp_addextendedproperty 'MS_Description','當前電壓(V)', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','current_voltage';
EXEC sp_addextendedproperty 'MS_Description','當前電流(A)', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','current_current';
EXEC sp_addextendedproperty 'MS_Description','最後電表更新時間', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','last_meter_update';
EXEC sp_addextendedproperty 'MS_Description','充電時長(秒)', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','charging_duration';
EXEC sp_addextendedproperty 'MS_Description','交易狀態', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','status';
EXEC sp_addextendedproperty 'MS_Description','交易停止原因', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','stop_reason';
EXEC sp_addextendedproperty 'MS_Description','創建時間', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','createdAt';
EXEC sp_addextendedproperty 'MS_Description','更新時間', 'SCHEMA','dbo','TABLE','charging_transactions','COLUMN','updatedAt';
GO

CREATE INDEX IX_charging_transactions_transaction_id ON dbo.charging_transactions(transaction_id);
CREATE INDEX IX_charging_transactions_cpid ON dbo.charging_transactions(cpid);
CREATE INDEX IX_charging_transactions_cpsn ON dbo.charging_transactions(cpsn);
CREATE INDEX IX_charging_transactions_id_tag ON dbo.charging_transactions(id_tag);
CREATE INDEX IX_charging_transactions_status ON dbo.charging_transactions(status);
CREATE INDEX IX_charging_transactions_start_time ON dbo.charging_transactions(start_time);
CREATE INDEX IX_charging_transactions_end_time ON dbo.charging_transactions(end_time);
GO

-- Table: billing_channels
IF OBJECT_ID(N'dbo.billing_channels', N'U') IS NOT NULL
    DROP TABLE dbo.billing_channels;
GO

CREATE TABLE dbo.billing_channels (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,          -- 支付方式名稱
    code NVARCHAR(30) NOT NULL UNIQUE,   -- 支付代碼
    status TINYINT NOT NULL DEFAULT 1,   -- 是否啟用 (0=停用,1=啟用)
    config NVARCHAR(MAX) NULL,           -- 渠道配置(JSON或其他格式)
    createdAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    updatedAt DATETIME2(0) NOT NULL DEFAULT GETDATE()
);
GO

-- 添加欄位描述
EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','billing_channels','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','支付方式名稱', 'SCHEMA','dbo','TABLE','billing_channels','COLUMN','name';
EXEC sp_addextendedproperty 'MS_Description','支付代碼', 'SCHEMA','dbo','TABLE','billing_channels','COLUMN','code';
EXEC sp_addextendedproperty 'MS_Description','是否啟用 (0=停用,1=啟用)', 'SCHEMA','dbo','TABLE','billing_channels','COLUMN','status';
EXEC sp_addextendedproperty 'MS_Description','渠道配置(JSON)', 'SCHEMA','dbo','TABLE','billing_channels','COLUMN','config';
EXEC sp_addextendedproperty 'MS_Description','建立時間', 'SCHEMA','dbo','TABLE','billing_channels','COLUMN','createdAt';
EXEC sp_addextendedproperty 'MS_Description','更新時間', 'SCHEMA','dbo','TABLE','billing_channels','COLUMN','updatedAt';
GO

-- Migration-safe 插入初始資料
MERGE dbo.billing_channels AS target
USING (VALUES
    (N'信用卡', N'credit_card', 1, NULL),
    (N'RFID', N'rfid', 1, NULL),
    (N'Line Pay', N'linepay', 1, NULL)
) AS source (name, code, status, config)
ON target.code = source.code
WHEN MATCHED THEN 
    UPDATE SET 
        target.name = source.name,
        target.status = source.status,
        target.config = source.config,
        target.updatedAt = GETDATE()
WHEN NOT MATCHED THEN
    INSERT (name, code, status, config, createdAt, updatedAt)
    VALUES (source.name, source.code, source.status, source.config, GETDATE(), GETDATE());
GO


-- Table: billing_records
IF OBJECT_ID(N'dbo.billing_records', N'U') IS NOT NULL
    DROP TABLE dbo.billing_records;
GO

CREATE TABLE dbo.billing_records (
    id BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    transaction_id NVARCHAR(50) NOT NULL,
    transaction_ref BIGINT NULL,
    tariff_id INT NOT NULL,
    applied_price DECIMAL(10,2) NOT NULL,
    energy_consumed DECIMAL(10,3) NOT NULL,
    energy_fee DECIMAL(10,2) NOT NULL,
    service_fee DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) NULL,
    tax_amount DECIMAL(10,2) NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    currency NVARCHAR(3) NOT NULL DEFAULT N'TWD',
    start_time DATETIME2(0) NOT NULL,
    end_time DATETIME2(0) NOT NULL,
    charging_duration INT NOT NULL,
    billing_details NVARCHAR(MAX) NULL,
    invoice_number NVARCHAR(20) NULL,
    invoice_issued_at DATETIME2(0) NULL,
    payment_method NVARCHAR(50) NULL,
    payment_reference NVARCHAR(100) NULL,
    payment_time DATETIME2(0) NULL,
    user_id NVARCHAR(36) NULL,
    id_tag NVARCHAR(20) NOT NULL,
    cpid NVARCHAR(255) NOT NULL,
    cpsn NVARCHAR(255) NOT NULL,
    connector_id INT NOT NULL,
    status NVARCHAR(20) NOT NULL DEFAULT N'CALCULATED' 
        CHECK (status IN (N'PENDING', N'CALCULATED', N'INVOICED', N'PAID', N'CANCELLED', N'ERROR')),
    remark NVARCHAR(MAX) NULL,
    createdAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    updatedAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_billing_records_tariff_id FOREIGN KEY (tariff_id) REFERENCES tariffs(id),
    CONSTRAINT FK_billing_records_transaction_ref FOREIGN KEY (transaction_ref) REFERENCES charging_transactions(id),
    CONSTRAINT FK_billing_records_payment_method FOREIGN KEY (payment_method) REFERENCES billing_channels(code),
    CONSTRAINT FK_billing_records_user_uuid FOREIGN KEY (user_id) REFERENCES dbo.users(uuid)
);
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','交易編號', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','transaction_id';
EXEC sp_addextendedproperty 'MS_Description','交易參照ID(charging_transactions.id)', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','transaction_ref';
EXEC sp_addextendedproperty 'MS_Description','費率ID(tariffs.id)', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','tariff_id';
EXEC sp_addextendedproperty 'MS_Description','套用價格', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','applied_price';
EXEC sp_addextendedproperty 'MS_Description','消耗電量(kWh)', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','energy_consumed';
EXEC sp_addextendedproperty 'MS_Description','電費', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','energy_fee';
EXEC sp_addextendedproperty 'MS_Description','服務費', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','service_fee';
EXEC sp_addextendedproperty 'MS_Description','折扣金額', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','discount_amount';
EXEC sp_addextendedproperty 'MS_Description','稅額', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','tax_amount';
EXEC sp_addextendedproperty 'MS_Description','總金額', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','total_amount';
EXEC sp_addextendedproperty 'MS_Description','幣別', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','currency';
EXEC sp_addextendedproperty 'MS_Description','充電開始時間', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','start_time';
EXEC sp_addextendedproperty 'MS_Description','充電結束時間', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','end_time';
EXEC sp_addextendedproperty 'MS_Description','充電時長(秒)', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','charging_duration';
EXEC sp_addextendedproperty 'MS_Description','帳單明細(JSON)', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','billing_details';
EXEC sp_addextendedproperty 'MS_Description','發票號碼', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','invoice_number';
EXEC sp_addextendedproperty 'MS_Description','發票開立時間', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','invoice_issued_at';
EXEC sp_addextendedproperty 'MS_Description','支付方式', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','payment_method';
EXEC sp_addextendedproperty 'MS_Description','支付參考編號', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','payment_reference';
EXEC sp_addextendedproperty 'MS_Description','支付時間', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','payment_time';
EXEC sp_addextendedproperty 'MS_Description','用戶UUID', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','user_id';
EXEC sp_addextendedproperty 'MS_Description','身份識別ID Tag', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','id_tag';
EXEC sp_addextendedproperty 'MS_Description','充電樁ID', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','cpid';
EXEC sp_addextendedproperty 'MS_Description','充電樁序號', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','cpsn';
EXEC sp_addextendedproperty 'MS_Description','充電槍ID', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','connector_id';
EXEC sp_addextendedproperty 'MS_Description','帳單狀態', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','status';
EXEC sp_addextendedproperty 'MS_Description','備註', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','remark';
EXEC sp_addextendedproperty 'MS_Description','創建時間', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','createdAt';
EXEC sp_addextendedproperty 'MS_Description','更新時間', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','updatedAt';
GO

CREATE INDEX IX_billing_records_transaction_id ON dbo.billing_records(transaction_id);
CREATE INDEX IX_billing_records_tariff_id ON dbo.billing_records(tariff_id);
CREATE INDEX IX_billing_records_user_id ON dbo.billing_records(user_id);
CREATE INDEX IX_billing_records_id_tag ON dbo.billing_records(id_tag);
CREATE INDEX IX_billing_records_cpid ON dbo.billing_records(cpid);
CREATE INDEX IX_billing_records_status ON dbo.billing_records(status);
CREATE INDEX IX_billing_records_start_time ON dbo.billing_records(start_time);
CREATE INDEX IX_billing_records_invoice_number ON dbo.billing_records(invoice_number);
GO


/****** Table: cp_logs ******/
IF OBJECT_ID(N'dbo.cp_logs', N'U') IS NOT NULL
    DROP TABLE dbo.cp_logs;
GO

CREATE TABLE dbo.cp_logs (
    id BIGINT IDENTITY(837,1) NOT NULL PRIMARY KEY,
    cpid NVARCHAR(255) NULL,
    cpsn NVARCHAR(255) NULL,
    log NVARCHAR(MAX) NULL,
    inout NVARCHAR(45) NULL,
    time DATETIME2(0) NULL,
    createdAt DATETIME2(0) NULL,
    updatedAt DATETIME2(0) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','cp_logs','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','充電樁ID', 'SCHEMA','dbo','TABLE','cp_logs','COLUMN','cpid';
EXEC sp_addextendedproperty 'MS_Description','充電樁序號', 'SCHEMA','dbo','TABLE','cp_logs','COLUMN','cpsn';
EXEC sp_addextendedproperty 'MS_Description','日誌內容', 'SCHEMA','dbo','TABLE','cp_logs','COLUMN','log';
EXEC sp_addextendedproperty 'MS_Description','進出狀態', 'SCHEMA','dbo','TABLE','cp_logs','COLUMN','inout';
EXEC sp_addextendedproperty 'MS_Description','記錄時間', 'SCHEMA','dbo','TABLE','cp_logs','COLUMN','time';
EXEC sp_addextendedproperty 'MS_Description','創建時間', 'SCHEMA','dbo','TABLE','cp_logs','COLUMN','createdAt';
EXEC sp_addextendedproperty 'MS_Description','更新時間', 'SCHEMA','dbo','TABLE','cp_logs','COLUMN','updatedAt';
GO

-- 創建 user_wallets 表
IF OBJECT_ID(N'dbo.user_wallets', N'U') IS NOT NULL
    DROP TABLE dbo.user_wallets;
GO

CREATE TABLE dbo.user_wallets (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id NVARCHAR(36) NOT NULL,
    balance DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    currency NVARCHAR(3) NOT NULL DEFAULT 'TWD',
    createdAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    updatedAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_user_wallets_user_uuid FOREIGN KEY (user_id) REFERENCES dbo.users(uuid)
);
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','user_wallets','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','用戶UUID', 'SCHEMA','dbo','TABLE','user_wallets','COLUMN','user_id';
EXEC sp_addextendedproperty 'MS_Description','餘額', 'SCHEMA','dbo','TABLE','user_wallets','COLUMN','balance';
EXEC sp_addextendedproperty 'MS_Description','貨幣', 'SCHEMA','dbo','TABLE','user_wallets','COLUMN','currency';
EXEC sp_addextendedproperty 'MS_Description','創建時間', 'SCHEMA','dbo','TABLE','user_wallets','COLUMN','createdAt';
EXEC sp_addextendedproperty 'MS_Description','更新時間', 'SCHEMA','dbo','TABLE','user_wallets','COLUMN','updatedAt';
GO

-- 創建 rfid_cards 表
IF OBJECT_ID(N'dbo.rfid_cards', N'U') IS NOT NULL
    DROP TABLE dbo.rfid_cards;
GO

CREATE TABLE dbo.rfid_cards (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id NVARCHAR(36) NOT NULL,
    card_number NVARCHAR(50) NOT NULL UNIQUE,
    card_type NVARCHAR(20) NOT NULL DEFAULT 'RFID',
    status NVARCHAR(20) NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'INACTIVE', 'LOST', 'BLOCKED')),
    issued_at DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    createdAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    updatedAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_rfid_cards_user_uuid FOREIGN KEY (user_id) REFERENCES dbo.users(uuid)
);
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','rfid_cards','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','用戶UUID', 'SCHEMA','dbo','TABLE','rfid_cards','COLUMN','user_id';
EXEC sp_addextendedproperty 'MS_Description','卡號', 'SCHEMA','dbo','TABLE','rfid_cards','COLUMN','card_number';
EXEC sp_addextendedproperty 'MS_Description','卡類型', 'SCHEMA','dbo','TABLE','rfid_cards','COLUMN','card_type';
EXEC sp_addextendedproperty 'MS_Description','狀態', 'SCHEMA','dbo','TABLE','rfid_cards','COLUMN','status';
EXEC sp_addextendedproperty 'MS_Description','發卡時間', 'SCHEMA','dbo','TABLE','rfid_cards','COLUMN','issued_at';
EXEC sp_addextendedproperty 'MS_Description','創建時間', 'SCHEMA','dbo','TABLE','rfid_cards','COLUMN','createdAt';
EXEC sp_addextendedproperty 'MS_Description','更新時間', 'SCHEMA','dbo','TABLE','rfid_cards','COLUMN','updatedAt';
GO

-- 創建 wallet_transactions 表
IF OBJECT_ID(N'dbo.wallet_transactions', N'U') IS NOT NULL
    DROP TABLE dbo.wallet_transactions;
GO

CREATE TABLE dbo.wallet_transactions (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_id NVARCHAR(36) NOT NULL,
    wallet_id INT NOT NULL,
    transaction_type NVARCHAR(20) NOT NULL CHECK (transaction_type IN ('DEPOSIT', 'WITHDRAWAL', 'PAYMENT', 'REFUND', 'ADJUSTMENT')),
    amount DECIMAL(10,2) NOT NULL,
    balance_before DECIMAL(10,2) NOT NULL,
    balance_after DECIMAL(10,2) NOT NULL,
    currency NVARCHAR(3) NOT NULL DEFAULT 'TWD',
    description NVARCHAR(255) NULL,
    billing_record_id BIGINT NULL,
    charging_transaction_id VARCHAR(50) NULL,
    reference_id NVARCHAR(100) NULL, -- 關聯的充電交易ID或其他參考ID
    payment_method NVARCHAR(50) NULL,
    status NVARCHAR(20) NOT NULL DEFAULT 'COMPLETED' CHECK (status IN ('PENDING', 'COMPLETED', 'FAILED', 'CANCELLED')),
    createdAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    updatedAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_wallet_transactions_user_uuid FOREIGN KEY (user_id) REFERENCES dbo.users(uuid),
    CONSTRAINT FK_wallet_transactions_wallet FOREIGN KEY (wallet_id) REFERENCES dbo.user_wallets(id),
    CONSTRAINT FK_wallet_transactions_billing FOREIGN KEY (billing_record_id) REFERENCES dbo.billing_records(id),
    CONSTRAINT FK_wallet_transactions_charging_transaction FOREIGN KEY (charging_transaction_id) REFERENCES dbo.charging_transactions(transaction_id),
    CONSTRAINT FK_wallet_transactions_payment_method FOREIGN KEY (payment_method) REFERENCES dbo.billing_channels(code)
);
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','用戶UUID', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','user_id';
EXEC sp_addextendedproperty 'MS_Description','錢包ID', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','wallet_id';
EXEC sp_addextendedproperty 'MS_Description','交易類型', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','transaction_type';
EXEC sp_addextendedproperty 'MS_Description','金額', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','amount';
EXEC sp_addextendedproperty 'MS_Description','交易前餘額', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','balance_before';
EXEC sp_addextendedproperty 'MS_Description','交易後餘額', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','balance_after';
EXEC sp_addextendedproperty 'MS_Description','貨幣', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','currency';
EXEC sp_addextendedproperty 'MS_Description','描述', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','description';
EXEC sp_addextendedproperty 'MS_Description','關聯計費記錄ID', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','billing_record_id';
EXEC sp_addextendedproperty 'MS_Description','關聯充電交易ID', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','charging_transaction_id';
EXEC sp_addextendedproperty 'MS_Description','參考ID', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','reference_id';
EXEC sp_addextendedproperty 'MS_Description','支付方式', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','payment_method';
EXEC sp_addextendedproperty 'MS_Description','狀態', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','status';
EXEC sp_addextendedproperty 'MS_Description','創建時間', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','createdAt';
EXEC sp_addextendedproperty 'MS_Description','更新時間', 'SCHEMA','dbo','TABLE','wallet_transactions','COLUMN','updatedAt';
GO

-- 為新表創建索引
CREATE INDEX IX_user_wallets_user_id ON dbo.user_wallets(user_id);
CREATE INDEX IX_rfid_cards_user_id ON dbo.rfid_cards(user_id);
CREATE INDEX IX_rfid_cards_card_number ON dbo.rfid_cards(card_number);
CREATE INDEX IX_rfid_cards_status ON dbo.rfid_cards(status);
CREATE INDEX IX_wallet_transactions_user_id ON dbo.wallet_transactions(user_id);
CREATE INDEX IX_wallet_transactions_wallet_id ON dbo.wallet_transactions(wallet_id);
CREATE INDEX IX_wallet_transactions_transaction_type ON dbo.wallet_transactions(transaction_type);
CREATE INDEX IX_wallet_transactions_billing_record_id ON dbo.wallet_transactions(billing_record_id);
CREATE INDEX IX_wallet_transactions_charging_transaction_id ON dbo.wallet_transactions(charging_transaction_id);
CREATE INDEX IX_wallet_transactions_status ON dbo.wallet_transactions(status);
CREATE INDEX IX_wallet_transactions_createdAt ON dbo.wallet_transactions(createdAt);
GO