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

/*Table structure for table `account_group` */

DROP TABLE IF EXISTS `account_group`;

CREATE TABLE `account_group` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `control_code` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `control_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `control_type` varchar(5) DEFAULT NULL,
  `c_status` varchar(10) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `account_group` */

/*Table structure for table `account_info` */

DROP TABLE IF EXISTS `account_info`;

CREATE TABLE `account_info` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `account_code` varchar(15) DEFAULT NULL,
  `account_name` varchar(90) DEFAULT NULL,
  `control_code` varchar(5) DEFAULT NULL,
  `account_desc` varchar(20) DEFAULT NULL,
  `account_type` varchar(4) DEFAULT NULL,
  `main_ref_code` varchar(10) DEFAULT NULL,
  `subs_status` varchar(2) DEFAULT NULL,
  `account_status` varchar(10) DEFAULT NULL,
  `account_comments` varchar(20) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `account_info` */

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
('711b90e7-1528-46cd-bb58-278728820c06','ipP3j+z4GvC7vrwrmN3Np+QhGRrnx5TewP37qOisDFQ=','IPP3J+Z4GVC7VRWRMN3NP+QHGRRNX5TEWP37QOISDFQ=','8572dad7-3476-4e56-b3bd-611b8c01fd61');

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
('e95a3a1b-45f5-432a-970b-372687e361aa','711b90e7-1528-46cd-bb58-278728820c06');

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
('e95a3a1b-45f5-432a-970b-372687e361aa','01725486954','01725486954','ikbal.nayem@gmail.com','IKBAL.NAYEM@GMAIL.COM',0,'AQAAAAEAACcQAAAAEGPKysHqJ8JTQUDbuJiH+YzOzjrSPcfVLsShluMGdSsq62c1BwrzJmQx8aq4O2wwvw==','DPOAQXGWZDJZC5NHRMMMOEIODW3WGQ4A','32a2bbb7-883e-4930-8d54-49bf69cc56ef','01725486954',0,0,NULL,1,0);

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
(1,'0001','BREAD & BAKERY','sandwich loaves, dinner rolls, tortillas, bagels','CL799',NULL),
(2,'0002','MEAT & SEAFOOD','Meat, poultry, beef, fish, shrimp, crabs, Seafood','CL799',NULL),
(3,'0003','OILS, SAUCES & CONDIMENTS','Related','CL799',NULL),
(4,'0004','RICE, LENTIL & DRIED LEGUMES ','N/A','CL799',NULL),
(5,'0005','TIN CANNED/JARRED GOODS','N/A','CL799',NULL),
(6,'0006','DAIRY & FARM PRODUCTS','cheeses, eggs, milk, yogurt, butter','CL799',NULL),
(7,'0007','PRODUCES',' fruits, vegetables','CL799',NULL),
(8,'0008','FROZEN FOODS','N/A','CL799',NULL),
(9,'0009','CONFECTIONARY','Candy, Chocolate, Cake, Sweets','CL799',NULL),
(10,'0010','BEVERAGES','coffee/tea, juice, soda','CL799',NULL),
(11,'0011','DRY/BAKING GOODS','cereals, flour, sugar, pasta, mixes, noodles','CL799',NULL),
(12,'0012','CLEANERS','all- purpose, laundry detergent, dishwashing liquid/detergent','CL799',NULL),
(13,'0013','PAPER GOODS','paper towels, toilet paper, aluminum foil, sandwich bags','CL799',NULL),
(14,'0014','PERSONAL CARE & TOILETRIES','shampoo, soap, hand soap, shaving cream','CL799',NULL),
(15,'0015','OTHER','baby items, pet items, batteries, greeting cards','CL799',NULL),
(16,'0016','PHARMACY','N/A','CL799',NULL),
(18,'0018','CROCKERIES','China Ceramics, Glass, Teflons, Plastics Type Kitchen Accessories','CL799',NULL),
(19,'0019','GIFT ITEMS','Nick Nacks','CL799',NULL),
(20,'0020','ELECTRONICS','Microwave oven, Electric Iron and others','CL799',NULL),
(29,'0029','ARTS AND CRAFTS','N/A','CL799',NULL),
(30,'0030','STATIONERY','N/A','CL799',NULL),
(31,'0031','INSTANT PRODUCTS','Powder','CL799',NULL),
(32,'0032','CHIPS AND PACKAGED PRODUCTS','N/A','CL799',NULL);

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
(1,'MAN00001','TRANSCOM BEVERAGES LTD. (TBL)','FACTORY ADDRESS: KALIAKOIR, GAZIPUR, BANGLADESH.\nHEAD OFFICE CONTACT:\nPLOT# 31, ROAD# 53, GULSHAN NORTH C.A, GULSHAN-2, DHAKA-1212','TRANSCOM BEVERAGES LTD. (TBL)','test@email.com','38754683','TRANSCOM BEVERAGES LTD. (TBL)','No Comments','2021-01-26','ADMIN',1,'CL799',NULL),
(2,'MAN00002','SQUARE FOOD & BEVERAGE LTD. (SFBL)','SQUARE CENTRE (6TH FLOOR), 48, MOHAKHALI CA, DHAKA-1212, BANGLADESH.\nPHONE: 88-02-8833047-56 [TEN LINES] | FAX: 88-02-8835394','TIEN ANMEN','djxs362@gmail.com','8802883304756','SQUARE FOOD & BEVERAGE LTD. (SFBL)','op','2021-01-26','ADMIN',1,'CL799',NULL),
(3,'MAN00003','AKIJ FOOD AND BEVERAGE LTD. (AFBL)','AKIJ HOUSE, 198 BIR UTTAM, MIR SHAWKAT SARAK, GULSHAN LINK ROAD, TEJGAON, DHAKA-1208','AKIJ FOOD AND BEVERAGE LTD. (AFBL)','info@akij.net','8809613116609','AKIJ FOOD AND BEVERAGE LTD. (AFBL)','No Comments','2021-01-26','ADMIN',1,'CL799',NULL),
(4,'MAN00004','PARTEX BEVERAGE LTD.','74 BIR UTTAM A.K. KHANDAKER SARAK,\nMOHAKHALI, DHAKA – 1212, BANGLADESH\nPHONE: +880 2 8822888 | FAX: +880 2 8821888 | E-MAIL: MAILBOX@PARTEX.NET','TIEN ANMEN','t@m.com','01719590478','PARTEX BEVERAGE LTD.','op','2021-01-26','ADMIN',1,'CL799',NULL),
(5,'MAN00005','PRAN FOODS LTD.','105, PROGOTI SARANI MIDDLE BADDA, DHAKA 1212, BANGLADESH.\nPHONE: 09613-737777','PRAN FOODS LTD.','neroalam@gmail.com','01719590478','PRAN FOODS LTD.','op','2021-01-26','ADMIN',1,'CL799',NULL),
(6,'MAN00006','ACI FOODS LTD.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','ACI FOODS LTD.','t@m.com','04579624228','ACI FOODS LTD.','op','2021-01-26','ADMIN',1,'CL799',NULL),
(7,'MAN00007','IFAD MULTI PRODUCTS LTD.','NASIR TRADE CENTER NASIR TRADE CENTER,\n89 BIR UTTAM, CR DUTTA ROAD. DHAKA 1205.\nEMAIL: IMPL@IFADGROUP.COM | PHONE: +01980002134','IFAD MULTI PRODUCTS LTD.','t@m.com','01719590478','IFAD MULTI PRODUCTS LTD.','op','2021-01-26','ADMIN',1,'CL799',NULL),
(8,'MAN00008','FU-WANG FOODS LTD.','HOUSE: 55, ROAD: 17, BANANI C/A, DHAKA-1213\nTEL: 58815476, 9887359, 9887360,9889958,9889864\nFAX: 880-02-9847451 | E-MAIL: INFO@FUWANGFOODSLTD.COM','FU-WANG FOODS LTD.','t@m.com','04579624228','FU-WANG FOODS LTD.','op','2021-01-26','ADMIN',1,'CL799',NULL),
(9,'MAN00009','ISPAHANI FOODS LTD.','THE ALLIANCE BUILDING (3RD FLOOR)\n63/KA, PRAGATI SHARANI, BARIDHARA, DHAKA-1212, BANGLADESH.\nPHONE : +88 02 55048375, +88 01755644002','ISPAHANI FOODS LTD.','lobotobo@gmail.com','01247854698','ISPAHANI FOODS LTD.','op','2021-01-26','ADMIN',1,'CL799',NULL),
(10,'MAN00010','BOMBAY SWEETS & CO. LTD.','DELTA LIFE TOWER(8TH FLOOR),\n37, GULSHAN NORTH C/A, ROAD NO#90, GULSHAN -2, DHAKA-1213, BANGLADESH.\nPHONE : 9893800-1, 9896800, 9897100| FAX : 880-2-9893077, 8814780','BOMBAY SWEETS & CO. LTD.','t@m.com','9896800','BOMBAY SWEETS & CO. LTD.','op','2021-02-09','ADMIN',1,'CL799',NULL),
(11,'MAN00011','UNILEVER INC.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','UNILEVER INC.','Unlilever@uni.com','01247854698','UNILEVER INC.','op','2021-01-26','ADMIN',1,'CL799',NULL),
(12,'MAN00012','NESTLE FOODS LTD.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','NESTLE FOODS LTD.','lobotobo@gmail.com','6549651986','NESTLE FOODS LTD.','op','2021-01-26','ADMIN',1,'CL799',NULL),
(13,'MAN00013','SAJEEB GROUP OF COMPANIES','SHEZAN POINT (LEVEL 6), 2 INDIRA ROAD, FARMGATE, DHAKA 1215, BANGLADESH','ISLAM AMAN','info@sajeebgroup.com.bd','88029116944','SAJEEB GROUP OF COMPANIES','op','2021-02-10','ADMIN',1,'CL799',NULL),
(14,'MAN00014','BOMBAY SWEETS & CO. LTD.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','BABU BOMBAY','BBAY@KU.com','0254687445','BOMBAY SWEETS & CO. LTD.','56 BIHAR','2021-02-11','ADMIN',1,'CL799',NULL),
(15,'MAN00015','OTHERS','OTHERS','OTHERS','Others@gmail.com','0000000','OTHERS','Others','2021-02-11','ADMIN',1,'CL799',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `pos_log` */

insert  into `pos_log`(`id`,`supplier_code`,`customer_code`,`manufacturer_code`,`category_code`,`product_code`,`invoice_no`,`transaction_id`,`client_code`,`trade_code`) values 
(1,'SUP00009',NULL,'MAN00015','0032','00040037',NULL,'TRX000000001','CL799',NULL);

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `product_event_info` */

insert  into `product_event_info`(`id`,`transaction_id`,`transaction_type`,`invoice`,`entry_date`,`customer_name`,`supplier_name`,`customer_code`,`supplier_code`,`cr_discount_percent`,`cr_discount`,`cr_amount`,`cr_total`,`dr_discount_percent`,`dr_discount`,`dr_amount`,`dr_total`,`user_id`,`client_code`,`entry_time`,`trade_code`) values 
(1,'IPZ5GIREICDN','PURCHASE','INV0221M9MLGQ1','2021-02-24',NULL,'MD. SHAHIDUZZAMAN',NULL,'SUP00001',0.00,0.00,0.00,0.00,0.00,200.00,114100.00,113900.00,'ADMIN','CL799','0001-01-01 00:00:00',NULL),
(2,'DFD8S0H54I7G','SALE','INV02219C6KLWZ','2021-02-24',NULL,NULL,NULL,NULL,0.00,100.00,1520.00,1420.00,0.00,0.00,0.00,0.00,'ADMIN','CL799','2021-02-24 11:43:16',NULL),
(3,'D9Z8CAUXTG8K','SALE','INV0221MFYB242','2021-02-24',NULL,NULL,NULL,NULL,0.00,10.00,260.00,250.00,0.00,0.00,0.00,0.00,'ADMIN','CL799','2021-02-24 11:47:32',NULL),
(4,'OHXFK97FFZRZ','SALE','INV0221XZHHM9L','2021-02-24',NULL,NULL,NULL,NULL,0.00,10.00,520.00,510.00,0.00,0.00,0.00,0.00,'ADMIN','CL799','2021-02-24 12:09:40',NULL),
(5,'6Q7JAG79P5HN','SALE','INV0221PPDFGRS','2021-02-24',NULL,NULL,NULL,NULL,0.00,10.00,260.00,250.00,0.00,0.00,0.00,0.00,'ADMIN','CL799','2021-02-24 12:28:07',NULL),
(6,'XEYDUKLJ2CVO','SALE','INV0221UGWBKVD','2021-02-24',NULL,NULL,NULL,NULL,0.00,15.00,3990.00,3975.00,0.00,0.00,0.00,0.00,'ADMIN','CL799','2021-02-24 14:59:57',NULL),
(7,'JVSFT0IOFOSU','SALE','2102IGWNI7D','2021-02-24',NULL,NULL,NULL,NULL,0.00,0.00,13000.00,13000.00,0.00,0.00,0.00,0.00,'ADMIN','CL799','2021-02-24 16:02:39',NULL),
(8,'LXKHV6F0YRWV','PURCHASE','21023HTEVXQ','2021-02-24',NULL,'MD. MIZANUR RAHMAN',NULL,'SUP00005',0.00,0.00,0.00,0.00,0.00,170.00,25170.00,25000.00,'ADMIN','CL799','0001-01-01 00:00:00',NULL),
(9,'5DNCR5X7OQJX','SALE','21027HIMAKK','2021-02-24',NULL,NULL,NULL,NULL,0.00,0.00,300.00,300.00,0.00,0.00,0.00,0.00,'ADMIN','CL799','2021-02-24 16:52:04',NULL),
(10,'Z5KASYH37L8E','PURCHASE','2102BH37ODK','2021-02-24',NULL,'MD. MIZANUR RAHMAN',NULL,'SUP00005',0.00,0.00,0.00,0.00,0.00,2000.00,55000.00,53000.00,'ADMIN','CL799','0001-01-01 00:00:00',NULL),
(11,'MD4R5BFR8W4W','SALE','2102NOXQX4H','2021-02-27',NULL,NULL,NULL,NULL,0.00,10.00,1110.00,1100.00,0.00,0.00,0.00,0.00,'ADMIN','CL799','2021-02-27 10:15:52',NULL),
(15,'QCH70HGV2R4E','SALE','2102WF5P487','2021-02-27',NULL,NULL,NULL,NULL,0.00,0.00,330.00,330.00,0.00,0.00,0.00,0.00,'ADMIN','CL799','2021-02-27 15:02:29',NULL),
(16,'QCH70HGV2R4E','CASH','2102WF5P487','2021-02-27',NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,0.00,0.00,330.00,330.00,'ADMIN','CL799','2021-02-27 15:02:29',NULL),
(18,'ND30B8UI4RIM','PURCHASE','21027N34BC2','2021-02-27',NULL,'MD. ATIAR RAHMAN ',NULL,'SUP00004',0.00,0.00,0.00,0.00,0.00,0.00,15600.00,15600.00,'ADMIN','CL799','0001-01-01 00:00:00',NULL),
(19,'ND30B8UI4RIM','CASH','21027N34BC2','2021-02-27',NULL,'MD. ATIAR RAHMAN ',NULL,'SUP00004',0.00,0.00,15600.00,15600.00,0.00,0.00,0.00,0.00,'ADMIN','CL799','0001-01-01 00:00:00',NULL),
(20,'I3J2I2UFWS46','CASH','2102H663KQT','2021-02-27',NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,0.00,30.00,6605.00,6575.00,'ADMIN','CL799','2021-02-27 16:33:29',NULL),
(21,'I3J2I2UFWS46','SALE','2102H663KQT','2021-02-27',NULL,NULL,NULL,NULL,0.00,30.00,6605.00,6575.00,0.00,0.00,0.00,0.00,'ADMIN','CL799','2021-02-27 16:33:29',NULL),
(22,'42VWRGSO2IF2','SALE','2103YAFLIMJ','2021-03-01',NULL,NULL,NULL,NULL,10.00,218.60,2186.00,1967.40,0.00,0.00,0.00,0.00,'ADMIN','CL799','2021-03-01 14:49:47',NULL),
(23,'42VWRGSO2IF2','CASH','2103YAFLIMJ','2021-03-01',NULL,NULL,NULL,NULL,10.00,0.00,0.00,0.00,10.00,218.60,2186.00,1967.40,'ADMIN','CL799','2021-03-01 14:49:47',NULL);

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
(1,'00010022','PRAN SALTY SALTED BISCUIT 100 GM',NULL,'Pc',100.00,11.00,89.00,135.00,200.00,'N/A',20.00,'BISCUITS','000108','BREAD & BAKERY','0001',1,'MAN00005','PRAN FOODS LTD.',NULL,NULL,'CL799','00010022','2021-03-05',NULL),
(2,'00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM',NULL,'Pc',50.00,3.00,47.00,300.00,330.00,'N/A',15.00,'BISCUITS','000108','BREAD & BAKERY','0001',1,'MAN00013','SAJEEB GROUP OF COMPANIES',NULL,NULL,'CL799','00010023','2021-02-28',NULL),
(3,'00080024','MARKS FULL CREAM MILK POWDER 1000 GM TIN',NULL,'Pc',0.00,0.00,0.00,700.00,890.00,'N/A',15.00,NULL,NULL,'FROZEN FOODS','0008',1,'MAN00012','NESTLE FOODS LTD.',NULL,NULL,'CL799','00080024','2021-02-21',NULL),
(4,'00080025','KAZI FARMS PARATHA 10PCS 650 GM',NULL,'Pc',20.00,0.00,20.00,80.00,100.00,'N/A',90.00,'FROZEN FOOD','000802','FROZEN FOODS','0008',1,'MAN00007','IFAD MULTI PRODUCTS LTD.',NULL,NULL,'CL799','00080025','2021-02-28',NULL),
(5,'00300026','ZINIX METAL PERMANENT MARKER MP501',NULL,'Pc',0.00,0.00,0.00,20.00,35.00,'N/A',50.00,'PEN','003001','STATIONERY','0030',1,'MAN00015','OTHERS',NULL,NULL,'CL799','00300026','0001-01-01',NULL),
(6,'00070027','POTATO 10KG PACKET',NULL,'Pc',379.00,127.00,252.00,250.00,260.00,'N/A',50.00,'POTATOES','000704','PRODUCES','0007',1,'MAN00015','OTHERS',NULL,NULL,'CL799','00070027','2021-02-28',NULL),
(7,'00030028','PRAN TOMATO SAUCE',NULL,'Pc',320.00,5.00,315.00,80.00,90.00,'N/A',80.00,'SAUCES','000302','OILS, SAUCES & CONDIMENTS','0003',1,'MAN00005','PRAN FOODS LTD.',NULL,NULL,'CL799','00030028','2021-03-13',NULL),
(8,'00030029','PRAN SOYA SAUCE',NULL,'Pc',0.00,0.00,0.00,110.00,130.00,'N/A',50.00,'OILS','000301','OILS, SAUCES & CONDIMENTS','0003',1,'MAN00005','PRAN FOODS LTD.',NULL,NULL,'CL799','00030029','2021-02-28',NULL),
(9,'00110030','IFAD NOODLES',NULL,'Pc',96.00,50.00,46.00,30.00,35.00,'N/A',50.00,'NOODLES','001107','DRY/BAKING GOODS','0011',1,'MAN00007','IFAD MULTI PRODUCTS LTD.',NULL,NULL,'CL799','00110030','2021-02-28',NULL),
(10,'00040031','CHASHI RICE (50 KGS)',NULL,'Pc',0.00,0.00,0.00,1800.00,1950.00,'N/A',20.00,'RICE','000401','RICE, LENTIL & DRIED LEGUMES ','0004',1,'MAN00007','IFAD MULTI PRODUCTS LTD.',NULL,NULL,'CL799','00040031','2021-02-28',NULL),
(11,'00090032','CADBURY DAIRY MILK SILK CHOCOLATE 60±5 GM*',NULL,'Pc',56.00,1.00,55.00,90.00,100.00,'N/A',50.00,'CHOCOLATES','000902','CONFECTIONARY','0009',1,'MAN00012','NESTLE FOODS LTD.',NULL,NULL,'CL799','00090032','2020-12-24',NULL),
(12,'00090033','FOXS CRYSTAL CLEAR PASSIAR MINTS 180G',NULL,'Pc',56.00,2.00,54.00,250.00,280.00,'N/A',50.00,'CANDY','000901','CONFECTIONARY','0009',1,'MAN00015','OTHERS',NULL,NULL,'CL799','00090033','2021-02-28',NULL),
(13,'00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS',NULL,'Pc',50.00,3.00,47.00,700.00,895.00,'N/A',50.00,'BABY ITEMS','001501','OTHER','0015',1,'MAN00015','OTHERS',NULL,NULL,'CL799','00150034','0001-01-01',NULL),
(14,'00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER',NULL,'Pc',100.00,2.00,98.00,180.00,200.00,'N/A',50.00,'SHAMPOO','001401','PERSONAL CARE & TOILETRIES','0014',1,'MAN00015','OTHERS',NULL,NULL,'CL799','00140035','2021-02-28',NULL),
(15,'6971141390616','PLEXTONE BLACK MOWI',NULL,'Pc',58.00,4.00,54.00,700.00,850.00,'N/A',20.00,'HAIR DRYER','002003','ELECTRONICS','0020',1,'MAN00015','OTHERS',NULL,NULL,'CL799','6971141390616','0001-01-01',NULL),
(16,'00040037','RICE 10 KG',NULL,'Pc',0.00,0.00,0.00,60.00,65.00,'N/A',500.00,'LENTIL','000402','RICE, LENTIL & DRIED LEGUMES ','0004',1,'MAN00015','OTHERS',NULL,NULL,'CL799','00040037','0001-01-01',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `product_stock` */

insert  into `product_stock`(`id`,`product_code`,`product_name`,`manufacturer_code`,`opening_stock`,`quantity_in`,`quantity_out`,`closing_stock`,`unit_price`,`mrp_price`,`expire_date`,`entry_date`,`user_id`,`batch_no`,`client_code`,`barcode`,`trade_code`) values 
(1,'00070027','POTATO 10KG PACKET','MAN00015',0.00,369.00,74.00,295.00,250.00,260.00,'2021-02-28','2021-02-24','ADMIN',NULL,'CL799','00070027',NULL),
(2,'00030028','PRAN TOMATO SAUCE','MAN00005',0.00,320.00,1.00,319.00,80.00,90.00,'0001-01-01','2021-02-24','ADMIN',NULL,'CL799','00030028',NULL),
(3,'00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',0.00,100.00,3.00,97.00,135.00,200.00,'0001-01-01','2021-02-24','ADMIN',NULL,'CL799','00010022',NULL),
(4,'00090032','CADBURY DAIRY MILK SILK CHOCOLATE 60±5 GM*','MAN00012',0.00,56.00,1.00,55.00,90.00,100.00,'0001-01-01','2021-02-24','ADMIN',NULL,'CL799','00090032',NULL),
(5,'00110030','IFAD NOODLES','MAN00007',0.00,96.00,0.00,96.00,30.00,35.00,'2021-02-28','2021-02-24','ADMIN',NULL,'CL799','00110030',NULL),
(6,'6971141390616','PLEXTONE BLACK MOWI','MAN00015',0.00,58.00,0.00,58.00,700.00,850.00,'0001-01-01','2021-02-24','ADMIN',NULL,'CL799','6971141390616',NULL),
(7,'00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER','MAN00015',0.00,80.00,0.00,80.00,180.00,200.00,'0001-01-01','2021-02-24','ADMIN',NULL,'CL799','00140035',NULL),
(8,'00070027','POTATO 10KG PACKET','MAN00015',295.00,10.00,51.00,254.00,250.00,260.00,'0001-01-01','2021-02-27','ADMIN',NULL,'CL799','00070027',NULL),
(9,'6971141390616','PLEXTONE BLACK MOWI','MAN00015',58.00,0.00,4.00,54.00,700.00,850.00,'0001-01-01','2021-02-27','ADMIN',NULL,'CL799','6971141390616',NULL),
(10,'00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',0.00,50.00,2.00,48.00,300.00,330.00,'0001-01-01','2021-02-27','ADMIN',NULL,'CL799','00010023',NULL),
(11,'00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS','MAN00015',0.00,50.00,3.00,47.00,700.00,895.00,'0001-01-01','2021-02-27','ADMIN',NULL,'CL799','00150034',NULL),
(12,'00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER','MAN00015',0.00,20.00,2.00,18.00,180.00,200.00,'0001-01-01','2021-02-27','ADMIN',NULL,'CL799','00140035',NULL),
(13,'00090033','FOXS CRYSTAL CLEAR PASSIAR MINTS 180G','MAN00015',0.00,56.00,2.00,54.00,250.00,280.00,'0001-01-01','2021-02-27','ADMIN',NULL,'CL799','00090033',NULL),
(14,'00080025','KAZI FARMS PARATHA 10PCS 650 GM','MAN00007',0.00,20.00,0.00,20.00,80.00,100.00,'2021-02-28','2021-02-27','ADMIN',NULL,'CL799','00080025',NULL),
(15,'00030028','PRAN TOMATO SAUCE','MAN00005',97.00,0.00,4.00,93.00,80.00,90.00,'0001-01-01','2021-02-27','ADMIN',NULL,'CL799','00030028',NULL),
(16,'00110030','IFAD NOODLES','MAN00007',97.00,0.00,50.00,47.00,30.00,35.00,'0001-01-01','2021-02-27','ADMIN',NULL,'CL799','00110030',NULL),
(17,'00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',97.00,0.00,8.00,89.00,135.00,200.00,'0001-01-01','2021-03-01','ADMIN',NULL,'CL799','00010022',NULL),
(18,'00070027','POTATO 10KG PACKET','MAN00015',97.00,0.00,2.00,95.00,250.00,260.00,'0001-01-01','2021-03-01','ADMIN',NULL,'CL799','00070027',NULL),
(19,'00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',97.00,0.00,1.00,96.00,300.00,330.00,'0001-01-01','2021-03-01','ADMIN',NULL,'CL799','00010023',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `product_stock_in` */

insert  into `product_stock_in`(`id`,`transaction_id`,`product_code`,`product_name`,`manufacturer_code`,`supplier_code`,`quantity`,`unit_price`,`total_price`,`mrp_price`,`expire_date`,`entry_date`,`invoice`,`user_id`,`batch_no`,`client_code`,`barcode`,`trade_code`,`discount_percentage`,`discount`) values 
(1,'IPZ5GIREICDN','00070027','POTATO 10KG PACKET','MAN00015','SUP00001',300.00,250.00,75000.00,260.00,'2021-03-11','2021-02-24','INV0221M9MLGQ1','ADMIN',NULL,'CL799','00070027',NULL,NULL,NULL),
(2,'IPZ5GIREICDN','00030028','PRAN TOMATO SAUCE','MAN00005','SUP00001',320.00,80.00,25600.00,90.00,'2021-03-13','2021-02-24','INV0221M9MLGQ1','ADMIN',NULL,'CL799','00030028',NULL,NULL,NULL),
(3,'IPZ5GIREICDN','00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005','SUP00001',100.00,135.00,13500.00,200.00,'2021-03-05','2021-02-24','INV0221M9MLGQ1','ADMIN',NULL,'CL799','00010022',NULL,NULL,NULL),
(4,'LXKHV6F0YRWV','00090032','CADBURY DAIRY MILK SILK CHOCOLATE 60±5 GM*','MAN00012','SUP00005',56.00,90.00,5040.00,100.00,'2020-12-24','2021-02-24','21023HTEVXQ','ADMIN',NULL,'CL799','00090032',NULL,NULL,NULL),
(5,'LXKHV6F0YRWV','00110030','IFAD NOODLES','MAN00007','SUP00005',96.00,30.00,2880.00,35.00,'2021-02-28','2021-02-24','21023HTEVXQ','ADMIN',NULL,'CL799','00110030',NULL,NULL,NULL),
(6,'LXKHV6F0YRWV','00070027','POTATO 10KG PACKET','MAN00015','SUP00005',69.00,250.00,17250.00,260.00,'2021-02-28','2021-02-24','21023HTEVXQ','ADMIN',NULL,'CL799','00070027',NULL,NULL,NULL),
(7,'Z5KASYH37L8E','6971141390616','PLEXTONE BLACK MOWI','MAN00015','SUP00005',58.00,700.00,40600.00,850.00,'0001-01-01','2021-02-24','2102BH37ODK','ADMIN',NULL,'CL799','6971141390616',NULL,NULL,NULL),
(8,'Z5KASYH37L8E','00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER','MAN00015','SUP00005',80.00,180.00,14400.00,200.00,'0001-01-01','2021-02-24','2102BH37ODK','ADMIN',NULL,'CL799','00140035',NULL,NULL,NULL),
(9,'OVO4JLNG6L10','00070027','POTATO 10KG PACKET','MAN00015','SUP00002',10.00,250.00,2500.00,260.00,'2021-02-28','2021-02-27','2102053UZGK','ADMIN',NULL,'CL799','00070027',NULL,NULL,NULL),
(10,'OVO4JLNG6L10','00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013','SUP00002',50.00,300.00,15000.00,330.00,'2021-02-28','2021-02-27','2102053UZGK','ADMIN',NULL,'CL799','00010023',NULL,NULL,NULL),
(11,'5IIIHZZGRGB6','00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS','MAN00015','SUP00003',50.00,700.00,35000.00,895.00,'0001-01-01','2021-02-27','2102YVCF9WO','ADMIN',NULL,'CL799','00150034',NULL,NULL,NULL),
(12,'5IIIHZZGRGB6','00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER','MAN00015','SUP00003',20.00,180.00,3600.00,200.00,'2021-02-28','2021-02-27','2102YVCF9WO','ADMIN',NULL,'CL799','00140035',NULL,NULL,NULL),
(13,'ND30B8UI4RIM','00090033','FOXS CRYSTAL CLEAR PASSIAR MINTS 180G','MAN00015','SUP00004',56.00,250.00,14000.00,280.00,'2021-02-28','2021-02-27','21027N34BC2','ADMIN',NULL,'CL799','00090033',NULL,NULL,NULL),
(14,'ND30B8UI4RIM','00080025','KAZI FARMS PARATHA 10PCS 650 GM','MAN00007','SUP00004',20.00,80.00,1600.00,100.00,'2021-02-28','2021-02-27','21027N34BC2','ADMIN',NULL,'CL799','00080025',NULL,NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

/*Data for the table `product_stock_out` */

insert  into `product_stock_out`(`id`,`transaction_id`,`product_code`,`product_name`,`manufacturer_code`,`customer_code`,`quantity`,`unit_price`,`discount_percentage`,`discount`,`total_price_deducted`,`total_price`,`mrp_price`,`expire_date`,`entry_date`,`invoice`,`user_id`,`batch_no`,`client_code`,`barcode`,`trade_code`) values 
(1,'DFD8S0H54I7G','00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',NULL,2.00,135.00,NULL,NULL,0.00,400.00,200.00,'0001-01-01','2021-02-24','INV02219C6KLWZ','ADMIN',NULL,'CL799','00010022',NULL),
(2,'DFD8S0H54I7G','00070027','POTATO 10KG PACKET','MAN00015',NULL,5.00,250.00,NULL,NULL,0.00,1300.00,260.00,'0001-01-01','2021-02-24','INV02219C6KLWZ','ADMIN',NULL,'CL799','00070027',NULL),
(3,'D9Z8CAUXTG8K','00070027','POTATO 10KG PACKET','MAN00015',NULL,1.00,250.00,NULL,NULL,0.00,260.00,260.00,'0001-01-01','2021-02-24','INV0221MFYB242','ADMIN',NULL,'CL799','00070027',NULL),
(4,'OHXFK97FFZRZ','00070027','POTATO 10KG PACKET','MAN00015',NULL,2.00,250.00,NULL,NULL,0.00,520.00,260.00,'0001-01-01','2021-02-24','INV0221XZHHM9L','ADMIN',NULL,'CL799','00070027',NULL),
(5,'6Q7JAG79P5HN','00070027','POTATO 10KG PACKET','MAN00015',NULL,1.00,250.00,NULL,NULL,0.00,260.00,260.00,'0001-01-01','2021-02-24','INV0221PPDFGRS','ADMIN',NULL,'CL799','00070027',NULL),
(6,'XEYDUKLJ2CVO','00070027','POTATO 10KG PACKET','MAN00015',NULL,15.00,250.00,NULL,NULL,0.00,3900.00,260.00,'0001-01-01','2021-02-24','INV0221UGWBKVD','ADMIN',NULL,'CL799','00070027',NULL),
(7,'XEYDUKLJ2CVO','00030028','PRAN TOMATO SAUCE','MAN00005',NULL,1.00,80.00,NULL,NULL,0.00,90.00,90.00,'0001-01-01','2021-02-24','INV0221UGWBKVD','ADMIN',NULL,'CL799','00030028',NULL),
(8,'JVSFT0IOFOSU','00070027','POTATO 10KG PACKET','MAN00015',NULL,50.00,250.00,NULL,NULL,0.00,13000.00,260.00,'0001-01-01','2021-02-24','2102IGWNI7D','ADMIN',NULL,'CL799','00070027',NULL),
(9,'5DNCR5X7OQJX','00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',NULL,1.00,135.00,NULL,NULL,0.00,200.00,200.00,'0001-01-01','2021-02-24','21027HIMAKK','ADMIN',NULL,'CL799','00010022',NULL),
(10,'5DNCR5X7OQJX','00090032','CADBURY DAIRY MILK SILK CHOCOLATE 60±5 GM*','MAN00012',NULL,1.00,90.00,NULL,NULL,0.00,100.00,100.00,'0001-01-01','2021-02-24','21027HIMAKK','ADMIN',NULL,'CL799','00090032',NULL),
(11,'MD4R5BFR8W4W','00070027','POTATO 10KG PACKET','MAN00015',NULL,1.00,250.00,NULL,NULL,0.00,260.00,260.00,'0001-01-01','2021-02-27','2102NOXQX4H','ADMIN',NULL,'CL799','00070027',NULL),
(12,'MD4R5BFR8W4W','6971141390616','PLEXTONE BLACK MOWI','MAN00015',NULL,1.00,700.00,NULL,NULL,0.00,850.00,850.00,'0001-01-01','2021-02-27','2102NOXQX4H','ADMIN',NULL,'CL799','6971141390616',NULL),
(13,'9NQ59VBS1PR4','00070027','POTATO 10KG PACKET','MAN00015',NULL,50.00,250.00,NULL,NULL,0.00,13000.00,260.00,'0001-01-01','2021-02-27','2102863274J','ADMIN',NULL,'CL799','00070027',NULL),
(14,'9NQ59VBS1PR4','6971141390616','PLEXTONE BLACK MOWI','MAN00015',NULL,2.00,700.00,NULL,NULL,0.00,1700.00,850.00,'0001-01-01','2021-02-27','2102863274J','ADMIN',NULL,'CL799','6971141390616',NULL),
(15,'A91AVEEVMMUH','00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',NULL,1.00,300.00,NULL,NULL,0.00,330.00,330.00,'0001-01-01','2021-02-27','21021OZCH1C','ADMIN',NULL,'CL799','00010023',NULL),
(16,'QCH70HGV2R4E','00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',NULL,1.00,300.00,NULL,NULL,0.00,330.00,330.00,'0001-01-01','2021-02-27','2102WF5P487','ADMIN',NULL,'CL799','00010023',NULL),
(17,'I3J2I2UFWS46','00150034','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS','MAN00015',NULL,3.00,700.00,NULL,NULL,0.00,2685.00,895.00,'0001-01-01','2021-02-27','2102H663KQT','ADMIN',NULL,'CL799','00150034',NULL),
(18,'I3J2I2UFWS46','00090033','FOXS CRYSTAL CLEAR PASSIAR MINTS 180G','MAN00015',NULL,2.00,250.00,NULL,NULL,0.00,560.00,280.00,'0001-01-01','2021-02-27','2102H663KQT','ADMIN',NULL,'CL799','00090033',NULL),
(19,'I3J2I2UFWS46','00110030','IFAD NOODLES','MAN00007',NULL,50.00,30.00,NULL,NULL,0.00,1750.00,35.00,'0001-01-01','2021-02-27','2102H663KQT','ADMIN',NULL,'CL799','00110030',NULL),
(20,'I3J2I2UFWS46','00140035','TRESEMME HD HAIR FALL DEFENSE CONDITIONER','MAN00015',NULL,2.00,180.00,NULL,NULL,0.00,400.00,200.00,'0001-01-01','2021-02-27','2102H663KQT','ADMIN',NULL,'CL799','00140035',NULL),
(21,'I3J2I2UFWS46','00030028','PRAN TOMATO SAUCE','MAN00005',NULL,4.00,80.00,NULL,NULL,0.00,360.00,90.00,'0001-01-01','2021-02-27','2102H663KQT','ADMIN',NULL,'CL799','00030028',NULL),
(22,'I3J2I2UFWS46','6971141390616','PLEXTONE BLACK MOWI','MAN00015',NULL,1.00,700.00,NULL,NULL,0.00,850.00,850.00,'0001-01-01','2021-02-27','2102H663KQT','ADMIN',NULL,'CL799','6971141390616',NULL),
(23,'42VWRGSO2IF2','00010022','PRAN SALTY SALTED BISCUIT 100 GM','MAN00005',NULL,8.00,135.00,10.00,160.00,1440.00,1600.00,200.00,'0001-01-01','2021-03-01','2103YAFLIMJ','ADMIN',NULL,'CL799','00010022',NULL),
(24,'42VWRGSO2IF2','00070027','POTATO 10KG PACKET','MAN00015',NULL,2.00,250.00,20.00,104.00,416.00,520.00,260.00,'0001-01-01','2021-03-01','2103YAFLIMJ','ADMIN',NULL,'CL799','00070027',NULL),
(25,'42VWRGSO2IF2','00010023','TIFFANY SUGAR FREE LEMON CREAM BISCUITS 162 GM','MAN00013',NULL,1.00,300.00,0.00,0.00,330.00,330.00,330.00,'0001-01-01','2021-03-01','2103YAFLIMJ','ADMIN',NULL,'CL799','00010023',NULL);

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
(76,'000201','BEEF',NULL,'CL799','0002','MEAT & SEAFOOD',NULL),
(77,'000202','MUTTON',NULL,'CL799','0002','MEAT & SEAFOOD',NULL),
(78,'000203','LAMB',NULL,'CL799','0002','MEAT & SEAFOOD',NULL),
(79,'000204','CHICKEN',NULL,'CL799','0002','MEAT & SEAFOOD',NULL),
(80,'000205','FISH',NULL,'CL799','0002','MEAT & SEAFOOD',NULL),
(81,'000206','SHELLFISH',NULL,'CL799','0002','MEAT & SEAFOOD',NULL),
(82,'000207','SEAFOOD',NULL,'CL799','0002','MEAT & SEAFOOD',NULL),
(83,'000301','OILS',NULL,'CL799','0003','OILS, SAUCES & CONDIMENTS',NULL),
(84,'000302','SAUCES',NULL,'CL799','0003','OILS, SAUCES & CONDIMENTS',NULL),
(85,'000303','ESSENCE',NULL,'CL799','0003','OILS, SAUCES & CONDIMENTS',NULL),
(86,'000304','SPICES',NULL,'CL799','0003','OILS, SAUCES & CONDIMENTS',NULL),
(87,'000305','CONDIMENTS',NULL,'CL799','0003','OILS, SAUCES & CONDIMENTS',NULL),
(112,'000601','CHEESE',NULL,'CL799','0006','DAIRY & fARM PRODUCTS',NULL),
(113,'000602','MILK',NULL,'CL799','0006','DAIRY & fARM PRODUCTS',NULL),
(114,'000603','BUTTER',NULL,'CL799','0006','DAIRY & fARM PRODUCTS',NULL),
(115,'000604','YOGHURT',NULL,'CL799','0006','DAIRY & fARM PRODUCTS',NULL),
(116,'000605','GHEE',NULL,'CL799','0006','DAIRY & fARM PRODUCTS',NULL),
(117,'000606','CURD',NULL,'CL799','0006','DAIRY & fARM PRODUCTS',NULL),
(118,'000607','MILK PRODUCTS',NULL,'CL799','0006','DAIRY & fARM PRODUCTS',NULL),
(119,'000701','FRUITS',NULL,'CL799','0007','PRODUCES',NULL),
(120,'000702','VEGETABLES',NULL,'CL799','0007','PRODUCES',NULL),
(121,'000703','PLANTS',NULL,'CL799','0007','PRODUCES',NULL),
(122,'000704','POTATOES',NULL,'CL799','0007','PRODUCES',NULL),
(123,'000705','ONIONS',NULL,'CL799','0007','PRODUCES',NULL),
(124,'000706','GARLIC',NULL,'CL799','0007','PRODUCES',NULL),
(125,'000801','FROZEN MEAT',NULL,'CL799','0008','FROZEN FOODS',NULL),
(126,'000802','FROZEN FOOD',NULL,'CL799','0008','FROZEN FOODS',NULL),
(127,'000803','ICE-CREAM',NULL,'CL799','0008','FROZEN FOODS',NULL),
(128,'000901','CANDY',NULL,'CL799','0009','CONFECTIONARY',NULL),
(129,'000902','CHOCOLATES',NULL,'CL799','0009','CONFECTIONARY',NULL),
(130,'000903','CAKE',NULL,'CL799','0009','CONFECTIONARY',NULL),
(131,'000904','SWEETS',NULL,'CL799','0009','CONFECTIONARY',NULL),
(140,'001101','FLOUR',NULL,'CL799','0011','DRY/BAKING GOODS',NULL),
(141,'001102','ATTA',NULL,'CL799','0011','DRY/BAKING GOODS',NULL),
(142,'001103','SEMOLINA',NULL,'CL799','0011','DRY/BAKING GOODS',NULL),
(143,'001104','SUGAR',NULL,'CL799','0011','DRY/BAKING GOODS',NULL),
(144,'001105','SALT',NULL,'CL799','0011','DRY/BAKING GOODS',NULL),
(145,'001106','PASTA',NULL,'CL799','0011','DRY/BAKING GOODS',NULL),
(146,'001107','NOODLES',NULL,'CL799','0011','DRY/BAKING GOODS',NULL),
(147,'001108','MIXES',NULL,'CL799','0011','DRY/BAKING GOODS',NULL),
(148,'001109','CEREALS',NULL,'CL799','0011','DRY/BAKING GOODS',NULL),
(149,'001201','ALL- PURPOSE',NULL,'CL799','0012','CLEANERS',NULL),
(150,'001202','LAUNDRY DETERGENT',NULL,'CL799','0012','CLEANERS',NULL),
(151,'001203','DISHWASHING LIQUID/DETERGENT',NULL,'CL799','0012','CLEANERS',NULL),
(152,'001204','FLOOR/GLASS CLEANERS',NULL,'CL799','0012','CLEANERS',NULL),
(153,'001205','BLEACH',NULL,'CL799','0012','CLEANERS',NULL),
(154,'001301','PAPER TOWELS',NULL,'CL799','0013','PAPER GOODS',NULL),
(155,'001302','TOILET PAPER',NULL,'CL799','0013','PAPER GOODS',NULL),
(156,'001303','ALUMINUM FOIL',NULL,'CL799','0013','PAPER GOODS',NULL),
(157,'001304','SANDWICH BAGS',NULL,'CL799','0013','PAPER GOODS',NULL),
(158,'001401','SHAMPOO',NULL,'CL799','0014','PERSONAL CARE & TOILETRIES',NULL),
(159,'001402','SOAP',NULL,'CL799','0014','PERSONAL CARE & TOILETRIES',NULL),
(160,'001403','HAND SOAP',NULL,'CL799','0014','PERSONAL CARE & TOILETRIES',NULL),
(161,'001404','SHAVING CREAM',NULL,'CL799','0014','PERSONAL CARE & TOILETRIES',NULL),
(166,'001601','MEDICINE',NULL,'CL799','0016','PHARMACY',NULL),
(167,'001602','SYRUP',NULL,'CL799','0016','PHARMACY',NULL),
(168,'001603','BAND-AID',NULL,'CL799','0016','PHARMACY',NULL),
(169,'001801','CHINA CERAMICS',NULL,'CL799','0018','CROCKERIES',NULL),
(170,'001802','GLASS',NULL,'CL799','0018','CROCKERIES',NULL),
(171,'001803','TEFLONS',NULL,'CL799','0018','CROCKERIES',NULL),
(172,'001804','METAL',NULL,'CL799','0018','CROCKERIES',NULL),
(173,'001805','PLASTICS',NULL,'CL799','0018','CROCKERIES',NULL),
(174,'001901','GIFT CARDS',NULL,'CL799','0019','GIFT ITEMS',NULL),
(175,'001902','BALLONS',NULL,'CL799','0019','GIFT ITEMS',NULL),
(176,'001903','DECORATIONS',NULL,'CL799','0019','GIFT ITEMS',NULL),
(182,'000401','RICE',NULL,'CL799','0004','RICE, LENTIL & DRIED LEGUMES ',NULL),
(183,'000402','LENTIL',NULL,'CL799','0004','RICE, LENTIL & DRIED LEGUMES ',NULL),
(184,'000403','PULSE',NULL,'CL799','0004','RICE, LENTIL & DRIED LEGUMES ',NULL),
(185,'000404','BEANS',NULL,'CL799','0004','RICE, LENTIL & DRIED LEGUMES ',NULL),
(186,'000405','PEAS',NULL,'CL799','0004','RICE, LENTIL & DRIED LEGUMES ',NULL),
(187,'000406','NUTS',NULL,'CL799','0004','RICE, LENTIL & DRIED LEGUMES ',NULL),
(198,'002901','ART SUPPLY',NULL,'CL799','0029','ARTS AND CRAFTS',NULL),
(199,'003007','PENSTAND',NULL,'CL799','0030','STATIONERY',NULL),
(200,'003006','BOOKS',NULL,'CL799','0030','STATIONERY',NULL),
(201,'003005','SHARPNER',NULL,'CL799','0030','STATIONERY',NULL),
(202,'003004','ERASER',NULL,'CL799','0030','STATIONERY',NULL),
(203,'003003','PENCIL',NULL,'CL799','0030','STATIONERY',NULL),
(204,'003002','PAPER',NULL,'CL799','0030','STATIONERY',NULL),
(205,'003008','OFFICE SUPPLY',NULL,'CL799','0030','STATIONERY',NULL),
(206,'003001','PEN',NULL,'CL799','0030','STATIONERY',NULL),
(211,'001001','COFFEE',NULL,'CL799','0010','BEVERAGES',NULL),
(212,'001002','TEA',NULL,'CL799','0010','BEVERAGES',NULL),
(213,'001003','JUICE',NULL,'CL799','0010','BEVERAGES',NULL),
(214,'001004','CARBONATED BEVERAGES',NULL,'CL799','0010','BEVERAGES',NULL),
(215,'001005','WATER',NULL,'CL799','0010','BEVERAGES',NULL),
(216,'000101','SANDWITCH BREAD',NULL,'CL799','0001','BREAD & BAKERY',NULL),
(217,'000102','ROTI',NULL,'CL799','0001','BREAD & BAKERY',NULL),
(218,'000103','PARATHA',NULL,'CL799','0001','BREAD & BAKERY',NULL),
(219,'000104','BUNS',NULL,'CL799','0001','BREAD & BAKERY',NULL),
(220,'000105','BREAD',NULL,'CL799','0001','BREAD & BAKERY',NULL),
(221,'000106','ROLLS',NULL,'CL799','0001','BREAD & BAKERY',NULL),
(222,'000107','PASTRYS',NULL,'CL799','0001','BREAD & BAKERY',NULL),
(223,'000108','BISCUITS',NULL,'CL799','0001','BREAD & BAKERY',NULL),
(245,'003201','CHIPS',NULL,'CL799','0032','CHIPS AND PACKAGED PRODUCTS',NULL),
(246,'003202','POPCORN',NULL,'CL799','0032','CHIPS AND PACKAGED PRODUCTS',NULL),
(247,'003203','NUTS',NULL,'CL799','0032','CHIPS AND PACKAGED PRODUCTS',NULL),
(248,'003204','DALMUT',NULL,'CL799','0032','CHIPS AND PACKAGED PRODUCTS',NULL),
(249,'003205','DRY SNACKS',NULL,'CL799','0032','CHIPS AND PACKAGED PRODUCTS',NULL),
(250,'000501','JAM',NULL,'CL799','0005','TIN CANNED/JARRED GOODS',NULL),
(251,'000502','JELLY',NULL,'CL799','0005','TIN CANNED/JARRED GOODS',NULL),
(252,'000503','VINEGAR',NULL,'CL799','0005','TIN CANNED/JARRED GOODS',NULL),
(253,'000504','CANNED FRUITS',NULL,'CL799','0005','TIN CANNED/JARRED GOODS',NULL),
(254,'000505','CANNED VEGETABLES',NULL,'CL799','0005','TIN CANNED/JARRED GOODS',NULL),
(255,'000506','PICKLES',NULL,'CL799','0005','TIN CANNED/JARRED GOODS',NULL),
(256,'000507','CAN',NULL,'CL799','0005','TIN CANNED/JARRED GOODS',NULL),
(257,'003101','COFFEE',NULL,'CL799','0031','INSTANT PRODUCTS',NULL),
(258,'003102','SOUP',NULL,'CL799','0031','INSTANT PRODUCTS',NULL),
(259,'003103','JUICE POWDER',NULL,'CL799','0031','INSTANT PRODUCTS',NULL),
(260,'003104','JELLY POWDER',NULL,'CL799','0031','INSTANT PRODUCTS',NULL),
(261,'003105','ICING SUGAR',NULL,'CL799','0031','INSTANT PRODUCTS',NULL),
(262,'003106','MILK POWDER',NULL,'CL799','0031','INSTANT PRODUCTS',NULL),
(263,'002001','MICROWAVE OVEN',NULL,'CL799','0020','ELECTRONICS',NULL),
(264,'002002','ELECTRIC IRON ',NULL,'CL799','0020','ELECTRONICS',NULL),
(265,'002003','HAIR DRYER',NULL,'CL799','0020','ELECTRONICS',NULL),
(266,'002004','CURLING IRON',NULL,'CL799','0020','ELECTRONICS',NULL),
(267,'002005','KETTLE',NULL,'CL799','0020','ELECTRONICS',NULL),
(273,'001501','BABY ITEMS',NULL,'CL799','0015','OTHER',NULL),
(274,'001502','PET ITEMS',NULL,'CL799','0015','OTHER',NULL),
(275,'001503','BATTERIES',NULL,'CL799','0015','OTHER',NULL),
(276,'001504','GREETING CARDS',NULL,'CL799','0015','OTHER',NULL),
(277,'001505','TOYS',NULL,'CL799','0015','OTHER',NULL);

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
(3,'SUP00001','MD. SHAHIDUZZAMAN','SHAHID TRADERS','TALKONA','DHAKA','MADARIPUR','SHIBCHAR','019675347','tanjin@email.com',1,'Nothing','2021-01-26','ADMIN','CL799',NULL),
(4,'SUP00002','MD. MOAZZEM HOSSAIN','ZEM FOODS','BASHABO','DHAKA','DHAKA','SABUJBAGH','016575446','gh@email.com',1,'Nothing','2021-01-26','ADMIN','CL799',NULL),
(5,'SUP00003','SUMON MEHEDI','MEHEDI CORP.','BASHABO','DHAKA','DHAKA','SABUJBAGH','015675755','nf@email.com',1,'Nothing','2021-01-26','ADMIN','CL799',NULL),
(6,'SUP00004','MD. ATIAR RAHMAN ','LIJAN TRADERS','JBN','DHAKA','DHAKA','SHAH ALI','015657455','yt3245@email.com',1,'Nothing','2021-02-11','ADMIN','CL799',NULL),
(7,'SUP00005','MD. MIZANUR RAHMAN','ZAN TRADERS','BASHABO','DHAKA','DHAKA','SABUJBAGH','012355757','kj3456@email.com',1,'Nothing','2021-01-26','ADMIN','CL799',NULL),
(8,'SUP00006','MUHAMMAD MASUM BILLAH','BILLAH & BILLAH','BASHABO','DHAKA','DHAKA','SABUJBAGH','015767566','poi46467@email.com',1,'Nothing','2021-01-26','ADMIN','CL799',NULL),
(9,'SUP00007','MD GOLAM ROBBANI','ROBBA BAKERY','SHONKOR','DHAKA','DHAKA','DHANMONDI','0165489653','sobuj@molla.com',1,'Nothing Important','2021-01-26','ADMIN','CL799',NULL),
(11,'SUP00008','MD. MOZIBOR RAHMAN','RAHMAN LTD.','JANATA TOWER','DHAKA','DHAKA','TEJGAON','0195736823','nice@nice.com',0,'asdfsdfasdgfdg','2021-01-26','ADMIN','CL799',NULL),
(12,'SUP00009','REZAUL AZAM FARUQUI','AZAM INC.','RESHAT','RANGPUR','NILPHAMARI','NILPHAMARI SADAR','01478796548','t@m.com',1,'Nice','2021-01-26','ADMIN','CL799',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`first_name`,`last_name`,`email`,`user_type`,`phone`,`status`,`user_id`,`added_by`,`add_date`,`client_code`,`trade_code`) values 
(46,'IKBAL','NAYEM','ikbal.nayem@gmail.com','ADMIN','01725486954',1,'e95a3a1b-45f5-432a-970b-372687e361aa',NULL,'2021-03-01 00:00:00',NULL,NULL);

/*Table structure for table `z_control_type` */

DROP TABLE IF EXISTS `z_control_type`;

CREATE TABLE `z_control_type` (
  `id` int NOT NULL,
  `control_type` varchar(15) DEFAULT NULL,
  `c_type` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `z_control_type` */

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
