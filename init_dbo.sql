IF DB_ID(N'benson_csms_db') IS NULL
BEGIN
    CREATE DATABASE [benson_csms_db];
END
GO

USE [benson_csms_db];
GO


-- Table: tariffs
IF OBJECT_ID(N'dbo.tariffs', N'U') IS NOT NULL
    (N'自訂季節費率', N'自訂月份範圍的費率示例 (3-5月)', N'TIME_OF_USE', 2.80, 0.50, 5.00,
 N'09:00', N'22:00', 3.50, 2.00, 2.50,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 3, 5, N'CUSTOM',
 4.50, 45.00, 20, 90.00, 5.50,
 15, 9.00, 110.00, 0,
 0, 0, 0, 1, 0, N'system', GETDATE(), GETDATE());LE dbo.tariffs;
GO

CREATE TABLE dbo.tariffs (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX) NULL,
    tariff_type NVARCHAR(20) NOT NULL DEFAULT N'FIXED_RATE' 
        CHECK (tariff_type IN (N'FIXED_RATE', N'TIME_OF_USE', N'PROGRESSIVE', N'SPECIAL_PROMOTION', N'MEMBERSHIP', N'CUSTOM')),
    base_price DECIMAL(10,2) NOT NULL,
    charging_parking_fee DECIMAL(10,2) NULL,
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
    season_start_month TINYINT NULL,
    season_end_month TINYINT NULL,
    season_type NVARCHAR(20) NOT NULL DEFAULT N'ALL_YEAR' 
        CHECK (season_type IN (N'SUMMER', N'NON_SUMMER', N'ALL_YEAR', N'CUSTOM')),
    grace_period_minutes INT NULL,
    penalty_rate_per_hour DECIMAL(10,2) NULL,
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
EXEC sp_addextendedproperty 'MS_Description','充電期間停車費率(單次)', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','charging_parking_fee';
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
EXEC sp_addextendedproperty 'MS_Description','季節開始月份 (1-12)', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','season_start_month';
EXEC sp_addextendedproperty 'MS_Description','季節結束月份 (1-12)', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','season_end_month';
EXEC sp_addextendedproperty 'MS_Description','季節類型', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','season_type';
EXEC sp_addextendedproperty 'MS_Description','充電完成後寬限時間 (分鐘)', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','grace_period_minutes';
EXEC sp_addextendedproperty 'MS_Description','超時罰款費率 (每小時)', 'SCHEMA','dbo','TABLE','tariffs','COLUMN','penalty_rate_per_hour';
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
(name, description, tariff_type, base_price, charging_parking_fee,
 peak_hours_start, peak_hours_end, peak_hours_price, off_peak_price, weekend_price,
 tier1_max_kwh, tier1_price, tier2_max_kwh, tier2_price, tier3_price,
 discount_percentage, promotion_code, valid_from, valid_to,
 season_start_month, season_end_month, season_type,
 grace_period_minutes, penalty_rate_per_hour,
 ac_only, dc_only, membership_required, is_active, created_by, createdAt, updatedAt)
VALUES
(N'標準費率', N'適用于所有充電站的基本固定單價費率', N'FIXED_RATE', 2.50, 5.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 NULL, NULL, N'ALL_YEAR',
 15, 8.00,
 0, 0, 0, 1, N'system', GETDATE(), GETDATE()),

(N'峰谷電價', N'根據時段不同收取不同費用的分時費率', N'TIME_OF_USE', 2.80, 4.50,
 N'09:00', N'22:00', 3.50, 1.80, 2.20,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 NULL, NULL, N'ALL_YEAR',
 15, 8.00,
 0, 0, 0, 1, 0, N'system', GETDATE(), GETDATE()),

(N'累進電價', N'用電量越多單價越高的階梯式費率', N'PROGRESSIVE', 2.50, 4.00,
 NULL, NULL, NULL, NULL, NULL,
 10.00, 2.20, 30.00, 2.80, 3.50,
 NULL, NULL, NULL, NULL,
 NULL, NULL, N'ALL_YEAR',
 15, 8.00,
 0, 0, 0, 1, 0, N'system', GETDATE(), GETDATE()),

(N'會員專享', N'會員專享優惠費率', N'MEMBERSHIP', 2.50, 3.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 20.00, NULL, NULL, NULL,
 NULL, NULL, N'ALL_YEAR',
 30, 6.00,
 0, 0, 1, 1, 0, N'system', GETDATE(), GETDATE()),

(N'DC快充費率', N'適用於直流快充的專用費率', N'FIXED_RATE', 3.20, 8.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 NULL, NULL, N'ALL_YEAR',
 10, 50.00,
 0, 1, 0, 1, 0, N'system', GETDATE(), GETDATE()),

(N'AC慢充費率', N'適用於交流慢充的專用費率', N'FIXED_RATE', 2.30, 4.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 NULL, NULL, N'ALL_YEAR',
 20, 30.00,
 1, 0, 0, 1, 0, N'system', GETDATE(), GETDATE()),

(N'新用戶首充優惠', N'新用戶首次充電特惠價格', N'SPECIAL_PROMOTION', 2.00, 2.50,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 50.00, N'FIRST_CHARGE', CAST('2025-09-01' AS DATETIME2), CAST('2025-12-31' AS DATETIME2),
 NULL, NULL, N'ALL_YEAR',
 30, 4.00,
 0, 0, 0, 1, 0, N'system', GETDATE(), GETDATE()),

(N'夏季峰谷電價', N'夏季時段的峰谷電價費率 (6-9月)', N'TIME_OF_USE', 2.80, 4.50,
 N'08:00', N'23:00', 4.00, 2.20, 2.80,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 6, 9, N'SUMMER',
 15, 10.00,
 0, 0, 0, 1, 0, N'system', GETDATE(), GETDATE()),

(N'非夏季峰谷電價', N'非夏季時段的峰谷電價費率 (10-5月)', N'TIME_OF_USE', 2.60, 4.50,
 N'09:00', N'22:00', 3.20, 1.60, 2.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 10, 5, N'NON_SUMMER',
 15, 8.00,
 0, 0, 0, 1, 0, N'system', GETDATE(), GETDATE()),

(N'自訂季節費率', N'自訂月份範圍的費率示例 (3-5月)', N'TIME_OF_USE', 2.80,
 N'09:00', N'22:00', 3.50, 2.00, 2.50,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 3, 5, N'CUSTOM',
 15, 9.00,
 0, 0, 0, 1, 0, N'system', GETDATE(), GETDATE());
GO

CREATE INDEX IX_tariffs_name ON dbo.tariffs(name);
CREATE INDEX IX_tariffs_tariff_type ON dbo.tariffs(tariff_type);
CREATE INDEX IX_tariffs_is_active ON dbo.tariffs(is_active);
CREATE INDEX IX_tariffs_is_default ON dbo.tariffs(is_default);
GO

-- 為 tariffs 表創建觸發器來自動更新 updatedAt
CREATE TRIGGER TR_tariffs_update_timestamp
ON dbo.tariffs
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.tariffs
    SET updatedAt = GETDATE()
    WHERE id IN (SELECT id FROM inserted);
END;
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
    updated_at DATETIME2(0) NOT NULL DEFAULT GETDATE(), -- 更新時間
    CONSTRAINT UQ_stations_station_code UNIQUE (station_code)
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
    meter_id INT NULL,
    CONSTRAINT FK_guns_meter FOREIGN KEY (meter_id) REFERENCES dbo.meters(id),
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

-- 建立 guns 表的索引
CREATE INDEX IX_guns_cpid ON dbo.guns(cpid);
CREATE INDEX IX_guns_cpsn ON dbo.guns(cpsn);
CREATE INDEX IX_guns_connector ON dbo.guns(connector);
CREATE INDEX IX_guns_guns_status ON dbo.guns(guns_status);
CREATE INDEX IX_guns_meter_id ON dbo.guns(meter_id);
CREATE INDEX IX_guns_acdc ON dbo.guns(acdc);
GO

-- 插入預設充電槍資料 (總共7個槍：3個AC槍 + 4個DC槍)
IF NOT EXISTS (SELECT 1 FROM dbo.guns WHERE cpid = N'1000' AND connector = N'1')
BEGIN
    INSERT INTO dbo.guns (connector, cpid, cpsn, guns_status, createdAt, updatedAt, acdc, max_kw, meter_id) VALUES
    -- AC槍 (CP001-CP003，每個充電站1個AC槍)
    (N'1', N'1000', N'CP001', N'Unavailable', GETDATE(), GETDATE(), N'AC', 7, 1),
    (N'1', N'1001', N'CP002', N'Unavailable', GETDATE(), GETDATE(), N'AC', 7, 1),
    (N'1', N'1002', N'CP003', N'Unavailable', GETDATE(), GETDATE(), N'AC', 7, 1),

    -- DC槍 (CP004-CP005，每個充電站2個DC槍，connector 1和2)
    (N'1', N'1003', N'CP004', N'Unavailable', GETDATE(), GETDATE(), N'DC', 120, 1),
    (N'2', N'1004', N'CP004', N'Unavailable', GETDATE(), GETDATE(), N'DC', 120, 1),
    (N'1', N'1005', N'CP005', N'Unavailable', GETDATE(), GETDATE(), N'DC', 120, 1),
    (N'2', N'1006', N'CP005', N'Unavailable', GETDATE(), GETDATE(), N'DC', 120, 1);
END
GO

-- 為 guns 表創建觸發器來自動更新 updatedAt
CREATE TRIGGER TR_guns_update_timestamp
ON dbo.guns
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.guns
    SET updatedAt = GETDATE()
    WHERE id IN (SELECT id FROM inserted);
END;
GO


/****** Table: gun_tariffs ******/
IF OBJECT_ID(N'dbo.gun_tariffs', N'U') IS NOT NULL
    DROP TABLE dbo.gun_tariffs;
GO

CREATE TABLE dbo.gun_tariffs (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    gun_id INT NOT NULL,
    tariff_id INT NOT NULL,
    priority INT NULL DEFAULT 1,
    is_active BIT NOT NULL DEFAULT 1,
    createdAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    updatedAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    CONSTRAINT UQ_gun_tariff UNIQUE (gun_id, tariff_id),
    CONSTRAINT FK_gun_tariffs_gun FOREIGN KEY (gun_id) REFERENCES dbo.guns(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_gun_tariffs_tariff FOREIGN KEY (tariff_id) REFERENCES dbo.tariffs(id) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','gun_tariffs','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','充電槍ID', 'SCHEMA','dbo','TABLE','gun_tariffs','COLUMN','gun_id';
EXEC sp_addextendedproperty 'MS_Description','費率ID', 'SCHEMA','dbo','TABLE','gun_tariffs','COLUMN','tariff_id';
EXEC sp_addextendedproperty 'MS_Description','優先順序 (數字越小優先級越高)', 'SCHEMA','dbo','TABLE','gun_tariffs','COLUMN','priority';
EXEC sp_addextendedproperty 'MS_Description','是否啟用', 'SCHEMA','dbo','TABLE','gun_tariffs','COLUMN','is_active';
EXEC sp_addextendedproperty 'MS_Description','創建時間', 'SCHEMA','dbo','TABLE','gun_tariffs','COLUMN','createdAt';
EXEC sp_addextendedproperty 'MS_Description','更新時間', 'SCHEMA','dbo','TABLE','gun_tariffs','COLUMN','updatedAt';
GO

CREATE INDEX IX_gun_tariffs_gun_id ON dbo.gun_tariffs(gun_id);
CREATE INDEX IX_gun_tariffs_tariff_id ON dbo.gun_tariffs(tariff_id);
CREATE INDEX IX_gun_tariffs_priority ON dbo.gun_tariffs(priority);
CREATE INDEX IX_gun_tariffs_is_active ON dbo.gun_tariffs(is_active);
GO

-- 為 gun_tariffs 表創建觸發器來自動更新 updatedAt
CREATE TRIGGER TR_gun_tariffs_update_timestamp
ON dbo.gun_tariffs
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.gun_tariffs
    SET updatedAt = GETDATE()
    WHERE id IN (SELECT id FROM inserted);
END;
GO

-- 插入預設充電槍費率關聯資料 (每個槍關聯夏季和非夏季費率)
INSERT INTO dbo.gun_tariffs (gun_id, tariff_id, priority, is_active, createdAt, updatedAt)
SELECT g.id, 8, 1, 1, GETDATE(), GETDATE()  -- 夏季峰谷電價 (優先順序1)
FROM dbo.guns g
WHERE g.cpsn LIKE N'CP%'
AND NOT EXISTS (SELECT 1 FROM dbo.gun_tariffs gt WHERE gt.gun_id = g.id AND gt.tariff_id = 8);

INSERT INTO dbo.gun_tariffs (gun_id, tariff_id, priority, is_active, createdAt, updatedAt)
SELECT g.id, 9, 2, 1, GETDATE(), GETDATE()  -- 非夏季峰谷電價 (優先順序2)
FROM dbo.guns g
WHERE g.cpsn LIKE N'CP%'
AND NOT EXISTS (SELECT 1 FROM dbo.gun_tariffs gt WHERE gt.gun_id = g.id AND gt.tariff_id = 9);
GO


/****** Table: users ******/
IF OBJECT_ID(N'dbo.users', N'U') IS NOT NULL
    DROP TABLE dbo.users;
GO

CREATE TABLE dbo.users (
    id INT IDENTITY(7,1) NOT NULL PRIMARY KEY,
    uuid NVARCHAR(36) NULL UNIQUE,
    email NVARCHAR(255) NULL,
    password NVARCHAR(255) NULL,
    role NVARCHAR(255) NULL,
    first_name NVARCHAR(50) NULL,
    last_name NVARCHAR(50) NULL,
    phone NVARCHAR(20) NULL,
    date_of_birth DATE NULL,
    email_verified TINYINT NOT NULL DEFAULT 0,
    account_status NVARCHAR(20) NOT NULL DEFAULT N'ACTIVE' 
        CHECK (account_status IN (N'ACTIVE', N'SUSPENDED', N'BLOCKED', N'PENDING')),
    last_login_at DATETIME2(0) NULL,
    login_count INT NOT NULL DEFAULT 0,
    failed_login_attempts INT NOT NULL DEFAULT 0,
    lockout_until DATETIME2(0) NULL,
    createdAt DATETIME2(0) NOT NULL,
    updatedAt DATETIME2(0) NOT NULL
);
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','users','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','用戶UUID', 'SCHEMA','dbo','TABLE','users','COLUMN','uuid';
EXEC sp_addextendedproperty 'MS_Description','用戶Email', 'SCHEMA','dbo','TABLE','users','COLUMN','email';
EXEC sp_addextendedproperty 'MS_Description','密碼', 'SCHEMA','dbo','TABLE','users','COLUMN','password';
EXEC sp_addextendedproperty 'MS_Description','角色', 'SCHEMA','dbo','TABLE','users','COLUMN','role';
-- 個人資訊欄位描述
EXEC sp_addextendedproperty 'MS_Description','名', 'SCHEMA','dbo','TABLE','users','COLUMN','first_name';
EXEC sp_addextendedproperty 'MS_Description','姓', 'SCHEMA','dbo','TABLE','users','COLUMN','last_name';
EXEC sp_addextendedproperty 'MS_Description','手機號碼', 'SCHEMA','dbo','TABLE','users','COLUMN','phone';
EXEC sp_addextendedproperty 'MS_Description','生日', 'SCHEMA','dbo','TABLE','users','COLUMN','date_of_birth';
-- 帳戶狀態欄位描述
EXEC sp_addextendedproperty 'MS_Description','Email是否驗證', 'SCHEMA','dbo','TABLE','users','COLUMN','email_verified';
EXEC sp_addextendedproperty 'MS_Description','帳戶狀態', 'SCHEMA','dbo','TABLE','users','COLUMN','account_status';
EXEC sp_addextendedproperty 'MS_Description','最後登入時間', 'SCHEMA','dbo','TABLE','users','COLUMN','last_login_at';
EXEC sp_addextendedproperty 'MS_Description','登入次數', 'SCHEMA','dbo','TABLE','users','COLUMN','login_count';
EXEC sp_addextendedproperty 'MS_Description','失敗登入次數', 'SCHEMA','dbo','TABLE','users','COLUMN','failed_login_attempts';
EXEC sp_addextendedproperty 'MS_Description','鎖定到期時間', 'SCHEMA','dbo','TABLE','users','COLUMN','lockout_until';
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
    
    -- 確保所有用戶都有UUID
    IF EXISTS (SELECT 1 FROM dbo.users WHERE uuid IS NULL)
    BEGIN
        RAISERROR('UUID generation failed for some users', 16, 1);
    END
END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.users WHERE email = N'evape@gmail.com')
BEGIN
    INSERT INTO dbo.users (email, password, role, first_name, last_name, phone, date_of_birth, email_verified, account_status, createdAt, updatedAt)
    VALUES (N'evape@gmail.com', N'123456', N'admin', N'Admin', N'User', N'0912345678', '1990-01-01', 1, N'ACTIVE', GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT 1 FROM dbo.users WHERE email = N'user@gmail.com')
BEGIN
    INSERT INTO dbo.users (email, password, role, first_name, last_name, phone, date_of_birth, email_verified, account_status, createdAt, updatedAt)
    VALUES (N'user@gmail.com', N'123456', N'user', N'測試', N'用戶', N'0987654321', '1995-05-15', 1, N'ACTIVE', GETDATE(), GETDATE());
END

-- 確保所有現有用戶都有UUID
UPDATE dbo.users SET uuid = NEWID() WHERE uuid IS NULL;
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
    user_id NVARCHAR(36) NOT NULL,
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

CREATE INDEX IX_users_email ON dbo.users(email);
CREATE INDEX IX_users_account_status ON dbo.users(account_status);
CREATE INDEX IX_users_email_verified ON dbo.users(email_verified);
CREATE INDEX IX_users_last_login_at ON dbo.users(last_login_at);
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
    code NVARCHAR(50) NOT NULL UNIQUE,   -- 支付代碼
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
    user_id NVARCHAR(36) NOT NULL,
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
    CONSTRAINT FK_billing_records_transaction_id FOREIGN KEY (transaction_id) REFERENCES charging_transactions(transaction_id),
    CONSTRAINT FK_billing_records_payment_method FOREIGN KEY (payment_method) REFERENCES billing_channels(code),
    CONSTRAINT FK_billing_records_user_uuid FOREIGN KEY (user_id) REFERENCES dbo.users(uuid)
);
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','交易編號 (關聯 charging_transactions.transaction_id)', 'SCHEMA','dbo','TABLE','billing_records','COLUMN','transaction_id';
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
    user_id NVARCHAR(36) NOT NULL UNIQUE,
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

-- 插入測試用戶的錢包資料
INSERT INTO dbo.user_wallets (user_id, balance, currency, createdAt, updatedAt)
SELECT u.uuid, 1000.00, N'TWD', GETDATE(), GETDATE()
FROM dbo.users u
WHERE u.email = N'user@gmail.com'
AND NOT EXISTS (SELECT 1 FROM dbo.user_wallets w WHERE w.user_id = u.uuid);
GO

-- 插入管理員用戶的錢包資料
INSERT INTO dbo.user_wallets (user_id, balance, currency, createdAt, updatedAt)
SELECT u.uuid, 5000.00, N'TWD', GETDATE(), GETDATE()
FROM dbo.users u
WHERE u.email = N'evape@gmail.com'
AND NOT EXISTS (SELECT 1 FROM dbo.user_wallets w WHERE w.user_id = u.uuid);
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

-- 插入測試用戶的RFID卡資料
INSERT INTO dbo.rfid_cards (card_number, user_id, card_type, status, issued_at, createdAt, updatedAt)
SELECT N'RFID001', u.uuid, N'RFID', N'ACTIVE', GETDATE(), GETDATE(), GETDATE()
FROM dbo.users u
WHERE u.email = N'user@gmail.com'
AND NOT EXISTS (SELECT 1 FROM dbo.rfid_cards r WHERE r.card_number = N'RFID001');
GO

-- 插入管理員用戶的RFID卡資料
INSERT INTO dbo.rfid_cards (card_number, user_id, card_type, status, issued_at, createdAt, updatedAt)
SELECT N'RFID002', u.uuid, N'RFID', N'ACTIVE', GETDATE(), GETDATE(), GETDATE()
FROM dbo.users u
WHERE u.email = N'evape@gmail.com'
AND NOT EXISTS (SELECT 1 FROM dbo.rfid_cards r WHERE r.card_number = N'RFID002');
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
    charging_transaction_id NVARCHAR(50) NULL,
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

-- 插入初始儲值交易記錄
INSERT INTO dbo.wallet_transactions (user_id, wallet_id, transaction_type, amount, balance_before, balance_after, payment_method, description, status, createdAt, updatedAt)
SELECT 
  u.uuid,
  w.id,
  N'DEPOSIT',
  1000.00,
  0.00,
  1000.00,
  N'linepay',
  N'初始儲值',
  N'COMPLETED',
  GETDATE(),
  GETDATE()
FROM dbo.users u
JOIN dbo.user_wallets w ON u.uuid = w.user_id
WHERE u.email = N'user@gmail.com'
AND NOT EXISTS (
    SELECT 1 FROM dbo.wallet_transactions wt 
    WHERE wt.user_id = u.uuid 
    AND wt.transaction_type = N'DEPOSIT' 
    AND wt.amount = 1000.00
    AND wt.description = N'初始儲值'
);
GO

-- 插入管理員用戶的初始儲值交易記錄
INSERT INTO dbo.wallet_transactions (user_id, wallet_id, transaction_type, amount, balance_before, balance_after, payment_method, description, status, createdAt, updatedAt)
SELECT 
  u.uuid,
  w.id,
  N'DEPOSIT',
  5000.00,
  0.00,
  5000.00,
  N'linepay',
  N'管理員初始儲值',
  N'COMPLETED',
  GETDATE(),
  GETDATE()
FROM dbo.users u
JOIN dbo.user_wallets w ON u.uuid = w.user_id
WHERE u.email = N'evape@gmail.com'
AND NOT EXISTS (
    SELECT 1 FROM dbo.wallet_transactions wt 
    WHERE wt.user_id = u.uuid 
    AND wt.transaction_type = N'DEPOSIT' 
    AND wt.amount = 5000.00
    AND wt.description = N'管理員初始儲值'
);
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

-- 創建 operation_logs 表
IF OBJECT_ID(N'dbo.operation_logs', N'U') IS NOT NULL
    DROP TABLE dbo.operation_logs;
GO

CREATE TABLE dbo.operation_logs (
    id BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    user_id NVARCHAR(36) NULL,
    user_email NVARCHAR(255) NULL,
    user_name NVARCHAR(100) NULL,
    action_type NVARCHAR(20) NOT NULL CHECK (action_type IN (N'CREATE', N'UPDATE', N'DELETE', N'LOGIN', N'LOGOUT', N'EXPORT', N'IMPORT', N'APPROVE', N'REJECT', N'RESET')),
    entity_type NVARCHAR(20) NOT NULL CHECK (entity_type IN (N'USER', N'STATION', N'METER', N'GUN', N'TARIFF', N'TRANSACTION', N'BILLING', N'WALLET', N'RFID_CARD', N'PAYMENT_CHANNEL', N'SYSTEM_CONFIG')),
    entity_id NVARCHAR(100) NULL,
    entity_name NVARCHAR(255) NULL,
    description NVARCHAR(500) NULL,
    status NVARCHAR(10) NOT NULL DEFAULT N'SUCCESS' CHECK (status IN (N'SUCCESS', N'FAILED')),
    createdAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_operation_logs_user_uuid FOREIGN KEY (user_id) REFERENCES dbo.users(uuid) ON DELETE SET NULL
);
GO

EXEC sp_addextendedproperty 'MS_Description','主鍵ID', 'SCHEMA','dbo','TABLE','operation_logs','COLUMN','id';
EXEC sp_addextendedproperty 'MS_Description','操作用戶UUID', 'SCHEMA','dbo','TABLE','operation_logs','COLUMN','user_id';
EXEC sp_addextendedproperty 'MS_Description','操作用戶Email', 'SCHEMA','dbo','TABLE','operation_logs','COLUMN','user_email';
EXEC sp_addextendedproperty 'MS_Description','操作用戶名稱', 'SCHEMA','dbo','TABLE','operation_logs','COLUMN','user_name';
EXEC sp_addextendedproperty 'MS_Description','操作類型', 'SCHEMA','dbo','TABLE','operation_logs','COLUMN','action_type';
EXEC sp_addextendedproperty 'MS_Description','操作對象類型', 'SCHEMA','dbo','TABLE','operation_logs','COLUMN','entity_type';
EXEC sp_addextendedproperty 'MS_Description','操作對象ID', 'SCHEMA','dbo','TABLE','operation_logs','COLUMN','entity_id';
EXEC sp_addextendedproperty 'MS_Description','操作對象名稱', 'SCHEMA','dbo','TABLE','operation_logs','COLUMN','entity_name';
EXEC sp_addextendedproperty 'MS_Description','操作描述', 'SCHEMA','dbo','TABLE','operation_logs','COLUMN','description';
EXEC sp_addextendedproperty 'MS_Description','操作狀態', 'SCHEMA','dbo','TABLE','operation_logs','COLUMN','status';
EXEC sp_addextendedproperty 'MS_Description','操作時間', 'SCHEMA','dbo','TABLE','operation_logs','COLUMN','createdAt';
GO

-- 為 operation_logs 表創建索引
CREATE INDEX IX_operation_logs_user_id ON dbo.operation_logs(user_id);
CREATE INDEX IX_operation_logs_user_email ON dbo.operation_logs(user_email);
CREATE INDEX IX_operation_logs_action_type ON dbo.operation_logs(action_type);
CREATE INDEX IX_operation_logs_entity_type ON dbo.operation_logs(entity_type);
CREATE INDEX IX_operation_logs_created_at ON dbo.operation_logs(createdAt);
GO