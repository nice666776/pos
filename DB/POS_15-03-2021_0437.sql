/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 8.0.20 : Database - posdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`posdb` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `posdb`;

/*Table structure for table `account_control` */

DROP TABLE IF EXISTS `account_control`;

CREATE TABLE `account_control` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `key` varchar(2) DEFAULT NULL,
  `ac_type` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `account_control` */

insert  into `account_control`(`id`,`name`,`key`,`ac_type`) values 
(1,'Assets','A','Dr.'),
(2,'Liabilities','L','Cr.'),
(3,'Capital','C','Cr.'),
(4,'Expenditure','E','Dr.'),
(5,'Income','I','Cr.');

/*Table structure for table `accounts_group` */

DROP TABLE IF EXISTS `accounts_group`;

CREATE TABLE `accounts_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ac_group_id` varchar(10) DEFAULT NULL,
  `ac_group_name` varchar(50) DEFAULT NULL,
  `ac_type` varchar(50) DEFAULT NULL,
  `control_type` varchar(10) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `comments` varchar(100) DEFAULT NULL,
  `client_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

/*Data for the table `accounts_group` */

insert  into `accounts_group`(`id`,`ac_group_id`,`ac_group_name`,`ac_type`,`control_type`,`description`,`comments`,`client_code`) values 
(1,'01','Current Assets','Dr.','A','Provides financial','op','01'),
(2,'02','Fixed Assets','Dr.','A','Provides financial information to management by researching and analyzing accounting data. Provides financial information to management by researching and analyzing accounting data','op','01'),
(3,'03','Current Liabilities','Cr.','L','Provides financial information to management by researching and analyzing accounting data','op','01'),
(4,'04','Non-Current Liabilities','Cr.','L','Provides financial information to management by researching and analyzing accounting data','op','01'),
(5,'05','Owner\'s Equity','Cr.','C','Provides financial information to management by researching and analyzing accounting data','op','01'),
(7,'06','Fees Related Income','Cr.','I','Provides financial information to management by researching and analyzing accounting data','op','01'),
(8,'07','Others Income','Cr.','I','Provides financial information to management by researching and analyzing accounting data','op','01'),
(9,'08','General Expenses','Dr.','E','Provides financial information to management by researching and analyzing accounting data','op','01'),
(10,'09','Others Expenses','Dr.','E','Provides financial information to management by researching and analyzing accounting data','op','01'),
(11,'10','Director\'s Investment','Cr.','C','Provides financial information to management by researching and analyzing accounting data','op','01'),
(23,'11','Owner\'s Equity','Cr.','C','N/A','No Comments','01'),
(24,'12','Retirement','Cr.','L','N/A','hope','01'),
(25,'13','Others Income 1','Cr.','I','N/A','No comment','01'),
(26,'14','Mid Quarter Budget','Cr.','C','SS','ujet','01');

/*Table structure for table `accounts_head` */

DROP TABLE IF EXISTS `accounts_head`;

CREATE TABLE `accounts_head` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ac_head_id` varchar(10) DEFAULT NULL,
  `ac_head_name` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ac_group_id` varchar(10) DEFAULT NULL,
  `ac_type` varchar(50) DEFAULT NULL,
  `ac_status` tinyint(1) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

/*Data for the table `accounts_head` */

insert  into `accounts_head`(`id`,`ac_head_id`,`ac_head_name`,`description`,`ac_group_id`,`ac_type`,`ac_status`,`client_code`) values 
(1,'0101','Cash and cash equivalents','Provides financial information','01','Dr.',1,'01'),
(2,'0102','Bank Account','Provides financial information to management by researching and analyzing accounting data','01','Dr.',1,'01'),
(3,'0201','Office Equipment','Provides financial information to management by researching and analyzing accounting data','02','Dr.',1,'01'),
(4,'0202','Furniture','Provides financial information to management by researching and analyzing accounting data','02','Dr.',1,'01'),
(5,'0203','Computer and ICT related Materials','Provides financial information to management by researching and analyzing accounting data','02','Dr.',1,'01'),
(6,'0301','Loan and Borrowings','Provides financial information to management by researching and analyzing accounting data','03','Cr.',1,'01'),
(7,'0302','Payroll/Salary Accounts','Provides financial information to management by researching and analyzing accounting data','03','Cr.',1,'01'),
(8,'1001','Director\'s Investment','Provides financial information to management by researching and analyzing accounting data','10','Cr.',1,'01'),
(9,'0601','Admission Fees','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(10,'0602','Monthly Fees','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(11,'0603','Examination Fees','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(12,'0604','Development Fee','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(13,'0605','Semester Fee','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(14,'0606','Registration Fees','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(15,'0607','Library','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(16,'0608','Sports & Culture','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(17,'0609','ICT Fee','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(18,'0610','Laboratory','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(19,'0611','Guidance & Counseling','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(20,'0612','BNCC & Scout','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(21,'0613','Refreshment','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(22,'0614','Medical & Nursing','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(23,'0615','Transport','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(24,'0801','House Rent','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(25,'0802','Electricity Bill','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(26,'0803','Internet Bill','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(27,'0804','Inventory costs','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(29,'0806','Consultant fees','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(30,'0807','Water Bill','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(31,'0808','Gas Bill','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(32,'0809','Gardening','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(33,'0810','Cleaning','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(34,'0901','Student Welfare','N/A','09','Dr.',1,'01'),
(35,'1002','Quarterly Investment','N/A','10','Cr.',1,'01'),
(36,'0101','Cash and cash equivalents','Provides financial information to management by researching and analyzing accounting data','01','Dr.',1,'01'),
(37,'0102','Bank Account','Provides financial information to management by researching and analyzing accounting data','01','Dr.',1,'01'),
(38,'0201','Office Equipment','Provides financial information to management by researching and analyzing accounting data','02','Dr.',1,'01'),
(39,'0202','Furniture','Provides financial information to management by researching and analyzing accounting data','02','Dr.',1,'01'),
(40,'0203','Computer and ICT related Materials','Provides financial information to management by researching and analyzing accounting data','02','Dr.',1,'01'),
(41,'0301','Loan and Borrowings','Provides financial information to management by researching and analyzing accounting data','03','Cr.',1,'01'),
(42,'0302','Payroll/Salary Accounts','Provides financial information to management by researching and analyzing accounting data','03','Cr.',1,'01'),
(43,'1001','Director\'s Investment','Provides financial information to management by researching and analyzing accounting data','10','Cr.',1,'01'),
(44,'0601','Admission Fees','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(45,'0602','Monthly Fees','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(46,'0603','Examination Fees','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(47,'0604','Development Fee','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(48,'0605','Semester Fee','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(49,'0606','Registration Fees','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(50,'0607','Library','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(51,'0608','Sports & Culture','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(52,'0609','ICT Fee','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(53,'0610','Laboratory','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(54,'0611','Guidance & Counseling','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(55,'0612','BNCC & Scout','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(56,'0613','Refreshment','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(57,'0614','Medical & Nursing','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(58,'0615','Transport','Provides financial information to management by researching and analyzing accounting data','06','Cr.',1,'01'),
(59,'0801','House Rent','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(60,'0802','Electricity Bill','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(61,'0803','Internet Bill','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(62,'0804','Inventory costs','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(63,'0806','Consultant fees','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(64,'0807','Water Bill','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(65,'0808','Gas Bill','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(66,'0809','Gardening','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(67,'0810','Cleaning','Provides financial information to management by researching and analyzing accounting data','08','Dr.',1,'01'),
(68,'0901','Student Welfare','N/A','09','Dr.',1,'01'),
(69,'1002','Quarterly Investment','N/A','10','Cr.',1,'01'),
(70,'1003','Yearly Investment','N/A','10','Cr.',1,'01'),
(71,'0616','Admission Fee','N/A','06','Cr.',1,'01'),
(72,'0811','Slipper','DL','08','Dr.',1,'01');

/*Table structure for table `aspnetroleclaims` */

DROP TABLE IF EXISTS `aspnetroleclaims`;

CREATE TABLE `aspnetroleclaims` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `RoleId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ClaimType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ClaimValue` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `aspnetroleclaims` */

/*Table structure for table `aspnetroles` */

DROP TABLE IF EXISTS `aspnetroles`;

CREATE TABLE `aspnetroles` (
  `Id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NormalizedName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ConcurrencyStamp` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `aspnetroles` */

insert  into `aspnetroles`(`Id`,`Name`,`NormalizedName`,`ConcurrencyStamp`) values 
('3aca9f88-3a91-484a-9c23-d140037d503c','f6Kk5PFjmKIOF5kjgfiRXi2rZWrNhKpPPS2KCqzDE78=','F6KK5PFJMKIOF5KJGFIRXI2RZWRNHKPPPS2KCQZDE78=','1328dee4-2415-40ca-a044-e5431c35f452'),
('ebfdb49e-15dc-41c4-b5dd-7983002941d9','vssQFOBH2Oi1cnNULlE/ShttO3SIE1rSnQzKet++FTU=','VSSQFOBH2OI1CNNULLE/SHTTO3SIE1RSNQZKET++FTU=','d5f97b84-618f-4723-91af-38da0481d061'),
('eed4c4d3-3f26-4653-9d5f-b8a7fd4ebdec','hLNKRZ0S2LVT+XIHhMz9FmFubj42XIVAU0x8zEVwJtY=','HLNKRZ0S2LVT+XIHHMZ9FMFUBJ42XIVAU0X8ZEVWJTY=','0913980b-2d44-42ce-80a1-138d91fa86f6');

/*Table structure for table `aspnetuserclaims` */

DROP TABLE IF EXISTS `aspnetuserclaims`;

CREATE TABLE `aspnetuserclaims` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ClaimType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ClaimValue` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetUserClaims_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `aspnetuserclaims` */

/*Table structure for table `aspnetuserlogins` */

DROP TABLE IF EXISTS `aspnetuserlogins`;

CREATE TABLE `aspnetuserlogins` (
  `LoginProvider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProviderKey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProviderDisplayName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`),
  KEY `IX_AspNetUserLogins_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `aspnetuserlogins` */

/*Table structure for table `aspnetuserroles` */

DROP TABLE IF EXISTS `aspnetuserroles`;

CREATE TABLE `aspnetuserroles` (
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `RoleId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_AspNetUserRoles_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `aspnetuserroles` */

insert  into `aspnetuserroles`(`UserId`,`RoleId`) values 
('9707e7d6-d4f3-4fc8-adbd-4b07f75537ce','3aca9f88-3a91-484a-9c23-d140037d503c'),
('dc5c55bc-fe03-4f36-82dc-9530267f2391','3aca9f88-3a91-484a-9c23-d140037d503c'),
('8d041b26-f201-4c04-b170-9aa544fd7bbd','ebfdb49e-15dc-41c4-b5dd-7983002941d9'),
('a4650d10-8f48-42e2-a4e3-370bbdb74371','ebfdb49e-15dc-41c4-b5dd-7983002941d9'),
('d870f273-3380-47ed-a0ec-c5cabf960270','eed4c4d3-3f26-4653-9d5f-b8a7fd4ebdec');

/*Table structure for table `aspnetusers` */

DROP TABLE IF EXISTS `aspnetusers`;

CREATE TABLE `aspnetusers` (
  `Id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UserName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NormalizedUserName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Email` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NormalizedEmail` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `EmailConfirmed` tinyint(1) NOT NULL,
  `PasswordHash` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `SecurityStamp` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ConcurrencyStamp` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `PhoneNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL,
  `TwoFactorEnabled` tinyint(1) NOT NULL,
  `LockoutEnd` datetime(6) DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL,
  `AccessFailedCount` int NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  KEY `EmailIndex` (`NormalizedEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `aspnetusers` */

insert  into `aspnetusers`(`Id`,`UserName`,`NormalizedUserName`,`Email`,`NormalizedEmail`,`EmailConfirmed`,`PasswordHash`,`SecurityStamp`,`ConcurrencyStamp`,`PhoneNumber`,`PhoneNumberConfirmed`,`TwoFactorEnabled`,`LockoutEnd`,`LockoutEnabled`,`AccessFailedCount`) values 
('8d041b26-f201-4c04-b170-9aa544fd7bbd','01724589637','01724589637','shop.admin@pos.com','SHOP.ADMIN@POS.COM',0,'AQAAAAEAACcQAAAAEMWFAj/Oq1AHuQoG+Yge3d83f1O/l3iv/+BbmJJVUTQ9lk8vRaBjUNXUhibD90uUeg==','W23LLURLPJYGRV2CV6XD6Y6HOONPAZ77','a07a0508-6907-403d-8860-9c635bdbac1b','01724589637',0,0,NULL,1,0),
('9707e7d6-d4f3-4fc8-adbd-4b07f75537ce','04579624228','04579624228','zalam@gmail.com','ZALAM@GMAIL.COM',0,'AQAAAAEAACcQAAAAEMoASKV2Ozl/GJM5McIZQYQbK0mi+I6hH5NZU1RM9jqrnKoMQbBzo8og77Jzl/Ru1g==','5VOAVJTZKYE7YJHCS3YIGW4LSDEFIWYU','b4499ef3-592f-48de-a46a-1dc5229a84a8','04579624228',0,0,NULL,1,0),
('a4650d10-8f48-42e2-a4e3-370bbdb74371','02154963541','02154963541','admin@miba.com','ADMIN@MIBA.COM',0,'AQAAAAEAACcQAAAAEMUEs51LXFO1Y5ykMqImB4cuICldPXMLwbuB+PFAAt5jPmL0bd193RPVwUArgcA0QQ==','F6HGWDZJWDSDJFCGVCBLAF4WVE5WDMOI','49f51211-e0cf-4a69-bbbc-44d66bf17e29','02154963541',0,0,NULL,1,0),
('d870f273-3380-47ed-a0ec-c5cabf960270','sysadmin','SYSADMIN','pos.admin@nice.com','POS.ADMIN@NICE.COM',0,'AQAAAAEAACcQAAAAELgqs7A7duLRj92rrQs1t1KxKguCILwkBHQQg2zOnJa0Sq41OqJug1u/rNvRhfwM3g==','TKKW2IEJZDEUDJNM5HSRT2N3GIK4FJOF','f0622752-d62c-4b6e-bd11-cff71655d789','01111111111',0,0,NULL,1,0),
('dc5c55bc-fe03-4f36-82dc-9530267f2391','01758956324','01758956324','ikna@gmail.com','IKNA@GMAIL.COM',0,'AQAAAAEAACcQAAAAEJZWa0x0tLPwy2GHTZZraqDLpCTDnLk0ucNjdIPwerT8MP/oSCxEgHRmhYFthZWLyw==','IHNPP3S7GUO2K4SNOQWNEHPOJZGZRX5N','23ffbbde-68a0-4080-95cf-8d86873e870a','01758956324',0,0,NULL,1,0);

/*Table structure for table `aspnetusertokens` */

DROP TABLE IF EXISTS `aspnetusertokens`;

CREATE TABLE `aspnetusertokens` (
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `LoginProvider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`UserId`,`LoginProvider`,`Name`),
  CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `aspnetusertokens` */

/*Table structure for table `bank_branches` */

DROP TABLE IF EXISTS `bank_branches`;

CREATE TABLE `bank_branches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_code` varchar(500) DEFAULT NULL,
  `branch_Name` varchar(500) DEFAULT NULL,
  `branch_address` varchar(1000) DEFAULT NULL,
  `branch_location` varchar(500) DEFAULT NULL,
  `bank_id` varchar(50) DEFAULT NULL,
  `account_no` varchar(50) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bank_branches` */

/*Table structure for table `bank_info` */

DROP TABLE IF EXISTS `bank_info`;

CREATE TABLE `bank_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bank_code` varchar(20) DEFAULT NULL,
  `bank_name` varchar(200) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bank_info` */

/*Table structure for table `category_info` */

DROP TABLE IF EXISTS `category_info`;

CREATE TABLE `category_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  `trade_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

/*Data for the table `category_info` */

insert  into `category_info`(`id`,`code`,`name`,`description`,`client_code`,`trade_code`) values 
(1,'0001','BREAD & BAKERY','sandwich loaves, dinner rolls, tortillas, bagels','01','0101'),
(2,'0002','MEAT & SEAFOOD','Meat, poultry, beef, fish, shrimp, crabs, Seafood','01','0101'),
(3,'0003','OILS, SAUCES & CONDIMENTS','Related','01','0101'),
(4,'0004','RICE, LENTIL & DRIED LEGUMES ','N/A','01','0101'),
(5,'0005','TIN CANNED/JARRED GOODS','N/A','01','0101'),
(6,'0006','DAIRY & FARM PRODUCTS','cheeses, eggs, milk, yogurt, butter','01','0101'),
(7,'0007','PRODUCES',' fruits, vegetables','01','0101'),
(8,'0008','FROZEN FOODS','N/A','01','0101'),
(9,'0009','CONFECTIONARY','Candy, Chocolate, Cake, Sweets','01','0101'),
(10,'0010','BEVERAGES','coffee/tea, juice, soda','01','0101'),
(11,'0011','DRY/BAKING GOODS','cereals, flour, sugar, pasta, mixes, noodles','01','0101'),
(12,'0012','CLEANERS','all- purpose, laundry detergent, dishwashing liquid/detergent','01','0101'),
(13,'0013','PAPER GOODS','paper towels, toilet paper, aluminum foil, sandwich bags','01','0101'),
(14,'0014','PERSONAL CARE & TOILETRIES','shampoo, soap, hand soap, shaving cream','01','0101'),
(15,'0015','OTHER','baby items, pet items, batteries, greeting cards','01','0101'),
(16,'0016','PHARMACY','N/A','01','0101'),
(18,'0018','CROCKERIES','China Ceramics, Glass, Teflons, Plastics Type Kitchen Accessories','01','0101'),
(19,'0019','GIFT ITEMS','Nick Nacks','01','0101'),
(20,'0020','ELECTRONICS','Microwave oven, Electric Iron and others','01','0101'),
(29,'0029','ARTS AND CRAFTS','N/A','01','0101'),
(30,'0030','STATIONERY','N/A','01','0101'),
(31,'0031','INSTANT PRODUCTS','Powder','01','0101'),
(32,'0032','CHIPS AND PACKAGED PRODUCTS','N/A','01','0101');

/*Table structure for table `client` */

DROP TABLE IF EXISTS `client`;

CREATE TABLE `client` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `division` varchar(50) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `thana` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `zipcode` varchar(50) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `client` */

insert  into `client`(`id`,`name`,`code`,`description`,`phone`,`address`,`division`,`district`,`thana`,`email`,`zipcode`,`logo`) values 
(1,'Nice Bazaar','01','chowhatta nojaor bely','548825417','Uttam BIr Ls','SYLHET','HABIGANJ','AJMIRIGANJ','admin@miba.com','5478','/images/client/01/logo/01.png');

/*Table structure for table `counter_info` */

DROP TABLE IF EXISTS `counter_info`;

CREATE TABLE `counter_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `counter_code` varchar(100) DEFAULT NULL,
  `counter_name` varchar(100) DEFAULT NULL,
  `counter_location` varchar(100) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `counter_info` */

/*Table structure for table `customers_info` */

DROP TABLE IF EXISTS `customers_info`;

CREATE TABLE `customers_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `loyalty_point` double(10,2) DEFAULT '0.00',
  `address` varchar(500) DEFAULT NULL,
  `division` varchar(50) DEFAULT NULL,
  `district` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `thana` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `customer_type` tinyint(1) DEFAULT '1',
  `remarks` varchar(50) DEFAULT NULL,
  `entry_date` date DEFAULT '0001-01-01',
  `entry_by` varchar(50) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  `trade_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `customers_info` */

/*Table structure for table `ledger_detail` */

DROP TABLE IF EXISTS `ledger_detail`;

CREATE TABLE `ledger_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_type` varchar(50) DEFAULT NULL,
  `transaction_id` varchar(50) DEFAULT NULL,
  `account_head_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `account_head_id` varchar(50) DEFAULT NULL,
  `invoice` varchar(30) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `customer_name` varchar(100) DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  `customer_code` varchar(50) DEFAULT NULL,
  `supplier_code` varchar(50) DEFAULT NULL,
  `cr_discount_percent` double(10,2) DEFAULT '0.00',
  `cr_discount` double(10,2) DEFAULT '0.00',
  `cr_amount` double(10,2) DEFAULT '0.00',
  `cr_total` double(10,2) DEFAULT '0.00',
  `dr_discount_percent` double(10,2) DEFAULT '0.00',
  `dr_discount` double(10,2) DEFAULT '0.00',
  `dr_amount` double(10,2) DEFAULT '0.00',
  `dr_total` double(10,2) DEFAULT '0.00',
  `user_id` varchar(100) DEFAULT NULL,
  `client_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `entry_time` datetime DEFAULT '1000-01-01 10:55:24',
  `trade_code` varchar(50) DEFAULT NULL,
  `trx_info` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ledger_detail` */

/*Table structure for table `manufacturers_info` */

DROP TABLE IF EXISTS `manufacturers_info`;

CREATE TABLE `manufacturers_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `contact_person` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `comments` varchar(50) DEFAULT NULL,
  `entry_date` date DEFAULT '0000-00-00',
  `entry_by` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `client_code` varchar(50) DEFAULT NULL,
  `trade_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `manufacturers_info` */

insert  into `manufacturers_info`(`id`,`code`,`name`,`address`,`contact_person`,`email`,`phone`,`brand`,`comments`,`entry_date`,`entry_by`,`status`,`client_code`,`trade_code`) values 
(1,'MAN00001','TRANSCOM BEVERAGES LTD. (TBL)','FACTORY ADDRESS: KALIAKOIR, GAZIPUR, BANGLADESH.\nHEAD OFFICE CONTACT:\nPLOT# 31, ROAD# 53, GULSHAN NORTH C.A, GULSHAN-2, DHAKA-1212','TRANSCOM BEVERAGES LTD. (TBL)','test@email.com','38754683','TRANSCOM BEVERAGES LTD. (TBL)','No Comments','2021-01-26','ADMIN',1,'01','0101'),
(2,'MAN00002','SQUARE FOOD & BEVERAGE LTD. (SFBL)','SQUARE CENTRE (6TH FLOOR), 48, MOHAKHALI CA, DHAKA-1212, BANGLADESH.\nPHONE: 88-02-8833047-56 [TEN LINES] | FAX: 88-02-8835394','TIEN ANMEN','djxs362@gmail.com','8802883304756','SQUARE FOOD & BEVERAGE LTD. (SFBL)','op','2021-01-26','ADMIN',1,'01','0101'),
(3,'MAN00003','AKIJ FOOD AND BEVERAGE LTD. (AFBL)','AKIJ HOUSE, 198 BIR UTTAM, MIR SHAWKAT SARAK, GULSHAN LINK ROAD, TEJGAON, DHAKA-1208','AKIJ FOOD AND BEVERAGE LTD. (AFBL)','info@akij.net','8809613116609','AKIJ FOOD AND BEVERAGE LTD. (AFBL)','No Comments','2021-01-26','ADMIN',1,'01','0101'),
(4,'MAN00004','PARTEX BEVERAGE LTD.','74 BIR UTTAM A.K. KHANDAKER SARAK,\nMOHAKHALI, DHAKA – 1212, BANGLADESH\nPHONE: +880 2 8822888 | FAX: +880 2 8821888 | E-MAIL: MAILBOX@PARTEX.NET','TIEN ANMEN','t@m.com','01719590478','PARTEX BEVERAGE LTD.','op','2021-01-26','ADMIN',1,'01','0101'),
(5,'MAN00005','PRAN FOODS LTD.','105, PROGOTI SARANI MIDDLE BADDA, DHAKA 1212, BANGLADESH.\nPHONE: 09613-737777','PRAN FOODS LTD.','neroalam@gmail.com','01719590478','PRAN FOODS LTD.','op','2021-01-26','ADMIN',1,'01','0101'),
(6,'MAN00006','ACI FOODS LTD.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','ACI FOODS LTD.','t@m.com','04579624228','ACI FOODS LTD.','op','2021-01-26','ADMIN',1,'01','0101'),
(7,'MAN00007','IFAD MULTI PRODUCTS LTD.','NASIR TRADE CENTER NASIR TRADE CENTER,\n89 BIR UTTAM, CR DUTTA ROAD. DHAKA 1205.\nEMAIL: IMPL@IFADGROUP.COM | PHONE: +01980002134','IFAD MULTI PRODUCTS LTD.','t@m.com','01719590478','IFAD MULTI PRODUCTS LTD.','op','2021-01-26','ADMIN',1,'01','0101'),
(8,'MAN00008','FU-WANG FOODS LTD.','HOUSE: 55, ROAD: 17, BANANI C/A, DHAKA-1213\nTEL: 58815476, 9887359, 9887360,9889958,9889864\nFAX: 880-02-9847451 | E-MAIL: INFO@FUWANGFOODSLTD.COM','FU-WANG FOODS LTD.','t@m.com','04579624228','FU-WANG FOODS LTD.','op','2021-01-26','ADMIN',1,'01','0101'),
(9,'MAN00009','ISPAHANI FOODS LTD.','THE ALLIANCE BUILDING (3RD FLOOR)\n63/KA, PRAGATI SHARANI, BARIDHARA, DHAKA-1212, BANGLADESH.\nPHONE : +88 02 55048375, +88 01755644002','ISPAHANI FOODS LTD.','lobotobo@gmail.com','01247854698','ISPAHANI FOODS LTD.','op','2021-01-26','ADMIN',1,'01','0101'),
(10,'MAN00010','BOMBAY SWEETS & CO. LTD.','DELTA LIFE TOWER(8TH FLOOR),\n37, GULSHAN NORTH C/A, ROAD NO#90, GULSHAN -2, DHAKA-1213, BANGLADESH.\nPHONE : 9893800-1, 9896800, 9897100| FAX : 880-2-9893077, 8814780','BOMBAY SWEETS & CO. LTD.','t@m.com','9896800','BOMBAY SWEETS & CO. LTD.','op','2021-02-09','ADMIN',1,'01','0101'),
(11,'MAN00011','UNILEVER INC.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','UNILEVER INC.','Unlilever@uni.com','01247854698','UNILEVER INC.','op','2021-01-26','ADMIN',1,'01','0101'),
(12,'MAN00012','NESTLE FOODS LTD.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','NESTLE FOODS LTD.','lobotobo@gmail.com','6549651986','NESTLE FOODS LTD.','op','2021-01-26','ADMIN',1,'01','0101'),
(13,'MAN00013','SAJEEB GROUP OF COMPANIES','SHEZAN POINT (LEVEL 6), 2 INDIRA ROAD, FARMGATE, DHAKA 1215, BANGLADESH','ISLAM AMAN','info@sajeebgroup.com.bd','88029116944','SAJEEB GROUP OF COMPANIES','op','2021-02-10','ADMIN',1,'01','0101'),
(14,'MAN00014','BOMBAY SWEETS & CO. LTD.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','BABU BOMBAY','BBAY@KU.com','0254687445','BOMBAY SWEETS & CO. LTD.','56 BIHAR','2021-02-11','ADMIN',1,'01','0101'),
(15,'MAN00015','OTHERS','OTHERS','OTHERS','Others@gmail.com','0000000','OTHERS','Others','2021-02-11','ADMIN',1,'01','0101');

/*Table structure for table `pos_log` */

DROP TABLE IF EXISTS `pos_log`;

CREATE TABLE `pos_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `supplier_code` varchar(50) DEFAULT NULL,
  `customer_code` varchar(50) DEFAULT NULL,
  `manufacturer_code` varchar(50) DEFAULT NULL,
  `category_code` varchar(50) DEFAULT NULL,
  `product_code` varchar(50) DEFAULT NULL,
  `invoice_no` varchar(50) DEFAULT NULL,
  `transaction_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  `trade_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `pos_log` */

insert  into `pos_log`(`id`,`supplier_code`,`customer_code`,`manufacturer_code`,`category_code`,`product_code`,`invoice_no`,`transaction_id`,`client_code`,`trade_code`) values 
(1,'SUP00009',NULL,'MAN00015','0032','00040037','0101000000005','0101000000001','01','0101'),
(14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'01','0102'),
(15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'01','0103'),
(16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'01','0104');

/*Table structure for table `product_event_info` */

DROP TABLE IF EXISTS `product_event_info`;

CREATE TABLE `product_event_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(50) DEFAULT NULL,
  `transaction_type` varchar(50) DEFAULT NULL,
  `invoice` varchar(30) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `customer_name` varchar(100) DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  `customer_code` varchar(50) DEFAULT NULL,
  `supplier_code` varchar(50) DEFAULT NULL,
  `cr_discount_percent` double(10,2) DEFAULT '0.00',
  `cr_discount` double(10,2) DEFAULT '0.00',
  `cr_amount` double(10,2) DEFAULT '0.00',
  `cr_total` double(10,2) DEFAULT '0.00',
  `dr_discount_percent` double(10,2) DEFAULT '0.00',
  `dr_discount` double(10,2) DEFAULT '0.00',
  `dr_amount` double(10,2) DEFAULT '0.00',
  `dr_total` double(10,2) DEFAULT '0.00',
  `user_id` varchar(100) DEFAULT NULL,
  `client_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `entry_time` datetime DEFAULT '1000-01-01 10:55:24',
  `trade_code` varchar(50) DEFAULT NULL,
  `trx_info` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

/*Data for the table `product_event_info` */

insert  into `product_event_info`(`id`,`transaction_id`,`transaction_type`,`invoice`,`entry_date`,`customer_name`,`supplier_name`,`customer_code`,`supplier_code`,`cr_discount_percent`,`cr_discount`,`cr_amount`,`cr_total`,`dr_discount_percent`,`dr_discount`,`dr_amount`,`dr_total`,`user_id`,`client_code`,`entry_time`,`trade_code`,`trx_info`) values 
(1,'IPZ5GIREICDN','PURCHASE','INV0221M9MLGQ1','2021-02-24',NULL,'MD. SHAHIDUZZAMAN',NULL,'SUP00001',0.00,0.00,0.00,0.00,0.00,200.00,114100.00,113900.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','0001-01-01 00:00:00','0101',NULL),
(2,'DFD8S0H54I7G','SALE','INV02219C6KLWZ','2021-02-24',NULL,NULL,NULL,NULL,0.00,100.00,1520.00,1420.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-02-24 11:43:16','0101',NULL),
(3,'D9Z8CAUXTG8K','SALE','INV0221MFYB242','2021-02-24',NULL,NULL,NULL,NULL,0.00,10.00,260.00,250.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-02-24 11:47:32','0101',NULL),
(4,'OHXFK97FFZRZ','SALE','INV0221XZHHM9L','2021-02-24',NULL,NULL,NULL,NULL,0.00,10.00,520.00,510.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-02-24 12:09:40','0101',NULL),
(5,'6Q7JAG79P5HN','SALE','INV0221PPDFGRS','2021-02-24',NULL,NULL,NULL,NULL,0.00,10.00,260.00,250.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-02-24 12:28:07','0101',NULL),
(6,'XEYDUKLJ2CVO','SALE','INV0221UGWBKVD','2021-02-24',NULL,NULL,NULL,NULL,0.00,15.00,3990.00,3975.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-02-24 14:59:57','0101',NULL),
(7,'JVSFT0IOFOSU','SALE','2102IGWNI7D','2021-02-24',NULL,NULL,NULL,NULL,0.00,0.00,13000.00,13000.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-02-24 16:02:39','0101',NULL),
(8,'LXKHV6F0YRWV','PURCHASE','21023HTEVXQ','2021-02-24',NULL,'MD. MIZANUR RAHMAN',NULL,'SUP00005',0.00,0.00,0.00,0.00,0.00,170.00,25170.00,25000.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','0001-01-01 00:00:00','0101',NULL),
(9,'5DNCR5X7OQJX','SALE','21027HIMAKK','2021-02-24',NULL,NULL,NULL,NULL,0.00,0.00,300.00,300.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-02-24 16:52:04','0101',NULL),
(10,'Z5KASYH37L8E','PURCHASE','2102BH37ODK','2021-02-24',NULL,'MD. MIZANUR RAHMAN',NULL,'SUP00005',0.00,0.00,0.00,0.00,0.00,2000.00,55000.00,53000.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','0001-01-01 00:00:00','0101',NULL),
(11,'MD4R5BFR8W4W','SALE','2102NOXQX4H','2021-02-27',NULL,NULL,NULL,NULL,0.00,10.00,1110.00,1100.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-02-27 10:15:52','0101',NULL),
(15,'QCH70HGV2R4E','SALE','2102WF5P487','2021-02-27',NULL,NULL,NULL,NULL,0.00,0.00,330.00,330.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-02-27 15:02:29','0101',NULL),
(16,'QCH70HGV2R4E','CASH','2102WF5P487','2021-02-27',NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,0.00,0.00,330.00,330.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-02-27 15:02:29','0101',NULL),
(18,'ND30B8UI4RIM','PURCHASE','21027N34BC2','2021-02-27',NULL,'MD. ATIAR RAHMAN ',NULL,'SUP00004',0.00,0.00,0.00,0.00,0.00,0.00,15600.00,15600.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','0001-01-01 00:00:00','0101',NULL),
(19,'ND30B8UI4RIM','CASH','21027N34BC2','2021-02-27',NULL,'MD. ATIAR RAHMAN ',NULL,'SUP00004',0.00,0.00,15600.00,15600.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','0001-01-01 00:00:00','0101',NULL),
(20,'I3J2I2UFWS46','CASH','2102H663KQT','2021-02-27',NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,0.00,30.00,6605.00,6575.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-02-27 16:33:29','0101',NULL),
(21,'I3J2I2UFWS46','SALE','2102H663KQT','2021-02-27',NULL,NULL,NULL,NULL,0.00,30.00,6605.00,6575.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-02-27 16:33:29','0101',NULL),
(22,'42VWRGSO2IF2','SALE','2103YAFLIMJ','2021-03-01',NULL,NULL,NULL,NULL,10.00,218.60,2186.00,1967.40,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-03-01 14:49:47','0101',NULL),
(23,'42VWRGSO2IF2','CASH','2103YAFLIMJ','2021-03-01',NULL,NULL,NULL,NULL,10.00,0.00,0.00,0.00,10.00,218.60,2186.00,1967.40,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-03-01 14:49:47','0101',NULL),
(24,'2CNLBMJ9WN3A','SALE','2103K7BEI2X','2021-03-02',NULL,NULL,NULL,NULL,0.00,0.00,1600.00,1600.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-03-02 10:33:35','0101',NULL),
(25,'2CNLBMJ9WN3A','CASH','2103K7BEI2X','2021-03-02',NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,0.00,0.00,1600.00,1600.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-03-02 10:33:35','0101',NULL),
(26,'MRVWWTXFITPU','SALE','2103C7VOIED','2021-03-02',NULL,NULL,NULL,NULL,5.00,42.06,841.20,799.14,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-03-02 10:48:09','0101',NULL),
(27,'MRVWWTXFITPU','CASH','2103C7VOIED','2021-03-02',NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,5.00,42.06,841.20,799.14,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-03-02 10:48:09','0101',NULL),
(28,'H5S5WHQ6987K','PURCHASE','2103GPBXHDA','2021-03-02',NULL,'REZAUL AZAM FARUQUI',NULL,'SUP00009',0.00,0.00,0.00,0.00,15.00,2250.00,15000.00,12750.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','0001-01-01 00:00:00','0101',NULL),
(29,'H5S5WHQ6987K','BANK','2103GPBXHDA','2021-03-02',NULL,'REZAUL AZAM FARUQUI',NULL,'SUP00009',15.00,2250.00,15000.00,0.00,15.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','0001-01-01 00:00:00','0101',NULL),
(30,'6OKTK3YJRO1V','PURCHASE','0101000000001','2021-03-13',NULL,'MD. MIZANUR RAHMAN',NULL,'SUP00005',0.00,0.00,0.00,0.00,0.47,40.00,8460.00,8420.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','0001-01-01 00:00:00','0101',NULL),
(31,'6OKTK3YJRO1V','CASH','0101000000001','2021-03-13',NULL,'MD. MIZANUR RAHMAN',NULL,'SUP00005',0.47,40.00,8460.00,0.00,0.47,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','0001-01-01 00:00:00','0101',NULL),
(32,'0CNE1QHPV6KM','SALE','0101000000002','2021-03-13',NULL,NULL,NULL,NULL,0.24,35.00,14535.00,14500.00,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-03-13 15:00:43','0101',NULL),
(33,'0CNE1QHPV6KM','CASH','0101000000002','2021-03-13',NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,0.24,35.00,14535.00,14500.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-03-13 15:00:43','0101',NULL),
(34,'MIF03AR2FU8N','PURCHASE','0101000000003','2021-03-13',NULL,'MUHAMMAD MASUM BILLAH',NULL,'SUP00006',0.00,0.00,0.00,0.00,0.77,80.00,10380.00,10300.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','0001-01-01 00:00:00','0101',NULL),
(35,'MIF03AR2FU8N','BANK','0101000000003','2021-03-13',NULL,'MUHAMMAD MASUM BILLAH',NULL,'SUP00006',0.77,80.00,10380.00,0.00,0.77,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','0001-01-01 00:00:00','0101',NULL),
(36,'2P86UG0SYPFA','SALE','0101000000004','2021-03-13',NULL,NULL,NULL,NULL,5.00,21.80,436.00,414.20,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-03-13 15:23:48','0101',NULL),
(37,'2P86UG0SYPFA','CASH','0101000000004','2021-03-13',NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,5.00,21.80,436.00,414.20,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-03-13 15:23:48','0101',NULL),
(38,'G9850NDLIKSQ','SALE','0101000000005','2021-03-13',NULL,NULL,NULL,NULL,5.00,54.66,1093.25,1038.59,0.00,0.00,0.00,0.00,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-03-13 16:27:39','0101',NULL),
(39,'G9850NDLIKSQ','CASH','0101000000005','2021-03-13',NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,5.00,54.66,1093.25,1038.59,'a4650d10-8f48-42e2-a4e3-370bbdb74371','01','2021-03-13 16:27:39','0101',NULL);

/*Table structure for table `product_info` */

DROP TABLE IF EXISTS `product_info`;

CREATE TABLE `product_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_code` varchar(50) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `product_type` varchar(50) DEFAULT NULL,
  `product_unit` varchar(50) DEFAULT NULL,
  `quantity_in` double(10,2) DEFAULT '0.00',
  `quantity_out` double(10,2) DEFAULT '0.00',
  `quantity` double(10,2) DEFAULT '0.00',
  `unit_price` double(10,2) DEFAULT '0.00',
  `mrp_price` double(10,2) DEFAULT '0.00',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `reorder_level` double(10,2) DEFAULT '0.00',
  `subcategory` varchar(50) DEFAULT NULL,
  `subcategory_code` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `category_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `manufacturer_code` varchar(50) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `batch` varchar(50) DEFAULT NULL,
  `entry_by` varchar(100) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  `barcode` varchar(100) DEFAULT NULL,
  `last_expire_date` date DEFAULT '1000-01-01',
  `trade_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `product_info` */

insert  into `product_info`(`id`,`product_code`,`product_name`,`product_type`,`product_unit`,`quantity_in`,`quantity_out`,`quantity`,`unit_price`,`mrp_price`,`description`,`reorder_level`,`subcategory`,`subcategory_code`,`category`,`category_code`,`status`,`manufacturer_code`,`manufacturer`,`batch`,`entry_by`,`client_code`,`barcode`,`last_expire_date`,`trade_code`) values 
(1,'00010022','PRAN SALTY SALTED BISCUIT 100 GM',NULL,'Pc',134.00,12.00,122.00,60.00,59.00,'N/A',20.00,'BISCUITS','000108','BREAD & BAKERY','0001',1,'MAN00005','PRAN FOODS LTD.',NULL,NULL,'01','00010022','2021-10-23','0101'),
(2,'00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM',NULL,'Pc',100.00,32.00,68.00,96.00,120.00,'N/A',15.00,'BISCUITS','000108','BREAD & BAKERY','0001',1,'MAN00013','SAJEEB GROUP OF COMPANIES',NULL,NULL,'01','00010023','2021-03-30','0101'),
(3,'00080024','MARKS FULL CREAM MILK POWDER 1000 GM TIN',NULL,'Pc',224.00,1.00,223.00,60.00,100.00,'N/A',15.00,NULL,NULL,'FROZEN FOODS','0008',1,'MAN00012','NESTLE FOODS LTD.',NULL,NULL,'01','00080024','2021-04-01','0101'),
(4,'00080025','KAZI FARMS PARATHA 10PCS 650 GM',NULL,'Pc',20.00,13.00,7.00,80.00,100.00,'N/A',90.00,'FROZEN FOOD','000802','FROZEN FOODS','0008',1,'MAN00007','IFAD MULTI PRODUCTS LTD.',NULL,NULL,'01','00080025','2021-02-28','0101'),
(5,'00300026','ZINIX METAL PERMANENT MARKER MP501',NULL,'Pc',0.00,0.00,0.00,20.00,35.00,'N/A',50.00,'PEN','003001','STATIONERY','0030',1,'MAN00015','OTHERS',NULL,NULL,'01','00300026','0001-01-01','0101'),
(6,'00070027','POTATO 10KG PACKET',NULL,'Pc',379.00,129.00,250.00,250.00,260.00,'N/A',50.00,'POTATOES','000704','PRODUCES','0007',1,'MAN00015','OTHERS',NULL,NULL,'01','00070027','2021-02-28','0101'),
(7,'00030028','PRAN TOMATO SAUCE',NULL,'Pc',320.00,5.00,315.00,80.00,90.00,'N/A',80.00,'SAUCES','000302','OILS, SAUCES & CONDIMENTS','0003',1,'MAN00005','PRAN FOODS LTD.',NULL,NULL,'01','00030028','2021-03-13','0101'),
(8,'00030029','PRAN SOYA SAUCE',NULL,'Pc',0.00,0.00,0.00,110.00,130.00,'N/A',50.00,'OILS','000301','OILS, SAUCES & CONDIMENTS','0003',1,'MAN00005','PRAN FOODS LTD.',NULL,NULL,'01','00030029','2021-02-28','0101'),
(9,'00110030','IFAD NOODLES',NULL,'Pc',96.00,72.00,24.00,30.00,35.00,'N/A',50.00,'NOODLES','001107','DRY/BAKING GOODS','0011',1,'MAN00007','IFAD MULTI PRODUCTS LTD.',NULL,NULL,'01','00110030','2021-02-28','0101'),
(10,'00040031','CHASHI RICE (50 KGS)',NULL,'Pc',0.00,0.00,0.00,1800.00,1950.00,'N/A',20.00,'RICE','000401','RICE, LENTIL & DRIED LEGUMES ','0004',1,'MAN00007','IFAD MULTI PRODUCTS LTD.',NULL,NULL,'01','00040031','2021-02-28','0101'),
(11,'00090032','CADBURY DAIRY MILK SILK CHOCOLATE 60±5 GM*',NULL,'Pc',106.00,16.00,90.00,60.00,65.00,'N/A',50.00,'CHOCOLATES','000902','CONFECTIONARY','0009',1,'MAN00012','NESTLE FOODS LTD.',NULL,NULL,'01','00090032','2021-03-31','0101'),
(12,'00090033','FOXS CRYSTAL CLEAR PASSIAR MINTS 180G',NULL,'Pc',56.00,7.00,49.00,250.00,280.00,'N/A',50.00,'CANDY','000901','CONFECTIONARY','0009',1,'MAN00015','OTHERS',NULL,NULL,'01','00090033','2021-02-28','0101'),
(13,'00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS',NULL,'Pc',226.00,4.00,222.00,60.00,76.00,'N/A',50.00,'BABY ITEMS','001501','OTHER','0015',1,'MAN00015','OTHERS',NULL,NULL,'01','00150034','2021-04-30','0101'),
(14,'00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER',NULL,'Pc',100.00,47.00,53.00,180.00,200.00,'N/A',50.00,'SHAMPOO','001401','PERSONAL CARE & TOILETRIES','0014',1,'MAN00015','OTHERS',NULL,NULL,'01','00140035','2021-02-28','0101'),
(15,'6971141390616','PLEXTONE BLACK MOWI',NULL,'Pc',58.00,4.00,54.00,700.00,850.00,'N/A',20.00,'HAIR DRYER','002003','ELECTRONICS','0020',1,'MAN00015','OTHERS',NULL,NULL,'01','6971141390616','0001-01-01','0101'),
(16,'00040037','RICE 10 KG',NULL,'Pc',0.00,0.00,0.00,60.00,65.00,'N/A',500.00,'LENTIL','000402','RICE, LENTIL & DRIED LEGUMES ','0004',1,'MAN00015','OTHERS',NULL,NULL,'01','00040037','0001-01-01','0101');

/*Table structure for table `product_stock` */

DROP TABLE IF EXISTS `product_stock`;

CREATE TABLE `product_stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `manufacturer_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `opening_stock` double(10,2) DEFAULT '0.00',
  `quantity_in` double(10,2) DEFAULT '0.00',
  `quantity_out` double(10,2) DEFAULT '0.00',
  `closing_stock` double(10,2) DEFAULT '0.00',
  `unit_price` double(10,2) DEFAULT '0.00',
  `mrp_price` double(10,2) DEFAULT '0.00',
  `expire_date` date DEFAULT '1000-01-01',
  `entry_date` date DEFAULT '1000-01-01',
  `user_id` varchar(100) DEFAULT NULL,
  `batch_no` varchar(100) DEFAULT NULL,
  `client_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `barcode` varchar(100) DEFAULT NULL,
  `trade_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

/*Data for the table `product_stock` */

insert  into `product_stock`(`id`,`product_code`,`product_name`,`manufacturer_code`,`opening_stock`,`quantity_in`,`quantity_out`,`closing_stock`,`unit_price`,`mrp_price`,`expire_date`,`entry_date`,`user_id`,`batch_no`,`client_code`,`barcode`,`trade_code`) values 
(1,'00070027','POTATO 10KG PACKET','MAN00015',0.00,369.00,74.00,295.00,250.00,260.00,'2021-02-28','2021-02-24','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(2,'00030028','PRAN TOMATO SAUCE','MAN00005',0.00,320.00,1.00,319.00,80.00,90.00,'0001-01-01','2021-02-24','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00030028','0101'),
(3,'00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',0.00,100.00,3.00,97.00,135.00,200.00,'0001-01-01','2021-02-24','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010022','0101'),
(4,'00090032','CADBURY DAIRY MILK SILK CHOCOLATE 60±5 GM*','MAN00012',0.00,56.00,1.00,55.00,90.00,100.00,'0001-01-01','2021-02-24','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00090032','0101'),
(5,'00110030','IFAD NOODLES','MAN00007',0.00,96.00,0.00,96.00,30.00,35.00,'2021-02-28','2021-02-24','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00110030','0101'),
(6,'6971141390616','PLEXTONE BLACK MOWI','MAN00015',0.00,58.00,0.00,58.00,700.00,850.00,'0001-01-01','2021-02-24','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','6971141390616','0101'),
(7,'00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER','MAN00015',0.00,80.00,0.00,80.00,180.00,200.00,'0001-01-01','2021-02-24','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00140035','0101'),
(8,'00070027','POTATO 10KG PACKET','MAN00015',295.00,10.00,51.00,254.00,250.00,260.00,'0001-01-01','2021-02-27','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(9,'6971141390616','PLEXTONE BLACK MOWI','MAN00015',58.00,0.00,4.00,54.00,700.00,850.00,'0001-01-01','2021-02-27','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','6971141390616','0101'),
(10,'00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',0.00,50.00,2.00,48.00,300.00,330.00,'0001-01-01','2021-02-27','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010023','0101'),
(11,'00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS','MAN00015',0.00,50.00,3.00,47.00,700.00,895.00,'0001-01-01','2021-02-27','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00150034','0101'),
(12,'00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER','MAN00015',0.00,20.00,2.00,18.00,180.00,200.00,'0001-01-01','2021-02-27','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00140035','0101'),
(13,'00090033','FOXS CRYSTAL CLEAR PASSIAR MINTS 180G','MAN00015',0.00,56.00,2.00,54.00,250.00,280.00,'0001-01-01','2021-02-27','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00090033','0101'),
(14,'00080025','KAZI FARMS PARATHA 10PCS 650 GM','MAN00007',0.00,20.00,0.00,20.00,80.00,100.00,'2021-02-28','2021-02-27','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080025','0101'),
(15,'00030028','PRAN TOMATO SAUCE','MAN00005',97.00,0.00,4.00,93.00,80.00,90.00,'0001-01-01','2021-02-27','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00030028','0101'),
(16,'00110030','IFAD NOODLES','MAN00007',97.00,0.00,50.00,47.00,30.00,35.00,'0001-01-01','2021-02-27','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00110030','0101'),
(17,'00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',97.00,0.00,8.00,89.00,135.00,200.00,'0001-01-01','2021-03-01','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010022','0101'),
(18,'00070027','POTATO 10KG PACKET','MAN00015',97.00,0.00,2.00,95.00,250.00,260.00,'0001-01-01','2021-03-01','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(19,'00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',97.00,0.00,1.00,96.00,300.00,330.00,'0001-01-01','2021-03-01','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010023','0101'),
(20,'00090032','CADBURY DAIRY MILK SILK CHOCOLATE 60±5 GM*','MAN00012',97.00,0.00,15.00,82.00,90.00,100.00,'0001-01-01','2021-03-02','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00090032','0101'),
(21,'00080025','KAZI FARMS PARATHA 10PCS 650 GM','MAN00007',97.00,0.00,2.00,95.00,80.00,100.00,'0001-01-01','2021-03-02','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080025','0101'),
(22,'00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',97.00,50.00,1.00,146.00,96.00,120.00,'2021-03-30','2021-03-02','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010023','0101'),
(23,'00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',97.00,0.00,1.00,96.00,135.00,200.00,'0001-01-01','2021-03-02','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010022','0101'),
(24,'00070027','POTATO 10KG PACKET','MAN00015',97.00,0.00,1.00,96.00,250.00,260.00,'0001-01-01','2021-03-02','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(25,'00080024','MARKS FULL CREAM MILK POWDER 1000 GM TIN','MAN00012',97.00,170.00,0.00,267.00,60.00,80.00,'2021-03-23','2021-03-02','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080024','0101'),
(26,'00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS','MAN00015',0.00,87.00,0.00,87.00,60.00,80.00,'2021-04-01','2021-03-13','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00150034',NULL),
(27,'00080024','MARKS FULL CREAM MILK POWDER 1000 GM TIN','MAN00012',0.00,54.00,0.00,54.00,60.00,100.00,'2021-04-01','2021-03-13','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080024',NULL),
(28,'00110030','IFAD NOODLES','MAN00007',0.00,0.00,22.00,-22.00,30.00,35.00,'0001-01-01','2021-03-13','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00110030','0101'),
(29,'00090033','FOXS CRYSTAL CLEAR PASSIAR MINTS 180G','MAN00015',0.00,0.00,5.00,-5.00,250.00,280.00,'0001-01-01','2021-03-13','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00090033','0101'),
(30,'00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER','MAN00015',0.00,0.00,45.00,-45.00,180.00,200.00,'0001-01-01','2021-03-13','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00140035','0101'),
(31,'00080025','KAZI FARMS PARATHA 10PCS 650 GM','MAN00007',0.00,0.00,11.00,-11.00,80.00,100.00,'0001-01-01','2021-03-13','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080025','0101'),
(32,'00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',0.00,0.00,28.00,-28.00,96.00,120.00,'0001-01-01','2021-03-13','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010023','0101'),
(33,'00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS','MAN00015',0.00,89.00,1.00,88.00,60.00,76.00,'0001-01-01','2021-03-13','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00150034','0101'),
(34,'00090032','CADBURY DAIRY MILK SILK CHOCOLATE 60±5 GM*','MAN00012',0.00,50.00,0.00,50.00,60.00,65.00,'2021-03-31','2021-03-13','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00090032','0101'),
(35,'00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',0.00,34.00,0.00,34.00,60.00,59.00,'2021-10-23','2021-03-13','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010022','0101'),
(36,'00070027','POTATO 10KG PACKET','MAN00015',0.00,0.00,1.00,-1.00,250.00,260.00,'0001-01-01','2021-03-13','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(37,'00080024','MARKS FULL CREAM MILK POWDER 1000 GM TIN','MAN00012',0.00,0.00,1.00,-1.00,60.00,100.00,'0001-01-01','2021-03-13','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080024','0101');

/*Table structure for table `product_stock_in` */

DROP TABLE IF EXISTS `product_stock_in`;

CREATE TABLE `product_stock_in` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(50) DEFAULT NULL,
  `product_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `manufacturer_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `supplier_code` varchar(50) DEFAULT NULL,
  `quantity` double(10,2) DEFAULT '0.00',
  `unit_price` double(10,2) DEFAULT '0.00',
  `total_price` double(10,2) DEFAULT '0.00',
  `mrp_price` double(10,2) DEFAULT '0.00',
  `expire_date` date DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `invoice` varchar(50) DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `batch_no` varchar(100) DEFAULT NULL,
  `client_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `barcode` varchar(100) DEFAULT NULL,
  `trade_code` varchar(50) DEFAULT NULL,
  `discount_percentage` double(10,2) DEFAULT '0.00',
  `discount` double(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `product_stock_in` */

insert  into `product_stock_in`(`id`,`transaction_id`,`product_code`,`product_name`,`manufacturer_code`,`supplier_code`,`quantity`,`unit_price`,`total_price`,`mrp_price`,`expire_date`,`entry_date`,`invoice`,`user_id`,`batch_no`,`client_code`,`barcode`,`trade_code`,`discount_percentage`,`discount`) values 
(1,'IPZ5GIREICDN','00070027','POTATO 10KG PACKET','MAN00015','SUP00001',300.00,250.00,75000.00,260.00,'2021-03-11','2021-02-24','INV0221M9MLGQ1','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101',0.00,0.00),
(2,'IPZ5GIREICDN','00030028','PRAN TOMATO SAUCE','MAN00005','SUP00001',320.00,80.00,25600.00,90.00,'2021-03-13','2021-02-24','INV0221M9MLGQ1','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00030028','0101',0.00,0.00),
(3,'IPZ5GIREICDN','00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005','SUP00001',100.00,135.00,13500.00,200.00,'2021-03-05','2021-02-24','INV0221M9MLGQ1','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010022','0101',0.00,0.00),
(4,'LXKHV6F0YRWV','00090032','CADBURY DAIRY MILK SILK CHOCOLATE 60±5 GM*','MAN00012','SUP00005',56.00,90.00,5040.00,100.00,'2020-12-24','2021-02-24','21023HTEVXQ','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00090032','0101',0.00,0.00),
(5,'LXKHV6F0YRWV','00110030','IFAD NOODLES','MAN00007','SUP00005',96.00,30.00,2880.00,35.00,'2021-02-28','2021-02-24','21023HTEVXQ','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00110030','0101',0.00,0.00),
(6,'LXKHV6F0YRWV','00070027','POTATO 10KG PACKET','MAN00015','SUP00005',69.00,250.00,17250.00,260.00,'2021-02-28','2021-02-24','21023HTEVXQ','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101',0.00,0.00),
(7,'Z5KASYH37L8E','6971141390616','PLEXTONE BLACK MOWI','MAN00015','SUP00005',58.00,700.00,40600.00,850.00,'0001-01-01','2021-02-24','2102BH37ODK','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','6971141390616','0101',0.00,0.00),
(8,'Z5KASYH37L8E','00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER','MAN00015','SUP00005',80.00,180.00,14400.00,200.00,'0001-01-01','2021-02-24','2102BH37ODK','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00140035','0101',0.00,0.00),
(9,'OVO4JLNG6L10','00070027','POTATO 10KG PACKET','MAN00015','SUP00002',10.00,250.00,2500.00,260.00,'2021-02-28','2021-02-27','2102053UZGK','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101',0.00,0.00),
(10,'OVO4JLNG6L10','00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013','SUP00002',50.00,300.00,15000.00,330.00,'2021-02-28','2021-02-27','2102053UZGK','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010023','0101',0.00,0.00),
(11,'5IIIHZZGRGB6','00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS','MAN00015','SUP00003',50.00,700.00,35000.00,895.00,'0001-01-01','2021-02-27','2102YVCF9WO','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00150034','0101',0.00,0.00),
(12,'5IIIHZZGRGB6','00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER','MAN00015','SUP00003',20.00,180.00,3600.00,200.00,'2021-02-28','2021-02-27','2102YVCF9WO','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00140035','0101',0.00,0.00),
(13,'ND30B8UI4RIM','00090033','FOXS CRYSTAL CLEAR PASSIAR MINTS 180G','MAN00015','SUP00004',56.00,250.00,14000.00,280.00,'2021-02-28','2021-02-27','21027N34BC2','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00090033','0101',0.00,0.00),
(14,'ND30B8UI4RIM','00080025','KAZI FARMS PARATHA 10PCS 650 GM','MAN00007','SUP00004',20.00,80.00,1600.00,100.00,'2021-02-28','2021-02-27','21027N34BC2','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080025','0101',0.00,0.00),
(15,'H5S5WHQ6987K','00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013','SUP00009',50.00,96.00,4800.00,120.00,'2021-03-30','2021-03-02','2103GPBXHDA','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010023','0101',0.00,0.00),
(16,'H5S5WHQ6987K','00080024','MARKS FULL CREAM MILK POWDER 1000 GM TIN','MAN00012','SUP00009',170.00,60.00,10200.00,80.00,'2021-03-23','2021-03-02','2103GPBXHDA','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080024','0101',0.00,0.00),
(17,'6OKTK3YJRO1V','00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS','MAN00015','SUP00005',87.00,60.00,5220.00,80.00,'2021-04-01','2021-03-13','0101000000001','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00150034','0101',0.00,0.00),
(18,'6OKTK3YJRO1V','00080024','MARKS FULL CREAM MILK POWDER 1000 GM TIN','MAN00012','SUP00005',54.00,60.00,3240.00,100.00,'2021-04-01','2021-03-13','0101000000001','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080024','0101',0.00,0.00),
(19,'MIF03AR2FU8N','00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS','MAN00015','SUP00006',89.00,60.00,5340.00,76.00,'2021-04-30','2021-03-13','0101000000003','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00150034','0101',0.00,0.00),
(20,'MIF03AR2FU8N','00090032','CADBURY DAIRY MILK SILK CHOCOLATE 60±5 GM*','MAN00012','SUP00006',50.00,60.00,3000.00,65.00,'2021-03-31','2021-03-13','0101000000003','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00090032','0101',0.00,0.00),
(21,'MIF03AR2FU8N','00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005','SUP00006',34.00,60.00,2040.00,59.00,'2021-10-23','2021-03-13','0101000000003','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010022','0101',0.00,0.00);

/*Table structure for table `product_stock_out` */

DROP TABLE IF EXISTS `product_stock_out`;

CREATE TABLE `product_stock_out` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(50) DEFAULT NULL,
  `product_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `manufacturer_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `customer_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `quantity` double(10,2) DEFAULT '0.00',
  `unit_price` double(10,2) DEFAULT '0.00',
  `discount_percentage` double(10,2) DEFAULT NULL,
  `discount` double(10,2) DEFAULT NULL,
  `total_price_deducted` double(10,2) DEFAULT '0.00',
  `total_price` double(10,2) DEFAULT '0.00',
  `mrp_price` double(10,2) DEFAULT '0.00',
  `expire_date` date DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `invoice` varchar(50) DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `batch_no` varchar(100) DEFAULT NULL,
  `client_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `barcode` varchar(100) DEFAULT NULL,
  `trade_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

/*Data for the table `product_stock_out` */

insert  into `product_stock_out`(`id`,`transaction_id`,`product_code`,`product_name`,`manufacturer_code`,`customer_code`,`quantity`,`unit_price`,`discount_percentage`,`discount`,`total_price_deducted`,`total_price`,`mrp_price`,`expire_date`,`entry_date`,`invoice`,`user_id`,`batch_no`,`client_code`,`barcode`,`trade_code`) values 
(1,'DFD8S0H54I7G','00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',NULL,2.00,135.00,NULL,NULL,0.00,400.00,200.00,'0001-01-01','2021-02-24','INV02219C6KLWZ','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010022','0101'),
(2,'DFD8S0H54I7G','00070027','POTATO 10KG PACKET','MAN00015',NULL,5.00,250.00,NULL,NULL,0.00,1300.00,260.00,'0001-01-01','2021-02-24','INV02219C6KLWZ','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(3,'D9Z8CAUXTG8K','00070027','POTATO 10KG PACKET','MAN00015',NULL,1.00,250.00,NULL,NULL,0.00,260.00,260.00,'0001-01-01','2021-02-24','INV0221MFYB242','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(4,'OHXFK97FFZRZ','00070027','POTATO 10KG PACKET','MAN00015',NULL,2.00,250.00,NULL,NULL,0.00,520.00,260.00,'0001-01-01','2021-02-24','INV0221XZHHM9L','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(5,'6Q7JAG79P5HN','00070027','POTATO 10KG PACKET','MAN00015',NULL,1.00,250.00,NULL,NULL,0.00,260.00,260.00,'0001-01-01','2021-02-24','INV0221PPDFGRS','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(6,'XEYDUKLJ2CVO','00070027','POTATO 10KG PACKET','MAN00015',NULL,15.00,250.00,NULL,NULL,0.00,3900.00,260.00,'0001-01-01','2021-02-24','INV0221UGWBKVD','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(7,'XEYDUKLJ2CVO','00030028','PRAN TOMATO SAUCE','MAN00005',NULL,1.00,80.00,NULL,NULL,0.00,90.00,90.00,'0001-01-01','2021-02-24','INV0221UGWBKVD','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00030028','0101'),
(8,'JVSFT0IOFOSU','00070027','POTATO 10KG PACKET','MAN00015',NULL,50.00,250.00,NULL,NULL,0.00,13000.00,260.00,'0001-01-01','2021-02-24','2102IGWNI7D','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(9,'5DNCR5X7OQJX','00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',NULL,1.00,135.00,NULL,NULL,0.00,200.00,200.00,'0001-01-01','2021-02-24','21027HIMAKK','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010022','0101'),
(10,'5DNCR5X7OQJX','00090032','CADBURY DAIRY MILK SILK CHOCOLATE 60±5 GM*','MAN00012',NULL,1.00,90.00,NULL,NULL,0.00,100.00,100.00,'0001-01-01','2021-02-24','21027HIMAKK','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00090032','0101'),
(11,'MD4R5BFR8W4W','00070027','POTATO 10KG PACKET','MAN00015',NULL,1.00,250.00,NULL,NULL,0.00,260.00,260.00,'0001-01-01','2021-02-27','2102NOXQX4H','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(12,'MD4R5BFR8W4W','6971141390616','PLEXTONE BLACK MOWI','MAN00015',NULL,1.00,700.00,NULL,NULL,0.00,850.00,850.00,'0001-01-01','2021-02-27','2102NOXQX4H','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','6971141390616','0101'),
(13,'9NQ59VBS1PR4','00070027','POTATO 10KG PACKET','MAN00015',NULL,50.00,250.00,NULL,NULL,0.00,13000.00,260.00,'0001-01-01','2021-02-27','2102863274J','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(14,'9NQ59VBS1PR4','6971141390616','PLEXTONE BLACK MOWI','MAN00015',NULL,2.00,700.00,NULL,NULL,0.00,1700.00,850.00,'0001-01-01','2021-02-27','2102863274J','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','6971141390616','0101'),
(15,'A91AVEEVMMUH','00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',NULL,1.00,300.00,NULL,NULL,0.00,330.00,330.00,'0001-01-01','2021-02-27','21021OZCH1C','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010023','0101'),
(16,'QCH70HGV2R4E','00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',NULL,1.00,300.00,NULL,NULL,0.00,330.00,330.00,'0001-01-01','2021-02-27','2102WF5P487','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010023','0101'),
(17,'I3J2I2UFWS46','00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS','MAN00015',NULL,3.00,700.00,NULL,NULL,0.00,2685.00,895.00,'0001-01-01','2021-02-27','2102H663KQT','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00150034','0101'),
(18,'I3J2I2UFWS46','00090033','FOXS CRYSTAL CLEAR PASSIAR MINTS 180G','MAN00015',NULL,2.00,250.00,NULL,NULL,0.00,560.00,280.00,'0001-01-01','2021-02-27','2102H663KQT','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00090033','0101'),
(19,'I3J2I2UFWS46','00110030','IFAD NOODLES','MAN00007',NULL,50.00,30.00,NULL,NULL,0.00,1750.00,35.00,'0001-01-01','2021-02-27','2102H663KQT','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00110030','0101'),
(20,'I3J2I2UFWS46','00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER','MAN00015',NULL,2.00,180.00,NULL,NULL,0.00,400.00,200.00,'0001-01-01','2021-02-27','2102H663KQT','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00140035','0101'),
(21,'I3J2I2UFWS46','00030028','PRAN TOMATO SAUCE','MAN00005',NULL,4.00,80.00,NULL,NULL,0.00,360.00,90.00,'0001-01-01','2021-02-27','2102H663KQT','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00030028','0101'),
(22,'I3J2I2UFWS46','6971141390616','PLEXTONE BLACK MOWI','MAN00015',NULL,1.00,700.00,NULL,NULL,0.00,850.00,850.00,'0001-01-01','2021-02-27','2102H663KQT','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','6971141390616','0101'),
(23,'42VWRGSO2IF2','00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',NULL,8.00,135.00,10.00,160.00,1440.00,1600.00,200.00,'0001-01-01','2021-03-01','2103YAFLIMJ','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010022','0101'),
(24,'42VWRGSO2IF2','00070027','POTATO 10KG PACKET','MAN00015',NULL,2.00,250.00,20.00,104.00,416.00,520.00,260.00,'0001-01-01','2021-03-01','2103YAFLIMJ','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(25,'42VWRGSO2IF2','00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',NULL,1.00,300.00,0.00,0.00,330.00,330.00,330.00,'0001-01-01','2021-03-01','2103YAFLIMJ','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010023','0101'),
(26,'2CNLBMJ9WN3A','00090032','CADBURY DAIRY MILK SILK CHOCOLATE 60±5 GM*','MAN00012',NULL,15.00,90.00,0.00,0.00,1500.00,1500.00,100.00,'0001-01-01','2021-03-02','2103K7BEI2X','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00090032','0101'),
(27,'2CNLBMJ9WN3A','00080025','KAZI FARMS PARATHA 10PCS 650 GM','MAN00007',NULL,1.00,80.00,0.00,0.00,100.00,100.00,100.00,'0001-01-01','2021-03-02','2103K7BEI2X','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080025','0101'),
(28,'MRVWWTXFITPU','00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',NULL,1.00,300.00,4.00,13.20,316.80,330.00,330.00,'0001-01-01','2021-03-02','2103C7VOIED','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010023','0101'),
(29,'MRVWWTXFITPU','00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',NULL,1.00,135.00,10.00,20.00,180.00,200.00,200.00,'0001-01-01','2021-03-02','2103C7VOIED','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010022','0101'),
(30,'MRVWWTXFITPU','00070027','POTATO 10KG PACKET','MAN00015',NULL,1.00,250.00,6.00,15.60,244.40,260.00,260.00,'0001-01-01','2021-03-02','2103C7VOIED','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(31,'MRVWWTXFITPU','00080025','KAZI FARMS PARATHA 10PCS 650 GM','MAN00007',NULL,1.00,80.00,0.00,0.00,100.00,100.00,100.00,'0001-01-01','2021-03-02','2103C7VOIED','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080025','0101'),
(32,'0CNE1QHPV6KM','00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',NULL,20.00,96.00,0.00,0.00,2400.00,2400.00,120.00,'0001-01-01','2021-03-13','0101000000002','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010023','0101'),
(33,'0CNE1QHPV6KM','00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER','MAN00015',NULL,45.00,180.00,0.00,0.00,9000.00,9000.00,200.00,'0001-01-01','2021-03-13','0101000000002','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00140035','0101'),
(34,'0CNE1QHPV6KM','00090033','FOXS CRYSTAL CLEAR PASSIAR MINTS 180G','MAN00015',NULL,5.00,250.00,0.00,0.00,1400.00,1400.00,280.00,'0001-01-01','2021-03-13','0101000000002','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00090033','0101'),
(35,'0CNE1QHPV6KM','00080025','KAZI FARMS PARATHA 10PCS 650 GM','MAN00007',NULL,10.00,80.00,0.00,0.00,1000.00,1000.00,100.00,'0001-01-01','2021-03-13','0101000000002','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080025','0101'),
(36,'0CNE1QHPV6KM','00110030','IFAD NOODLES','MAN00007',NULL,21.00,30.00,0.00,0.00,735.00,735.00,35.00,'0001-01-01','2021-03-13','0101000000002','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00110030','0101'),
(37,'2P86UG0SYPFA','00080025','KAZI FARMS PARATHA 10PCS 650 GM','MAN00007',NULL,1.00,80.00,0.00,0.00,100.00,100.00,100.00,'0001-01-01','2021-03-13','0101000000004','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080025','0101'),
(38,'2P86UG0SYPFA','00070027','POTATO 10KG PACKET','MAN00015',NULL,1.00,250.00,0.00,0.00,260.00,260.00,260.00,'0001-01-01','2021-03-13','0101000000004','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00070027','0101'),
(39,'2P86UG0SYPFA','00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS','MAN00015',NULL,1.00,60.00,0.00,0.00,76.00,76.00,76.00,'0001-01-01','2021-03-13','0101000000004','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00150034','0101'),
(40,'G9850NDLIKSQ','00110030','IFAD NOODLES','MAN00007',NULL,1.00,30.00,5.00,1.75,33.25,35.00,35.00,'0001-01-01','2021-03-13','0101000000005','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00110030','0101'),
(41,'G9850NDLIKSQ','00080024','MARKS FULL CREAM MILK POWDER 1000 GM TIN','MAN00012',NULL,1.00,60.00,0.00,0.00,100.00,100.00,100.00,'0001-01-01','2021-03-13','0101000000005','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00080024','0101'),
(42,'G9850NDLIKSQ','00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',NULL,8.00,96.00,0.00,0.00,960.00,960.00,120.00,'0001-01-01','2021-03-13','0101000000005','a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'01','00010023','0101');

/*Table structure for table `subcategory_info` */

DROP TABLE IF EXISTS `subcategory_info`;

CREATE TABLE `subcategory_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  `category_code` varchar(50) DEFAULT NULL,
  `category_name` varchar(100) DEFAULT NULL,
  `trade_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8;

/*Data for the table `subcategory_info` */

insert  into `subcategory_info`(`id`,`code`,`name`,`description`,`client_code`,`category_code`,`category_name`,`trade_code`) values 
(76,'000201','BEEF',NULL,'01','0002','MEAT & SEAFOOD','0101'),
(77,'000202','MUTTON',NULL,'01','0002','MEAT & SEAFOOD','0101'),
(78,'000203','LAMB',NULL,'01','0002','MEAT & SEAFOOD','0101'),
(79,'000204','CHICKEN',NULL,'01','0002','MEAT & SEAFOOD','0101'),
(80,'000205','FISH',NULL,'01','0002','MEAT & SEAFOOD','0101'),
(81,'000206','SHELLFISH',NULL,'01','0002','MEAT & SEAFOOD','0101'),
(82,'000207','SEAFOOD',NULL,'01','0002','MEAT & SEAFOOD','0101'),
(83,'000301','OILS',NULL,'01','0003','OILS, SAUCES & CONDIMENTS','0101'),
(84,'000302','SAUCES',NULL,'01','0003','OILS, SAUCES & CONDIMENTS','0101'),
(85,'000303','ESSENCE',NULL,'01','0003','OILS, SAUCES & CONDIMENTS','0101'),
(86,'000304','SPICES',NULL,'01','0003','OILS, SAUCES & CONDIMENTS','0101'),
(87,'000305','CONDIMENTS',NULL,'01','0003','OILS, SAUCES & CONDIMENTS','0101'),
(112,'000601','CHEESE',NULL,'01','0006','DAIRY & fARM PRODUCTS','0101'),
(113,'000602','MILK',NULL,'01','0006','DAIRY & fARM PRODUCTS','0101'),
(114,'000603','BUTTER',NULL,'01','0006','DAIRY & fARM PRODUCTS','0101'),
(115,'000604','YOGHURT',NULL,'01','0006','DAIRY & fARM PRODUCTS','0101'),
(116,'000605','GHEE',NULL,'01','0006','DAIRY & fARM PRODUCTS','0101'),
(117,'000606','CURD',NULL,'01','0006','DAIRY & fARM PRODUCTS','0101'),
(118,'000607','MILK PRODUCTS',NULL,'01','0006','DAIRY & fARM PRODUCTS','0101'),
(119,'000701','FRUITS',NULL,'01','0007','PRODUCES','0101'),
(120,'000702','VEGETABLES',NULL,'01','0007','PRODUCES','0101'),
(121,'000703','PLANTS',NULL,'01','0007','PRODUCES','0101'),
(122,'000704','POTATOES',NULL,'01','0007','PRODUCES','0101'),
(123,'000705','ONIONS',NULL,'01','0007','PRODUCES','0101'),
(124,'000706','GARLIC',NULL,'01','0007','PRODUCES','0101'),
(125,'000801','FROZEN MEAT',NULL,'01','0008','FROZEN FOODS','0101'),
(126,'000802','FROZEN FOOD',NULL,'01','0008','FROZEN FOODS','0101'),
(127,'000803','ICE-CREAM',NULL,'01','0008','FROZEN FOODS','0101'),
(128,'000901','CANDY',NULL,'01','0009','CONFECTIONARY','0101'),
(129,'000902','CHOCOLATES',NULL,'01','0009','CONFECTIONARY','0101'),
(130,'000903','CAKE',NULL,'01','0009','CONFECTIONARY','0101'),
(131,'000904','SWEETS',NULL,'01','0009','CONFECTIONARY','0101'),
(140,'001101','FLOUR',NULL,'01','0011','DRY/BAKING GOODS','0101'),
(141,'001102','ATTA',NULL,'01','0011','DRY/BAKING GOODS','0101'),
(142,'001103','SEMOLINA',NULL,'01','0011','DRY/BAKING GOODS','0101'),
(143,'001104','SUGAR',NULL,'01','0011','DRY/BAKING GOODS','0101'),
(144,'001105','SALT',NULL,'01','0011','DRY/BAKING GOODS','0101'),
(145,'001106','PASTA',NULL,'01','0011','DRY/BAKING GOODS','0101'),
(146,'001107','NOODLES',NULL,'01','0011','DRY/BAKING GOODS','0101'),
(147,'001108','MIXES',NULL,'01','0011','DRY/BAKING GOODS','0101'),
(148,'001109','CEREALS',NULL,'01','0011','DRY/BAKING GOODS','0101'),
(149,'001201','ALL- PURPOSE',NULL,'01','0012','CLEANERS','0101'),
(150,'001202','LAUNDRY DETERGENT',NULL,'01','0012','CLEANERS','0101'),
(151,'001203','DISHWASHING LIQUID/DETERGENT',NULL,'01','0012','CLEANERS','0101'),
(152,'001204','FLOOR/GLASS CLEANERS',NULL,'01','0012','CLEANERS','0101'),
(153,'001205','BLEACH',NULL,'01','0012','CLEANERS','0101'),
(154,'001301','PAPER TOWELS',NULL,'01','0013','PAPER GOODS','0101'),
(155,'001302','TOILET PAPER',NULL,'01','0013','PAPER GOODS','0101'),
(156,'001303','ALUMINUM FOIL',NULL,'01','0013','PAPER GOODS','0101'),
(157,'001304','SANDWICH BAGS',NULL,'01','0013','PAPER GOODS','0101'),
(158,'001401','SHAMPOO',NULL,'01','0014','PERSONAL CARE & TOILETRIES','0101'),
(159,'001402','SOAP',NULL,'01','0014','PERSONAL CARE & TOILETRIES','0101'),
(160,'001403','HAND SOAP',NULL,'01','0014','PERSONAL CARE & TOILETRIES','0101'),
(161,'001404','SHAVING CREAM',NULL,'01','0014','PERSONAL CARE & TOILETRIES','0101'),
(166,'001601','MEDICINE',NULL,'01','0016','PHARMACY','0101'),
(167,'001602','SYRUP',NULL,'01','0016','PHARMACY','0101'),
(168,'001603','BAND-AID',NULL,'01','0016','PHARMACY','0101'),
(169,'001801','CHINA CERAMICS',NULL,'01','0018','CROCKERIES','0101'),
(170,'001802','GLASS',NULL,'01','0018','CROCKERIES','0101'),
(171,'001803','TEFLONS',NULL,'01','0018','CROCKERIES','0101'),
(172,'001804','METAL',NULL,'01','0018','CROCKERIES','0101'),
(173,'001805','PLASTICS',NULL,'01','0018','CROCKERIES','0101'),
(174,'001901','GIFT CARDS',NULL,'01','0019','GIFT ITEMS','0101'),
(175,'001902','BALLONS',NULL,'01','0019','GIFT ITEMS','0101'),
(176,'001903','DECORATIONS',NULL,'01','0019','GIFT ITEMS','0101'),
(182,'000401','RICE',NULL,'01','0004','RICE, LENTIL & DRIED LEGUMES ','0101'),
(183,'000402','LENTIL',NULL,'01','0004','RICE, LENTIL & DRIED LEGUMES ','0101'),
(184,'000403','PULSE',NULL,'01','0004','RICE, LENTIL & DRIED LEGUMES ','0101'),
(185,'000404','BEANS',NULL,'01','0004','RICE, LENTIL & DRIED LEGUMES ','0101'),
(186,'000405','PEAS',NULL,'01','0004','RICE, LENTIL & DRIED LEGUMES ','0101'),
(187,'000406','NUTS',NULL,'01','0004','RICE, LENTIL & DRIED LEGUMES ','0101'),
(198,'002901','ART SUPPLY',NULL,'01','0029','ARTS AND CRAFTS','0101'),
(199,'003007','PENSTAND',NULL,'01','0030','STATIONERY','0101'),
(200,'003006','BOOKS',NULL,'01','0030','STATIONERY','0101'),
(201,'003005','SHARPNER',NULL,'01','0030','STATIONERY','0101'),
(202,'003004','ERASER',NULL,'01','0030','STATIONERY','0101'),
(203,'003003','PENCIL',NULL,'01','0030','STATIONERY','0101'),
(204,'003002','PAPER',NULL,'01','0030','STATIONERY','0101'),
(205,'003008','OFFICE SUPPLY',NULL,'01','0030','STATIONERY','0101'),
(206,'003001','PEN',NULL,'01','0030','STATIONERY','0101'),
(211,'001001','COFFEE',NULL,'01','0010','BEVERAGES','0101'),
(212,'001002','TEA',NULL,'01','0010','BEVERAGES','0101'),
(213,'001003','JUICE',NULL,'01','0010','BEVERAGES','0101'),
(214,'001004','CARBONATED BEVERAGES',NULL,'01','0010','BEVERAGES','0101'),
(215,'001005','WATER',NULL,'01','0010','BEVERAGES','0101'),
(216,'000101','SANDWITCH BREAD',NULL,'01','0001','BREAD & BAKERY','0101'),
(217,'000102','ROTI',NULL,'01','0001','BREAD & BAKERY','0101'),
(218,'000103','PARATHA',NULL,'01','0001','BREAD & BAKERY','0101'),
(219,'000104','BUNS',NULL,'01','0001','BREAD & BAKERY','0101'),
(220,'000105','BREAD',NULL,'01','0001','BREAD & BAKERY','0101'),
(221,'000106','ROLLS',NULL,'01','0001','BREAD & BAKERY','0101'),
(222,'000107','PASTRYS',NULL,'01','0001','BREAD & BAKERY','0101'),
(223,'000108','BISCUITS',NULL,'01','0001','BREAD & BAKERY','0101'),
(245,'003201','CHIPS',NULL,'01','0032','CHIPS AND PACKAGED PRODUCTS','0101'),
(246,'003202','POPCORN',NULL,'01','0032','CHIPS AND PACKAGED PRODUCTS','0101'),
(247,'003203','NUTS',NULL,'01','0032','CHIPS AND PACKAGED PRODUCTS','0101'),
(248,'003204','DALMUT',NULL,'01','0032','CHIPS AND PACKAGED PRODUCTS','0101'),
(249,'003205','DRY SNACKS',NULL,'01','0032','CHIPS AND PACKAGED PRODUCTS','0101'),
(250,'000501','JAM',NULL,'01','0005','TIN CANNED/JARRED GOODS','0101'),
(251,'000502','JELLY',NULL,'01','0005','TIN CANNED/JARRED GOODS','0101'),
(252,'000503','VINEGAR',NULL,'01','0005','TIN CANNED/JARRED GOODS','0101'),
(253,'000504','CANNED FRUITS',NULL,'01','0005','TIN CANNED/JARRED GOODS','0101'),
(254,'000505','CANNED VEGETABLES',NULL,'01','0005','TIN CANNED/JARRED GOODS','0101'),
(255,'000506','PICKLES',NULL,'01','0005','TIN CANNED/JARRED GOODS','0101'),
(256,'000507','CAN',NULL,'01','0005','TIN CANNED/JARRED GOODS','0101'),
(257,'003101','COFFEE',NULL,'01','0031','INSTANT PRODUCTS','0101'),
(258,'003102','SOUP',NULL,'01','0031','INSTANT PRODUCTS','0101'),
(259,'003103','JUICE POWDER',NULL,'01','0031','INSTANT PRODUCTS','0101'),
(260,'003104','JELLY POWDER',NULL,'01','0031','INSTANT PRODUCTS','0101'),
(261,'003105','ICING SUGAR',NULL,'01','0031','INSTANT PRODUCTS','0101'),
(262,'003106','MILK POWDER',NULL,'01','0031','INSTANT PRODUCTS','0101'),
(263,'002001','MICROWAVE OVEN',NULL,'01','0020','ELECTRONICS','0101'),
(264,'002002','ELECTRIC IRON ',NULL,'01','0020','ELECTRONICS','0101'),
(265,'002003','HAIR DRYER',NULL,'01','0020','ELECTRONICS','0101'),
(266,'002004','CURLING IRON',NULL,'01','0020','ELECTRONICS','0101'),
(267,'002005','KETTLE',NULL,'01','0020','ELECTRONICS','0101'),
(273,'001501','BABY ITEMS',NULL,'01','0015','OTHER','0101'),
(274,'001502','PET ITEMS',NULL,'01','0015','OTHER','0101'),
(275,'001503','BATTERIES',NULL,'01','0015','OTHER','0101'),
(276,'001504','GREETING CARDS',NULL,'01','0015','OTHER','0101'),
(277,'001505','TOYS',NULL,'01','0015','OTHER','0101');

/*Table structure for table `suppliers_info` */

DROP TABLE IF EXISTS `suppliers_info`;

CREATE TABLE `suppliers_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `division` varchar(50) DEFAULT NULL,
  `district` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `thana` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `supplier_type` tinyint(1) DEFAULT '1',
  `remarks` varchar(50) DEFAULT NULL,
  `entry_date` date DEFAULT '0001-01-01',
  `entry_by` varchar(50) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  `trade_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `suppliers_info` */

insert  into `suppliers_info`(`id`,`code`,`name`,`company`,`address`,`division`,`district`,`thana`,`mobile`,`email`,`supplier_type`,`remarks`,`entry_date`,`entry_by`,`client_code`,`trade_code`) values 
(3,'SUP00001','MD. SHAHIDUZZAMAN','SHAHID TRADERS','TALKONA','DHAKA','MADARIPUR','SHIBCHAR','019675347','tanjin@email.com',1,'Nothing','2021-01-26','ADMIN','01','0101'),
(4,'SUP00002','MD. MOAZZEM HOSSAIN','ZEM FOODS','BASHABO','DHAKA','DHAKA','SABUJBAGH','016575446','gh@email.com',1,'Nothing','2021-01-26','ADMIN','01','0101'),
(5,'SUP00003','SUMON MEHEDI','MEHEDI CORP.','BASHABO','DHAKA','DHAKA','SABUJBAGH','015675755','nf@email.com',1,'Nothing','2021-01-26','ADMIN','01','0101'),
(6,'SUP00004','MD. ATIAR RAHMAN ','LIJAN TRADERS','JBN','DHAKA','DHAKA','SHAH ALI','015657455','yt3245@email.com',1,'Nothing','2021-02-11','ADMIN','01','0101'),
(7,'SUP00005','MD. MIZANUR RAHMAN','ZAN TRADERS','BASHABO','DHAKA','DHAKA','SABUJBAGH','012355757','kj3456@email.com',1,'Nothing','2021-01-26','ADMIN','01','0101'),
(8,'SUP00006','MUHAMMAD MASUM BILLAH','BILLAH & BILLAH','BASHABO','DHAKA','DHAKA','SABUJBAGH','015767566','poi46467@email.com',1,'Nothing','2021-01-26','ADMIN','01','0101'),
(9,'SUP00007','MD GOLAM ROBBANI','ROBBA BAKERY','SHONKOR','DHAKA','DHAKA','DHANMONDI','0165489653','sobuj@molla.com',1,'Nothing Important','2021-01-26','ADMIN','01','0101'),
(11,'SUP00008','MD. MOZIBOR RAHMAN','RAHMAN LTD.','JANATA TOWER','DHAKA','DHAKA','TEJGAON','0195736823','nice@nice.com',1,'asdfsdfasdgfdg','2021-01-26','ADMIN','01','0101'),
(12,'SUP00009','REZAUL AZAM FARUQUI','AZAM INC.','RESHAT','RANGPUR','NILPHAMARI','NILPHAMARI SADAR','01478796548','t@m.com',1,'Nice','2021-01-26','ADMIN','01','0101');

/*Table structure for table `trade` */

DROP TABLE IF EXISTS `trade`;

CREATE TABLE `trade` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `in_charge` varchar(50) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  `block` varchar(50) DEFAULT NULL,
  `floor` varchar(50) DEFAULT NULL,
  `vat_percent` double(10,2) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `trade` */

insert  into `trade`(`id`,`name`,`code`,`description`,`in_charge`,`client_code`,`block`,`floor`,`vat_percent`,`phone`) values 
(8,'Grocery','0101','N/A','Sobuj Molla','01','A','1st',0.00,'326598'),
(9,'Furniture','0102','N/A','Ikbal Nayem','01','B','1st',0.00,'321456987'),
(10,'Shoes','0103','N/A','Mahadi Hassan','01','C','2nd',0.00,'8521456'),
(11,'Dairy','0104','N/A','Imrul Kayes','01','Z','12th',0.00,'693619');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `user_type` varchar(20) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `added_by` varchar(50) DEFAULT NULL,
  `add_date` datetime DEFAULT '0001-01-01 00:00:00',
  `client_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `trade_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`first_name`,`last_name`,`email`,`user_type`,`phone`,`status`,`user_id`,`added_by`,`add_date`,`client_code`,`trade_code`) values 
(52,'POS','ADMIN','pos.admin@nice.com','SYSADMIN','01111111111',1,'d870f273-3380-47ed-a0ec-c5cabf960270',NULL,'2021-03-07 00:00:00',NULL,NULL),
(57,'IKBAL','NAYEM','admin@miba.com','ADMIN','02154963541',0,'a4650d10-8f48-42e2-a4e3-370bbdb74371',NULL,'2021-03-13 14:39:58','01',NULL),
(59,'IKBAL','NAYEM','ikna@gmail.com','SALES','01758956324',1,'dc5c55bc-fe03-4f36-82dc-9530267f2391','a4650d10-8f48-42e2-a4e3-370bbdb74371','2021-03-11 13:43:43','01','0101'),
(60,'ZIAUL','ALAM','zalam@gmail.com','SALES','04579624228',1,'9707e7d6-d4f3-4fc8-adbd-4b07f75537ce','a4650d10-8f48-42e2-a4e3-370bbdb74371','2021-03-11 13:45:14','01','0101');

/*Table structure for table `user_trade` */

DROP TABLE IF EXISTS `user_trade`;

CREATE TABLE `user_trade` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `trade_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

/*Data for the table `user_trade` */

insert  into `user_trade`(`id`,`user_id`,`trade_code`,`client_code`) values 
(27,'dc5c55bc-fe03-4f36-82dc-9530267f2391','0101','01'),
(28,'dc5c55bc-fe03-4f36-82dc-9530267f2391','0102','01'),
(29,'dc5c55bc-fe03-4f36-82dc-9530267f2391','0103','01'),
(30,'dc5c55bc-fe03-4f36-82dc-9530267f2391','0104','01'),
(35,'9707e7d6-d4f3-4fc8-adbd-4b07f75537ce','0101','01'),
(36,'9707e7d6-d4f3-4fc8-adbd-4b07f75537ce','0103','01'),
(37,'9707e7d6-d4f3-4fc8-adbd-4b07f75537ce','0102','01');

/*Table structure for table `z_unit_info` */

DROP TABLE IF EXISTS `z_unit_info`;

CREATE TABLE `z_unit_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unit` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `z_unit_info` */

insert  into `z_unit_info`(`id`,`unit`) values 
(1,'Pc'),
(2,'Kg'),
(3,'Pound'),
(4,'Gram'),
(5,'Milligram'),
(6,'Dozen'),
(7,'Litre'),
(8,'Gallon'),
(9,'Ounce');

/* Procedure structure for procedure `latest_stock_entry` */

/*!50003 DROP PROCEDURE IF EXISTS  `latest_stock_entry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `latest_stock_entry`(in ProductCode varchar(255), ClientCode varchar(255),EntryDate date)
BEGIN
SELECT id,
product_code,
product_name,
manufacturer_code,
opening_stock,
quantity_in,
quantity_out,
closing_stock,
unit_price,
mrp_price,
expire_date,
MAX(entry_date) AS entry_date,
user_id,
batch_no,
client_code,
barcode
FROM `product_stock` WHERE entry_date <= '2021-02-27' AND product_code = "00010022" AND client_code = "Cl799";
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
