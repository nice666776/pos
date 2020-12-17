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
CREATE DATABASE /*!32312 IF NOT EXISTS*/`posdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `posdb`;

/*Table structure for table `account_group` */

DROP TABLE IF EXISTS `account_group`;

CREATE TABLE `account_group` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `control_code` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `control_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `control_type` varchar(5) DEFAULT NULL,
  `c_status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bank_branches` */

/*Table structure for table `bank_info` */

DROP TABLE IF EXISTS `bank_info`;

CREATE TABLE `bank_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bank_code` varchar(20) DEFAULT NULL,
  `bank_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bank_info` */

/*Table structure for table `control_type` */

DROP TABLE IF EXISTS `control_type`;

CREATE TABLE `control_type` (
  `id` int NOT NULL,
  `control_type` varchar(15) DEFAULT NULL,
  `c_type` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `control_type` */

/*Table structure for table `counter_info` */

DROP TABLE IF EXISTS `counter_info`;

CREATE TABLE `counter_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `counter_code` varchar(100) DEFAULT NULL,
  `counter_name` varchar(100) DEFAULT NULL,
  `counter_location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `counter_info` */

/*Table structure for table `manufacturers_info` */

DROP TABLE IF EXISTS `manufacturers_info`;

CREATE TABLE `manufacturers_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `contact_person` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `comments` varchar(50) DEFAULT NULL,
  `entry_date` date DEFAULT '0000-00-00',
  `entry_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `manufacturers_info` */

/*Table structure for table `pos_log` */

DROP TABLE IF EXISTS `pos_log`;

CREATE TABLE `pos_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `supplier_code` varchar(50) DEFAULT NULL,
  `manufacturer_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `pos_log` */

insert  into `pos_log`(`id`,`supplier_code`,`manufacturer_code`) values 
(1,'SUP00007',NULL);

/*Table structure for table `suppliers_info` */

DROP TABLE IF EXISTS `suppliers_info`;

CREATE TABLE `suppliers_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `division` varchar(50) DEFAULT NULL,
  `district` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `thana` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `supplier_type` tinyint(1) DEFAULT NULL,
  `remarks` varchar(50) DEFAULT NULL,
  `entry_date` date DEFAULT '0000-00-00',
  `entry_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `suppliers_info` */

insert  into `suppliers_info`(`id`,`code`,`name`,`company`,`address`,`division`,`district`,`thana`,`mobile`,`email`,`supplier_type`,`remarks`,`entry_date`,`entry_by`) values 
(3,'SUP00001','TAJIN HOSEN','TAJIN TRADERS','Bashabo','DHAKA','DHAKA','SABUJBAGH','019675347','tanjin@email.com',1,'Nothing','2020-12-17','ADMIN'),
(4,'SUP00002','SAJIN MOLLA','SAJIN TRADERS','Bashabo','DHAKA','DHAKA','SABUJBAGH','016575446','gh@email.com',1,'Nothing','2020-12-17','ADMIN'),
(5,'SUP00003','MAJIN MUKTADIR','MAJIN TRADERS','Bashabo','DHAKA','DHAKA','SABUJBAGH','015675755','nf@email.com',1,'Nothing','2020-12-17','ADMIN'),
(6,'SUP00004','LIJIN KAYESH','LIJIN TRADERS','BASHABO','DHAKA','DHAKA','SABUJBAGH','015657455','yt3245@email.com',1,'Nothing','2020-12-17','ADMIN'),
(7,'SUP00005','ROJIN ALAM','ROJIN TRADERS','Bashabo','DHAKA','DHAKA','SABUJBAGH','012355757','kj3456@email.com',1,'Nothing','2020-12-17','ADMIN'),
(8,'SUP00006','NOJIN ULLAH','NOJIN TRADERS','Bashabo','DHAKA','DHAKA','SABUJBAGH','015767566','poi46467@email.com',1,'Nothing','2020-12-17','ADMIN'),
(9,'SUP00007','SOBUJ MOLLA','NICE TRADERS','Shonkor','DHAKA','DHAKA','DHANMONDI','0165489653','sobuj@molla.com',1,'Nothing Important','2020-12-17','ADMIN');

/*Table structure for table `unit_info` */

DROP TABLE IF EXISTS `unit_info`;

CREATE TABLE `unit_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unit` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `unit_info` */

insert  into `unit_info`(`id`,`unit`) values 
(1,'Pcs'),
(2,'Kg'),
(3,'lbs'),
(4,'Grams'),
(5,'Milligram'),
(6,'Dozen');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
