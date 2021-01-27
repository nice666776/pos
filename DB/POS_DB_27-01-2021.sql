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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `category_info` */

insert  into `category_info`(`id`,`code`,`name`,`description`,`client_code`) values 
(1,'0001','BAKERY & BREAD','Baked Items',NULL),
(2,'0002','MEAT & SEAFOOD','Raw ',NULL),
(3,'0003','OILS, SAUCES & CONDIMENTS','Related',NULL),
(4,'0004','RICE, LENTIL & DRIED LEGUMES ','food',NULL),
(5,'0005','CANNED GOODS','N/A',NULL),
(6,'0006','DAIRY PRODUCTS','N/A',NULL),
(7,'0007','PRODUCE','N/A',NULL),
(8,'0008','FROZEN FOODS','N/A',NULL),
(9,'0009','CONFECTIONARY','N/A',NULL),
(10,'0010','CARBONATED SOFT DRINK','N/A',NULL);

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `manufacturers_info` */

insert  into `manufacturers_info`(`id`,`code`,`name`,`address`,`contact_person`,`email`,`phone`,`brand`,`comments`,`entry_date`,`entry_by`,`status`,`client_code`) values 
(1,'MAN00001','TRANSCOM BEVERAGES LTD. (TBL)','FACTORY ADDRESS: KALIAKOIR, GAZIPUR, BANGLADESH.\nHEAD OFFICE CONTACT:\nPLOT# 31, ROAD# 53, GULSHAN NORTH C.A, GULSHAN-2, DHAKA-1212','TRANSCOM BEVERAGES LTD. (TBL)','test@email.com','38754683','TRANSCOM BEVERAGES LTD. (TBL)','No Comments','2021-01-26','ADMIN',1,NULL),
(2,'MAN00002','SQUARE FOOD & BEVERAGE LTD. (SFBL)','SQUARE CENTRE (6TH FLOOR), 48, MOHAKHALI CA, DHAKA-1212, BANGLADESH.\nPHONE: 88-02-8833047-56 [TEN LINES] | FAX: 88-02-8835394','TIEN ANMEN','djxs362@gmail.com','8802883304756','SQUARE FOOD & BEVERAGE LTD. (SFBL)','op','2021-01-26','ADMIN',1,NULL),
(3,'MAN00003','AKIJ FOOD AND BEVERAGE LTD. (AFBL)','AKIJ HOUSE, 198 BIR UTTAM, MIR SHAWKAT SARAK, GULSHAN LINK ROAD, TEJGAON, DHAKA-1208','AKIJ FOOD AND BEVERAGE LTD. (AFBL)','info@akij.net','8809613116609','AKIJ FOOD AND BEVERAGE LTD. (AFBL)','No Comments','2021-01-26','ADMIN',1,NULL),
(4,'MAN00004','PARTEX BEVERAGE LTD.','74 BIR UTTAM A.K. KHANDAKER SARAK,\nMOHAKHALI, DHAKA – 1212, BANGLADESH\nPHONE: +880 2 8822888 | FAX: +880 2 8821888 | E-MAIL: MAILBOX@PARTEX.NET','TIEN ANMEN','t@m.com','01719590478','PARTEX BEVERAGE LTD.','op','2021-01-26','ADMIN',1,NULL),
(5,'MAN00005','PRAN FOODS LTD.','105, PROGOTI SARANI MIDDLE BADDA, DHAKA 1212, BANGLADESH.\nPHONE: 09613-737777','PRAN FOODS LTD.','neroalam@gmail.com','01719590478','PRAN FOODS LTD.','op','2021-01-26','ADMIN',1,NULL),
(6,'MAN00006','ACI FOODS LTD.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','ACI FOODS LTD.','t@m.com','04579624228','ACI FOODS LTD.','op','2021-01-26','ADMIN',1,NULL),
(7,'MAN00007','IFAD MULTI PRODUCTS LTD.','NASIR TRADE CENTER NASIR TRADE CENTER,\n89 BIR UTTAM, CR DUTTA ROAD. DHAKA 1205.\nEMAIL: IMPL@IFADGROUP.COM | PHONE: +01980002134','IFAD MULTI PRODUCTS LTD.','t@m.com','01719590478','IFAD MULTI PRODUCTS LTD.','op','2021-01-26','ADMIN',1,NULL),
(8,'MAN00008','FU-WANG FOODS LTD.','HOUSE: 55, ROAD: 17, BANANI C/A, DHAKA-1213\nTEL: 58815476, 9887359, 9887360,9889958,9889864\nFAX: 880-02-9847451 | E-MAIL: INFO@FUWANGFOODSLTD.COM','FU-WANG FOODS LTD.','t@m.com','04579624228','FU-WANG FOODS LTD.','op','2021-01-26','ADMIN',1,NULL),
(9,'MAN00009','ISPAHANI FOODS LTD.','THE ALLIANCE BUILDING (3RD FLOOR)\n63/KA, PRAGATI SHARANI, BARIDHARA, DHAKA-1212, BANGLADESH.\nPHONE : +88 02 55048375, +88 01755644002','ISPAHANI FOODS LTD.','lobotobo@gmail.com','01247854698','ISPAHANI FOODS LTD.','op','2021-01-26','ADMIN',1,NULL),
(10,'MAN00010','BOMBAY SWEETS & CO. LTD.','DELTA LIFE TOWER(8TH FLOOR),\n37, GULSHAN NORTH C/A, ROAD NO#90, GULSHAN -2, DHAKA-1213, BANGLADESH.\nPHONE : 9893800-1, 9896800, 9897100| FAX : 880-2-9893077, 8814780','BOMBAY SWEETS & CO. LTD.','t@m.com','98938001','BOMBAY SWEETS & CO. LTD.','op','2021-01-26','ADMIN',1,NULL),
(11,'MAN00011','UNILEVER INC.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','UNILEVER INC.','Unlilever@uni.com','01247854698','UNILEVER INC.','op','2021-01-26','ADMIN',1,NULL),
(12,'MAN00012','NESTLE FOODS LTD.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','NESTLE FOODS LTD.','lobotobo@gmail.com','6549651986','NESTLE FOODS LTD.','op','2021-01-26','ADMIN',1,NULL);

/*Table structure for table `pos_log` */

DROP TABLE IF EXISTS `pos_log`;

CREATE TABLE `pos_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `supplier_code` varchar(50) DEFAULT NULL,
  `manufacturer_code` varchar(50) DEFAULT NULL,
  `category_code` varchar(50) DEFAULT NULL,
  `product_code` varchar(50) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `pos_log` */

insert  into `pos_log`(`id`,`supplier_code`,`manufacturer_code`,`category_code`,`product_code`,`client_code`) values 
(1,'SUP00009','MAN00012','0010',NULL,NULL);

/*Table structure for table `product_event_info` */

DROP TABLE IF EXISTS `product_event_info`;

CREATE TABLE `product_event_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(50) DEFAULT NULL,
  `transaction_type` int DEFAULT '0',
  `invoice` varchar(30) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `supplier_code` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `total_amount` double(10,2) DEFAULT NULL,
  `cr_discount` double(10,2) DEFAULT NULL,
  `cr_amount` double(10,2) DEFAULT NULL,
  `dr_discount` double(10,2) DEFAULT NULL,
  `dr_amount` double(10,2) DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `client_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `product_event_info` */

/*Table structure for table `product_event_info_details` */

DROP TABLE IF EXISTS `product_event_info_details`;

CREATE TABLE `product_event_info_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(50) DEFAULT NULL,
  `transaction_type` int DEFAULT NULL,
  `transaction_name` varchar(100) DEFAULT NULL,
  `transaction_group_id` int DEFAULT NULL,
  `transaction_group_name` varchar(100) DEFAULT NULL,
  `invoice` varchar(30) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `total_amount` double(10,2) DEFAULT NULL,
  `cr_discount` double(10,2) DEFAULT NULL,
  `cr_amount` double(10,2) DEFAULT NULL,
  `dr_discount` double(10,2) DEFAULT NULL,
  `dr_amount` double(10,2) DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `client_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `product_event_info_details` */

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
  `unit_price` decimal(10,2) DEFAULT '0.00',
  `mrp_price` decimal(10,2) DEFAULT '0.00',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `reorder_level` decimal(10,2) DEFAULT '0.00',
  `category` varchar(50) DEFAULT NULL,
  `category_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `group_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `batch` varchar(50) DEFAULT NULL,
  `entry_by` varchar(100) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `product_info` */

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
  `entry_date` date DEFAULT '0000-00-00',
  `entry_by` varchar(50) DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `suppliers_info` */

insert  into `suppliers_info`(`id`,`code`,`name`,`company`,`address`,`division`,`district`,`thana`,`mobile`,`email`,`supplier_type`,`remarks`,`entry_date`,`entry_by`,`client_code`) values 
(3,'SUP00001','MD. SHAHIDUZZAMAN','SHAHID TRADERS','TALKONA','DHAKA','MADARIPUR','SHIBCHAR','019675347','tanjin@email.com',1,'Nothing','2021-01-26','ADMIN',NULL),
(4,'SUP00002','MD. MOAZZEM HOSSAIN','ZEM FOODS','BASHABO','DHAKA','DHAKA','SABUJBAGH','016575446','gh@email.com',1,'Nothing','2021-01-26','ADMIN',NULL),
(5,'SUP00003','SUMON MEHEDI','MEHEDI CORP.','BASHABO','DHAKA','DHAKA','SABUJBAGH','015675755','nf@email.com',1,'Nothing','2021-01-26','ADMIN',NULL),
(6,'SUP00004','MD. ATIAR RAHMAN ','LIJAN TRADERS','BASHABO','DHAKA','DHAKA','SABUJBAGH','015657455','yt3245@email.com',1,'Nothing','2021-01-26','ADMIN',NULL),
(7,'SUP00005','MD. MIZANUR RAHMAN','ZAN TRADERS','BASHABO','DHAKA','DHAKA','SABUJBAGH','012355757','kj3456@email.com',1,'Nothing','2021-01-26','ADMIN',NULL),
(8,'SUP00006','MUHAMMAD MASUM BILLAH','BILLAH & BILLAH','BASHABO','DHAKA','DHAKA','SABUJBAGH','015767566','poi46467@email.com',1,'Nothing','2021-01-26','ADMIN',NULL),
(9,'SUP00007','MD GOLAM ROBBANI','ROBBA BAKERY','SHONKOR','DHAKA','DHAKA','DHANMONDI','0165489653','sobuj@molla.com',1,'Nothing Important','2021-01-26','ADMIN',NULL),
(11,'SUP00008','MD. MOZIBOR RAHMAN','RAHMAN LTD.','JANATA TOWER','DHAKA','DHAKA','TEJGAON','0195736823','nice@nice.com',0,'asdfsdfasdgfdg','2021-01-26','ADMIN',NULL),
(12,'SUP00009','REZAUL AZAM FARUQUI','AZAM INC.','RESHAT','RANGPUR','NILPHAMARI','NILPHAMARI SADAR','01478796548','t@m.com',1,'Nice','2021-01-26','ADMIN',NULL);

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

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
