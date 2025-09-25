CREATE DATABASE  IF NOT EXISTS `benson_csms_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `benson_csms_db`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: benson_csms_db
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tariffs`
--
DROP TABLE IF EXISTS `tariffs`;
CREATE TABLE `tariffs` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `name` VARCHAR(100) NOT NULL COMMENT '費率名稱',
  `description` TEXT COMMENT '費率描述',
  `tariff_type` ENUM('FIXED_RATE','TIME_OF_USE','PROGRESSIVE','SPECIAL_PROMOTION','MEMBERSHIP','CUSTOM') NOT NULL DEFAULT 'FIXED_RATE' COMMENT '費率類型',
  `base_price` DECIMAL(10,2) NOT NULL COMMENT '基本價格',
  `charging_parking_fee` DECIMAL(10,2) DEFAULT NULL COMMENT '充電期間停車費率(單次)',
  `peak_hours_start` VARCHAR(5) DEFAULT NULL COMMENT '尖峰開始時間',
  `peak_hours_end` VARCHAR(5) DEFAULT NULL COMMENT '尖峰結束時間',
  `peak_hours_price` DECIMAL(10,2) DEFAULT NULL COMMENT '尖峰價格',
  `off_peak_price` DECIMAL(10,2) DEFAULT NULL COMMENT '離峰價格',
  `weekend_price` DECIMAL(10,2) DEFAULT NULL COMMENT '假日價格',
  `tier1_max_kwh` DECIMAL(10,2) DEFAULT NULL COMMENT '分層1最大電量',
  `tier1_price` DECIMAL(10,2) DEFAULT NULL COMMENT '分層1價格',
  `tier2_max_kwh` DECIMAL(10,2) DEFAULT NULL COMMENT '分層2最大電量',
  `tier2_price` DECIMAL(10,2) DEFAULT NULL COMMENT '分層2價格',
  `tier3_price` DECIMAL(10,2) DEFAULT NULL COMMENT '分層3價格',
  `discount_percentage` DECIMAL(5,2) DEFAULT NULL COMMENT '折扣百分比',
  `promotion_code` VARCHAR(50) DEFAULT NULL COMMENT '促銷代碼',
  `valid_from` DATETIME DEFAULT NULL COMMENT '有效起始時間',
  `valid_to` DATETIME DEFAULT NULL COMMENT '有效結束時間',
  `season_start_month` TINYINT(2) DEFAULT NULL COMMENT '季節開始月份 (1-12)',
  `season_end_month` TINYINT(2) DEFAULT NULL COMMENT '季節結束月份 (1-12)',
  `season_type` ENUM('SUMMER','NON_SUMMER','ALL_YEAR','CUSTOM') DEFAULT 'ALL_YEAR' COMMENT '季節類型',
  `grace_period_minutes` INT DEFAULT 15 COMMENT '充電後寬限期(分鐘)',
  `penalty_rate_per_hour` DECIMAL(10,2) DEFAULT NULL COMMENT '超時懲罰費率(每小時)',
  `ac_only` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '僅限AC充電',
  `dc_only` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '僅限DC充電',
  `membership_required` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否需要會員',
  `is_active` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否啟用',
  `is_default` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否預設',
  `created_by` VARCHAR(100) DEFAULT NULL COMMENT '建立者ID',
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`),
  KEY `idx_tariff_type` (`tariff_type`),
  KEY `idx_is_active` (`is_active`),
  KEY `idx_is_default` (`is_default`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `tariffs` 
(`name`, `description`, `tariff_type`, `base_price`, `charging_parking_fee`,
 `peak_hours_start`, `peak_hours_end`, `peak_hours_price`, `off_peak_price`, `weekend_price`,
 `tier1_max_kwh`, `tier1_price`, `tier2_max_kwh`, `tier2_price`, `tier3_price`,
 `discount_percentage`, `promotion_code`, `valid_from`, `valid_to`,
 `season_start_month`, `season_end_month`, `season_type`,
 `grace_period_minutes`, `penalty_rate_per_hour`,
 `ac_only`, `dc_only`, `membership_required`, `is_active`, `is_default`, `created_by`, `createdAt`, `updatedAt`)
VALUES
('標準費率', '適用于所有充電站的基本固定單價費率', 'FIXED_RATE', 2.50, 5.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 NULL, NULL, 'ALL_YEAR',
 15, 8.00,
 0, 0, 0, 1, 1, 'system', NOW(), NOW()),

('峰谷電價', '根據時段不同收取不同費用的分時費率', 'TIME_OF_USE', 2.80, 4.50,
 '09:00', '22:00', 3.50, 1.80, 2.20,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 NULL, NULL, 'ALL_YEAR',
 15, 8.00,
 0, 0, 0, 1, 0, 'system', NOW(), NOW()),

('累進電價', '用電量越多單價越高的階梯式費率', 'PROGRESSIVE', 2.50, 4.00,
 NULL, NULL, NULL, NULL, NULL,
 10.00, 2.20, 30.00, 2.80, 3.50,
 NULL, NULL, NULL, NULL,
 NULL, NULL, 'ALL_YEAR',
 15, 8.00,
 0, 0, 0, 1, 0, 'system', NOW(), NOW()),

('會員專享', '會員專享優惠費率', 'MEMBERSHIP', 2.50, 3.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 20.00, NULL, NULL, NULL,
 NULL, NULL, 'ALL_YEAR',
 30, 6.00,
 0, 0, 1, 1, 0, 'system', NOW(), NOW()),

('DC快充費率', '適用於直流快充的專用費率', 'FIXED_RATE', 3.20, 8.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 NULL, NULL, 'ALL_YEAR',
 10, 50.00,
 0, 1, 0, 1, 0, 'system', NOW(), NOW()),

('AC慢充費率', '適用於交流慢充的專用費率', 'FIXED_RATE', 2.30, 4.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 NULL, NULL, 'ALL_YEAR',
 20, 30.00,
 1, 0, 0, 1, 0, 'system', NOW(), NOW()),

('新用戶首充優惠', '新用戶首次充電特惠價格', 'SPECIAL_PROMOTION', 2.00, 2.50,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 50.00, 'FIRST_CHARGE', '2025-09-01', '2025-12-31',
 NULL, NULL, 'ALL_YEAR',
 30, 4.00,
 0, 0, 0, 1, 0, 'system', NOW(), NOW()),

('夏季峰谷電價', '夏季時段的峰谷電價費率 (6-9月)', 'TIME_OF_USE', 3.00, 4.50,
 '08:00', '23:00', 4.00, 2.20, 2.80,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 6, 9, 'SUMMER',
 15, 10.00,
 0, 0, 0, 1, 0, 'system', NOW(), NOW()),

('非夏季峰谷電價', '非夏季時段的峰谷電價費率 (10-5月)', 'TIME_OF_USE', 2.60, 4.50,
 '09:00', '22:00', 3.20, 1.60, 2.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 10, 5, 'NON_SUMMER',
 15, 8.00,
 0, 0, 0, 1, 0, 'system', NOW(), NOW()),

('自訂季節費率', '自訂月份範圍的費率示例 (3-5月)', 'TIME_OF_USE', 2.80, 4.00,
 '09:00', '22:00', 3.50, 2.00, 2.50,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 3, 5, 'CUSTOM',
 15, 9.00,
 0, 0, 0, 1, 0, 'system', NOW(), NOW());

--
-- Table structure for table `stations`
--
DROP TABLE IF EXISTS `stations`;
CREATE TABLE `stations` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '主鍵ID (內部用)',
  `station_code` VARCHAR(50) NOT NULL COMMENT '自定義場域編號',
  `name` VARCHAR(100) DEFAULT NULL COMMENT '場域名稱',
  `address` VARCHAR(255) DEFAULT NULL COMMENT '地址',
  `floor` VARCHAR(50) DEFAULT NULL COMMENT '樓層',
  `operator_id` VARCHAR(50) DEFAULT NULL COMMENT '營運商/業主ID',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_station_code` (`station_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `stations` (`station_code`, `name`, `address`, `floor`, `operator_id`, `updated_at`) VALUES
('STN001', 'XX大樓', '台北市松山區松江路220號', '4F', 'OP01', NOW());

--
-- Table structure for table `meters`
--
DROP TABLE IF EXISTS `meters`;
CREATE TABLE `meters` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `station_id` INT NOT NULL COMMENT '關聯場域ID (stations.id)',
  `meter_no` VARCHAR(50) NOT NULL COMMENT '電表編號',
  `ems_mode` VARCHAR(32) NOT NULL DEFAULT 'static' COMMENT 'EMS模式',
  `max_power_kw` DECIMAL(10,2) NOT NULL DEFAULT '480.00' COMMENT '最大功率(kW)',
  `billing_mode` VARCHAR(32) DEFAULT NULL COMMENT '計費模式 (independent/shared/split)',
  `owner_id` VARCHAR(50) DEFAULT NULL COMMENT '電表所有人ID',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_station_meter` (`station_id`, `meter_no`),
  CONSTRAINT `fk_meter_station` FOREIGN KEY (`station_id`) REFERENCES `stations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `meters` (`station_id`, `meter_no`, `ems_mode`, `max_power_kw`, `billing_mode`, `owner_id`, `updated_at`)
VALUES
(1, 'MTR001', 'static', 480.00, 'independent', NULL, NOW());

--
-- Table structure for table `guns`
--

DROP TABLE IF EXISTS `guns`;
CREATE TABLE `guns` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `connector` varchar(45) DEFAULT NULL COMMENT '充電槍編號/接頭號',
  `cpid` varchar(255) DEFAULT NULL COMMENT '充電樁ID',
  `cpsn` varchar(255) DEFAULT NULL COMMENT '充電樁序號',
  `guns_status` varchar(45) DEFAULT NULL COMMENT '充電槍狀態',
  `createdAt` date DEFAULT NULL COMMENT '建立日期',
  `updatedAt` date DEFAULT NULL COMMENT '更新日期',
  `guns_metervalue1` varchar(255) DEFAULT NULL COMMENT '電表數值1',
  `guns_metervalue2` varchar(255) DEFAULT NULL COMMENT '電表數值2',
  `guns_metervalue3` varchar(255) DEFAULT NULL COMMENT '電表數值3',
  `guns_metervalue4` varchar(255) DEFAULT NULL COMMENT '電表數值4',
  `guns_metervalue5` varchar(255) DEFAULT NULL COMMENT '電表數值5',
  `guns_metervalue6` varchar(255) DEFAULT NULL COMMENT '電表數值6',
  `guns_memo1` varchar(255) DEFAULT NULL COMMENT '備註1',
  `guns_memo2` varchar(255) DEFAULT NULL COMMENT '備註2',
  `transactionid` varchar(255) DEFAULT NULL COMMENT '交易ID',
  `acdc` ENUM('AC','DC') DEFAULT 'AC' COMMENT '充電型態 AC/DC',
  `max_kw` int DEFAULT 0 COMMENT '最大功率(kW)',
  `meter_id` INT NOT NULL COMMENT '關聯電表ID (meters.id)',
  PRIMARY KEY (`id`),
  KEY `IX_guns_meter_id` (`meter_id`),
  CONSTRAINT `fk_guns_meter` FOREIGN KEY (`meter_id`) REFERENCES `meters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 插入預設充電槍資料 (總共7個槍：3個AC槍 + 4個DC槍)
INSERT INTO `guns` (`connector`, `cpid`, `cpsn`, `guns_status`, `createdAt`, `updatedAt`, `acdc`, `max_kw`, `meter_id`) VALUES
-- AC槍 (CP001-CP003，每個充電站1個AC槍)
('1', '1000', 'CP001', 'Unavailable', CURDATE(), CURDATE(), 'AC', 7, 1),
('1', '1001', 'CP002', 'Unavailable', CURDATE(), CURDATE(), 'AC', 7, 1),
('1', '1002', 'CP003', 'Unavailable', CURDATE(), CURDATE(), 'AC', 7, 1),

-- DC槍 (CP004-CP005，每個充電站2個DC槍，connector 1和2)
('1', '1003', 'CP004', 'Unavailable', CURDATE(), CURDATE(), 'DC', 120, 1),
('2', '1004', 'CP004', 'Unavailable', CURDATE(), CURDATE(), 'DC', 120, 1),
('1', '1005', 'CP005', 'Unavailable', CURDATE(), CURDATE(), 'DC', 120, 1),
('2', '1006', 'CP005', 'Unavailable', CURDATE(), CURDATE(), 'DC', 120, 1)
ON DUPLICATE KEY UPDATE
  `guns_status` = VALUES(`guns_status`),
  `updatedAt` = CURDATE();


--
-- Table structure for table `gun_tariffs`
--

DROP TABLE IF EXISTS `gun_tariffs`;
CREATE TABLE `gun_tariffs` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `gun_id` int NOT NULL COMMENT '關聯充電槍ID (guns.id)',
  `tariff_id` int NOT NULL COMMENT '關聯費率ID (tariffs.id)',
  `priority` int DEFAULT 1 COMMENT '費率優先順序 (數字越小優先級越高)',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否啟用此費率',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_gun_tariff` (`gun_id`, `tariff_id`),
  KEY `IX_gun_tariffs_gun_id` (`gun_id`),
  KEY `IX_gun_tariffs_tariff_id` (`tariff_id`),
  KEY `IX_gun_tariffs_priority` (`priority`),
  KEY `IX_gun_tariffs_is_active` (`is_active`),
  CONSTRAINT `fk_gun_tariffs_gun` FOREIGN KEY (`gun_id`) REFERENCES `guns` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_gun_tariffs_tariff` FOREIGN KEY (`tariff_id`) REFERENCES `tariffs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 插入預設充電槍費率關聯資料 (每個槍關聯夏季和非夏季費率)
INSERT INTO `gun_tariffs` (`gun_id`, `tariff_id`, `priority`, `is_active`, `createdAt`, `updatedAt`)
SELECT g.id, 8, 1, 1, NOW(), NOW()  -- 夏季峰谷電價 (優先順序1)
FROM `guns` g
WHERE g.cpsn LIKE 'CP%'
ON DUPLICATE KEY UPDATE
  `priority` = VALUES(`priority`),
  `is_active` = VALUES(`is_active`),
  `updatedAt` = NOW();

INSERT INTO `gun_tariffs` (`gun_id`, `tariff_id`, `priority`, `is_active`, `createdAt`, `updatedAt`)
SELECT g.id, 9, 2, 1, NOW(), NOW()  -- 非夏季峰谷電價 (優先順序2)
FROM `guns` g
WHERE g.cpsn LIKE 'CP%'
ON DUPLICATE KEY UPDATE
  `priority` = VALUES(`priority`),
  `is_active` = VALUES(`is_active`),
  `updatedAt` = NOW();

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `uuid` varchar(36) DEFAULT NULL COMMENT '用戶UUID',
  `email` varchar(255) DEFAULT NULL COMMENT '用戶Email',
  `password` varchar(255) DEFAULT NULL COMMENT '用戶密碼',
  `role` varchar(255) DEFAULT NULL COMMENT '用戶角色',
  `first_name` VARCHAR(50) NULL COMMENT '名',
  `last_name` VARCHAR(50) NULL COMMENT '姓',
  `phone` VARCHAR(20) NULL COMMENT '手機號碼',
  `date_of_birth` DATE NULL COMMENT '生日',
  `email_verified` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Email是否驗證',
  `account_status` ENUM('ACTIVE','SUSPENDED','BLOCKED','PENDING') NOT NULL DEFAULT 'ACTIVE' COMMENT '帳戶狀態',
  `last_login_at` DATETIME NULL COMMENT '最後登入時間',
  `login_count` INT NOT NULL DEFAULT 0 COMMENT '登入次數',
  `failed_login_attempts` INT NOT NULL DEFAULT 0 COMMENT '失敗登入次數',
  `lockout_until` DATETIME NULL COMMENT '鎖定到期時間',
  `createdAt` datetime NOT NULL COMMENT '建立時間',
  `updatedAt` datetime NOT NULL COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_users_uuid` (`uuid`),
  KEY `idx_email` (`email`),
  KEY `idx_account_status` (`account_status`),
  KEY `idx_email_verified` (`email_verified`),
  KEY `idx_last_login_at` (`last_login_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 插入初始資料 
INSERT INTO `users` (`uuid`, `email`, `password`, `role`, `first_name`, `last_name`, `phone`, `date_of_birth`, `email_verified`, `account_status`, `createdAt`, `updatedAt`) VALUES
('cc2bccd0-c979-11e9-ba8d-d70282892727', 'evape@gmail.com', '123456', 'admin', 'Admin', 'User', '0912345678', '1990-01-01', 1, 'ACTIVE', NOW(), NOW());

INSERT INTO `users` (`uuid`, `email`, `password`, `role`, `first_name`, `last_name`, `phone`, `date_of_birth`, `email_verified`, `account_status`, `createdAt`, `updatedAt`) VALUES
('cc2bccd0-c979-11e9-ba8d-d70282892728', 'user@gmail.com', '123456', 'user', '測試', '用戶', '0987654321', '1995-05-15', 1, 'ACTIVE', NOW(), NOW());


--
-- Table structure for table `charging_transactions`
--
DROP TABLE IF EXISTS `charging_transactions`;
CREATE TABLE `charging_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `transaction_id` varchar(50) NOT NULL UNIQUE COMMENT '交易ID',
  `start_time` datetime(0) NOT NULL COMMENT '開始時間',
  `end_time` datetime(0) DEFAULT NULL COMMENT '結束時間',
  `cpid` varchar(255) NOT NULL COMMENT '充電樁ID',
  `cpsn` varchar(255) NOT NULL COMMENT '充電樁序號',
  `connector_id` int NOT NULL COMMENT '接頭ID',
  `user_id` varchar(36) NOT NULL COMMENT '用戶UUID',
  `id_tag` varchar(20) NOT NULL COMMENT '用戶ID標籤 or rfid',
  `meter_start` decimal(10,3) DEFAULT NULL COMMENT '開始電表讀值',
  `meter_stop` decimal(10,3) DEFAULT NULL COMMENT '結束電表讀值',
  `energy_consumed` decimal(10,3) DEFAULT NULL COMMENT '消耗電量(kWh)',
  `current_power` decimal(8,3) DEFAULT NULL COMMENT '即時功率(kW)',
  `current_voltage` decimal(8,2) DEFAULT NULL COMMENT '即時電壓(V)',
  `current_current` decimal(8,2) DEFAULT NULL COMMENT '即時電流(A)',
  `last_meter_update` datetime(0) DEFAULT NULL COMMENT '最後電表更新時間',
  `charging_duration` int DEFAULT NULL COMMENT '充電時長(秒)',
  `status` ENUM('ACTIVE','COMPLETED','STOPPED','ERROR','CANCELLED') NOT NULL DEFAULT 'ACTIVE' COMMENT '交易狀態',
  `stop_reason` varchar(100) DEFAULT NULL COMMENT '停止原因',
  `createdAt` datetime(0) NOT NULL COMMENT '建立時間',
  `updatedAt` datetime(0) NOT NULL COMMENT '更新時間',
  PRIMARY KEY (`id`),
  KEY `idx_transaction_id` (`transaction_id`),
  KEY `idx_cpid` (`cpid`),
  KEY `idx_cpsn` (`cpsn`),
  KEY `idx_id_tag` (`id_tag`),
  KEY `idx_status` (`status`),
  KEY `idx_start_time` (`start_time`),
  KEY `idx_end_time` (`end_time`),
  CONSTRAINT `fk_charging_transactions_user_uuid` FOREIGN KEY (`user_id`) REFERENCES `users` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `billing_channels`
--
DROP TABLE IF EXISTS `billing_channels`;
CREATE TABLE `billing_channels` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `name` VARCHAR(50) NOT NULL COMMENT '支付方式名稱 (例: 信用卡, LinePay, 街口)',
  `code` VARCHAR(30) NOT NULL UNIQUE COMMENT '支付代碼 (例: credit_card, linepay, jkopay)',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT '是否啟用 (0=停用,1=啟用)',
  `config` JSON DEFAULT NULL COMMENT '渠道配置 (API key, Merchant ID 等)',
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_billing_channels_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `billing_channels` (`name`, `code`, `status`, `config`)
VALUES
('信用卡', 'credit_card', 1, NULL),
('RFID', 'rfid', 1, NULL),
('Line Pay', 'linepay', 1, NULL)
ON DUPLICATE KEY UPDATE
  `name` = VALUES(`name`),
  `status` = VALUES(`status`),
  `config` = VALUES(`config`),
  `updatedAt` = CURRENT_TIMESTAMP;

--
-- Table structure for table `billing_records`
--
DROP TABLE IF EXISTS `billing_records`;
CREATE TABLE `billing_records` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `transaction_id` VARCHAR(50) NOT NULL COMMENT '交易ID (關聯 charging_transactions.transaction_id)',
  `tariff_id` INT NOT NULL COMMENT '費率ID',
  `applied_price` DECIMAL(10,2) NOT NULL COMMENT '實際計費價格',
  `energy_consumed` DECIMAL(10,3) NOT NULL COMMENT '消耗電量(kWh)',
  `energy_fee` DECIMAL(10,2) NOT NULL COMMENT '電量費用',
  `service_fee` DECIMAL(10,2) NOT NULL COMMENT '服務費',
  `discount_amount` DECIMAL(10,2) DEFAULT NULL COMMENT '折扣金額',
  `tax_amount` DECIMAL(10,2) DEFAULT NULL COMMENT '稅額',
  `total_amount` DECIMAL(10,2) NOT NULL COMMENT '總金額',
  `currency` VARCHAR(3) NOT NULL DEFAULT 'TWD' COMMENT '幣別',
  `start_time` DATETIME NOT NULL COMMENT '計費開始時間',
  `end_time` DATETIME NOT NULL COMMENT '計費結束時間',
  `charging_duration` INT NOT NULL COMMENT '充電時長(秒)',
  `billing_details` TEXT COMMENT '計費明細',
  `invoice_number` VARCHAR(20) DEFAULT NULL COMMENT '發票號碼',
  `invoice_issued_at` DATETIME DEFAULT NULL COMMENT '發票開立時間',
  `payment_method` VARCHAR(50) DEFAULT NULL COMMENT '付款方式',
  `payment_reference` VARCHAR(100) DEFAULT NULL COMMENT '付款參考號',
  `payment_time` DATETIME DEFAULT NULL COMMENT '付款時間',
  `user_id` VARCHAR(36) DEFAULT NULL COMMENT '用戶UUID',
  `id_tag` VARCHAR(20) NOT NULL COMMENT '用戶ID標籤',
  `cpid` VARCHAR(255) NOT NULL COMMENT '充電樁ID',
  `cpsn` VARCHAR(255) NOT NULL COMMENT '充電樁序號',
  `connector_id` INT NOT NULL COMMENT '接頭ID',
  `status` ENUM('PENDING','CALCULATED','INVOICED','PAID','CANCELLED','ERROR') NOT NULL DEFAULT 'CALCULATED' COMMENT '計費狀態',
  `remark` TEXT COMMENT '備註',
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  KEY `idx_transaction_id` (`transaction_id`),
  KEY `idx_tariff_id` (`tariff_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_id_tag` (`id_tag`),
  KEY `idx_cpid` (`cpid`),
  KEY `idx_status` (`status`),
  KEY `idx_start_time` (`start_time`),
  KEY `idx_invoice_number` (`invoice_number`),
  CONSTRAINT `fk_billing_records_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `charging_transactions` (`transaction_id`),
  CONSTRAINT `fk_billing_records_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `tariffs` (`id`),
  CONSTRAINT `fk_billing_records_payment_method` FOREIGN KEY (`payment_method`) REFERENCES `billing_channels` (`code`),
  CONSTRAINT `fk_billing_records_user_uuid` FOREIGN KEY (`user_id`) REFERENCES `users` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `user_wallets`
--
DROP TABLE IF EXISTS `user_wallets`;
CREATE TABLE `user_wallets` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `user_id` VARCHAR(36) NOT NULL COMMENT '用戶UUID',
  `balance` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '錢包餘額',
  `currency` VARCHAR(3) NOT NULL DEFAULT 'TWD' COMMENT '貨幣',
  `status` ENUM('ACTIVE','SUSPENDED','CLOSED') NOT NULL DEFAULT 'ACTIVE' COMMENT '錢包狀態',
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_wallet` (`user_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_user_wallets_user_uuid` FOREIGN KEY (`user_id`) REFERENCES `users` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 插入測試用戶的錢包資料
INSERT INTO `user_wallets` (`user_id`, `balance`, `currency`, `status`, `createdAt`, `updatedAt`)
SELECT u.uuid, 1000.00, 'TWD', 'ACTIVE', NOW(), NOW()
FROM `users` u
WHERE u.email = 'user@gmail.com'
ON DUPLICATE KEY UPDATE
  `balance` = VALUES(`balance`),
  `updatedAt` = NOW();

-- 插入管理員用戶的錢包資料
INSERT INTO `user_wallets` (`user_id`, `balance`, `currency`, `status`, `createdAt`, `updatedAt`)
SELECT u.uuid, 5000.00, 'TWD', 'ACTIVE', NOW(), NOW()
FROM `users` u
WHERE u.email = 'evape@gmail.com'
ON DUPLICATE KEY UPDATE
  `balance` = VALUES(`balance`),
  `updatedAt` = NOW();

--
-- Table structure for table `rfid_cards`
--

DROP TABLE IF EXISTS `rfid_cards`;
CREATE TABLE `rfid_cards` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `card_number` VARCHAR(50) NOT NULL UNIQUE COMMENT 'RFID卡號',
  `user_id` VARCHAR(36) NOT NULL COMMENT '綁定用戶UUID',
  `card_type` VARCHAR(20) NOT NULL DEFAULT 'RFID' COMMENT '卡類型',
  `status` ENUM('ACTIVE','SUSPENDED','LOST','EXPIRED','BLOCKED') NOT NULL DEFAULT 'ACTIVE' COMMENT '卡片狀態',
  `issued_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '發卡時間',
  `last_used_at` DATETIME DEFAULT NULL COMMENT '最後使用時間',
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_card_number` (`card_number`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_rfid_cards_user_uuid` FOREIGN KEY (`user_id`) REFERENCES `users` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 插入測試用戶的RFID卡資料
INSERT INTO `rfid_cards` (`card_number`, `user_id`, `card_type`, `status`, `issued_at`, `createdAt`, `updatedAt`)
SELECT 'RFID001', u.uuid, 'RFID', 'ACTIVE', NOW(), NOW(), NOW()
FROM `users` u
WHERE u.email = 'user@gmail.com'
ON DUPLICATE KEY UPDATE
  `status` = VALUES(`status`),
  `updatedAt` = NOW();

-- 插入管理員用戶的RFID卡資料
INSERT INTO `rfid_cards` (`card_number`, `user_id`, `card_type`, `status`, `issued_at`, `createdAt`, `updatedAt`)
SELECT 'RFID002', u.uuid, 'RFID', 'ACTIVE', NOW(), NOW(), NOW()
FROM `users` u
WHERE u.email = 'evape@gmail.com'
ON DUPLICATE KEY UPDATE
  `status` = VALUES(`status`),
  `updatedAt` = NOW();

--
-- Table structure for table `wallet_transactions`
--

DROP TABLE IF EXISTS `wallet_transactions`;
CREATE TABLE `wallet_transactions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `user_id` VARCHAR(36) NOT NULL COMMENT '用戶UUID',
  `wallet_id` INT UNSIGNED NOT NULL COMMENT '錢包ID',
  `transaction_type` ENUM('DEPOSIT','WITHDRAWAL','PAYMENT','REFUND','ADJUSTMENT') NOT NULL COMMENT '交易類型',
  `amount` DECIMAL(10,2) NOT NULL COMMENT '交易金額',
  `balance_before` DECIMAL(10,2) NOT NULL COMMENT '交易前餘額',
  `balance_after` DECIMAL(10,2) NOT NULL COMMENT '交易後餘額',
  `billing_record_id` BIGINT UNSIGNED DEFAULT NULL COMMENT '關聯計費記錄ID',
  `charging_transaction_id` VARCHAR(50) DEFAULT NULL COMMENT '關聯充電交易ID',
  `payment_method` VARCHAR(50) DEFAULT NULL COMMENT '支付方式',
  `payment_reference` VARCHAR(100) DEFAULT NULL COMMENT '支付參考號',
  `description` VARCHAR(255) DEFAULT NULL COMMENT '交易描述',
  `status` ENUM('PENDING','COMPLETED','FAILED','CANCELLED') NOT NULL DEFAULT 'COMPLETED' COMMENT '交易狀態',
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_wallet_id` (`wallet_id`),
  KEY `idx_transaction_type` (`transaction_type`),
  KEY `idx_billing_record_id` (`billing_record_id`),
  KEY `idx_charging_transaction_id` (`charging_transaction_id`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`createdAt`),
  CONSTRAINT `fk_wallet_transactions_user_uuid` FOREIGN KEY (`user_id`) REFERENCES `users` (`uuid`),
  CONSTRAINT `fk_wallet_transactions_wallet` FOREIGN KEY (`wallet_id`) REFERENCES `user_wallets` (`id`),
  CONSTRAINT `fk_wallet_transactions_billing` FOREIGN KEY (`billing_record_id`) REFERENCES `billing_records` (`id`),
  CONSTRAINT `fk_wallet_transactions_charging_transaction` FOREIGN KEY (`charging_transaction_id`) REFERENCES `charging_transactions` (`transaction_id`),
  CONSTRAINT `fk_wallet_transactions_payment_method` FOREIGN KEY (`payment_method`) REFERENCES `billing_channels` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 插入初始儲值交易記錄
INSERT INTO `wallet_transactions` (`user_id`, `wallet_id`, `transaction_type`, `amount`, `balance_before`, `balance_after`, `payment_method`, `description`, `status`, `createdAt`, `updatedAt`)
SELECT 
  u.uuid,
  w.id,
  'DEPOSIT',
  1000.00,
  0.00,
  1000.00,
  'linepay',
  '初始儲值',
  'COMPLETED',
  NOW(),
  NOW()
FROM `users` u
JOIN `user_wallets` w ON u.uuid = w.user_id
WHERE u.email = 'user@gmail.com'
ON DUPLICATE KEY UPDATE
  `status` = VALUES(`status`);

-- 插入管理員用戶的初始儲值交易記錄
INSERT INTO `wallet_transactions` (`user_id`, `wallet_id`, `transaction_type`, `amount`, `balance_before`, `balance_after`, `payment_method`, `description`, `status`, `createdAt`, `updatedAt`)
SELECT 
  u.uuid,
  w.id,
  'DEPOSIT',
  5000.00,
  0.00,
  5000.00,
  'linepay',
  '管理員初始儲值',
  'COMPLETED',
  NOW(),
  NOW()
FROM `users` u
JOIN `user_wallets` w ON u.uuid = w.user_id
WHERE u.email = 'evape@gmail.com'
ON DUPLICATE KEY UPDATE
  `status` = VALUES(`status`);

--
-- Table structure for table `cp_logs`
--

DROP TABLE IF EXISTS `cp_logs`;
CREATE TABLE `cp_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `cpid` varchar(255) DEFAULT NULL COMMENT '充電樁ID',
  `cpsn` varchar(255) DEFAULT NULL COMMENT '充電樁序號',
  `log` longtext COMMENT '紀錄訊息',
  `inout` varchar(45) DEFAULT NULL COMMENT '進出狀態',
  `time` datetime DEFAULT NULL COMMENT '記錄時間',
  `createdAt` datetime DEFAULT NULL COMMENT '資料建立時間',
  `updatedAt` datetime DEFAULT NULL COMMENT '資料更新時間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=837 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `operation_logs`
--
DROP TABLE IF EXISTS `operation_logs`;
CREATE TABLE `operation_logs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `user_id` VARCHAR(36) DEFAULT NULL COMMENT '操作用戶UUID',
  `user_email` VARCHAR(255) DEFAULT NULL COMMENT '操作用戶Email',
  `user_name` VARCHAR(100) DEFAULT NULL COMMENT '操作用戶名稱',
  `action_type` ENUM('CREATE','UPDATE','DELETE','LOGIN','LOGOUT','EXPORT','IMPORT','APPROVE','REJECT','RESET') NOT NULL COMMENT '操作類型',
  `entity_type` ENUM('USER','STATION','METER','GUN','TARIFF','TRANSACTION','BILLING','WALLET','RFID_CARD','PAYMENT_CHANNEL','SYSTEM_CONFIG') NOT NULL COMMENT '操作對象類型',
  `entity_id` VARCHAR(100) DEFAULT NULL COMMENT '操作對象ID',
  `entity_name` VARCHAR(255) DEFAULT NULL COMMENT '操作對象名稱',
  `description` VARCHAR(500) DEFAULT NULL COMMENT '操作描述',
  `status` ENUM('SUCCESS','FAILED') NOT NULL DEFAULT 'SUCCESS' COMMENT '操作狀態',
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作時間',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_user_email` (`user_email`),
  KEY `idx_action_type` (`action_type`),
  KEY `idx_entity_type` (`entity_type`),
  KEY `idx_created_at` (`createdAt`),
  CONSTRAINT `fk_operation_logs_user_uuid` FOREIGN KEY (`user_id`) REFERENCES `users` (`uuid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-20  0:39:10

DELIMITER //
CREATE TRIGGER `generate_uuid` BEFORE INSERT ON `users`
FOR EACH ROW
BEGIN
  IF NEW.`uuid` IS NULL THEN
    SET NEW.`uuid` = UUID();
  END IF;
END;
//
DELIMITER ;
