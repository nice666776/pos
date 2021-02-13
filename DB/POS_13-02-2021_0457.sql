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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

/*Data for the table `category_info` */

insert  into `category_info`(`id`,`code`,`name`,`description`,`client_code`) values 
(1,'0001','BREAD & BAKERY','sandwich loaves, dinner rolls, tortillas, bagels','CL799'),
(2,'0002','MEAT & SEAFOOD','Meat, poultry, beef, fish, shrimp, crabs, Seafood','CL799'),
(3,'0003','OILS, SAUCES & CONDIMENTS','Related','CL799'),
(4,'0004','RICE, LENTIL & DRIED LEGUMES ','N/A','CL799'),
(5,'0005','TIN CANNED/JARRED GOODS','N/A','CL799'),
(6,'0006','DAIRY & FARM PRODUCTS','cheeses, eggs, milk, yogurt, butter','CL799'),
(7,'0007','PRODUCES',' fruits, vegetables','CL799'),
(8,'0008','FROZEN FOODS','N/A','CL799'),
(9,'0009','CONFECTIONARY','Candy, Chocolate, Cake, Sweets','CL799'),
(10,'0010','BEVERAGES','coffee/tea, juice, soda','CL799'),
(11,'0011','DRY/BAKING GOODS','cereals, flour, sugar, pasta, mixes, noodles','CL799'),
(12,'0012','CLEANERS','all- purpose, laundry detergent, dishwashing liquid/detergent','CL799'),
(13,'0013','PAPER GOODS','paper towels, toilet paper, aluminum foil, sandwich bags','CL799'),
(14,'0014','PERSONAL CARE & TOILETRIES','shampoo, soap, hand soap, shaving cream','CL799'),
(15,'0015','OTHER','baby items, pet items, batteries, greeting cards','CL799'),
(16,'0016','PHARMACY','N/A','CL799'),
(18,'0018','CROCKERIES','China Ceramics, Glass, Teflons, Plastics Type Kitchen Accessories','CL799'),
(19,'0019','GIFT ITEMS','Nick Nacks','CL799'),
(20,'0020','ELECTRONICS','Microwave oven, Electric Iron and others','CL799'),
(29,'0029','ARTS AND CRAFTS','N/A','CL799'),
(30,'0030','STATIONERY','N/A','CL799'),
(31,'0031','INSTANT PRODUCTS','Powder','CL799'),
(32,'0032','CHIPS AND PACKAGED PRODUCTS','N/A','CL799');

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `manufacturers_info` */

insert  into `manufacturers_info`(`id`,`code`,`name`,`address`,`contact_person`,`email`,`phone`,`brand`,`comments`,`entry_date`,`entry_by`,`status`,`client_code`) values 
(1,'MAN00001','TRANSCOM BEVERAGES LTD. (TBL)','FACTORY ADDRESS: KALIAKOIR, GAZIPUR, BANGLADESH.\nHEAD OFFICE CONTACT:\nPLOT# 31, ROAD# 53, GULSHAN NORTH C.A, GULSHAN-2, DHAKA-1212','TRANSCOM BEVERAGES LTD. (TBL)','test@email.com','38754683','TRANSCOM BEVERAGES LTD. (TBL)','No Comments','2021-01-26','ADMIN',1,'CL799'),
(2,'MAN00002','SQUARE FOOD & BEVERAGE LTD. (SFBL)','SQUARE CENTRE (6TH FLOOR), 48, MOHAKHALI CA, DHAKA-1212, BANGLADESH.\nPHONE: 88-02-8833047-56 [TEN LINES] | FAX: 88-02-8835394','TIEN ANMEN','djxs362@gmail.com','8802883304756','SQUARE FOOD & BEVERAGE LTD. (SFBL)','op','2021-01-26','ADMIN',1,'CL799'),
(3,'MAN00003','AKIJ FOOD AND BEVERAGE LTD. (AFBL)','AKIJ HOUSE, 198 BIR UTTAM, MIR SHAWKAT SARAK, GULSHAN LINK ROAD, TEJGAON, DHAKA-1208','AKIJ FOOD AND BEVERAGE LTD. (AFBL)','info@akij.net','8809613116609','AKIJ FOOD AND BEVERAGE LTD. (AFBL)','No Comments','2021-01-26','ADMIN',1,'CL799'),
(4,'MAN00004','PARTEX BEVERAGE LTD.','74 BIR UTTAM A.K. KHANDAKER SARAK,\nMOHAKHALI, DHAKA – 1212, BANGLADESH\nPHONE: +880 2 8822888 | FAX: +880 2 8821888 | E-MAIL: MAILBOX@PARTEX.NET','TIEN ANMEN','t@m.com','01719590478','PARTEX BEVERAGE LTD.','op','2021-01-26','ADMIN',1,'CL799'),
(5,'MAN00005','PRAN FOODS LTD.','105, PROGOTI SARANI MIDDLE BADDA, DHAKA 1212, BANGLADESH.\nPHONE: 09613-737777','PRAN FOODS LTD.','neroalam@gmail.com','01719590478','PRAN FOODS LTD.','op','2021-01-26','ADMIN',1,'CL799'),
(6,'MAN00006','ACI FOODS LTD.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','ACI FOODS LTD.','t@m.com','04579624228','ACI FOODS LTD.','op','2021-01-26','ADMIN',1,'CL799'),
(7,'MAN00007','IFAD MULTI PRODUCTS LTD.','NASIR TRADE CENTER NASIR TRADE CENTER,\n89 BIR UTTAM, CR DUTTA ROAD. DHAKA 1205.\nEMAIL: IMPL@IFADGROUP.COM | PHONE: +01980002134','IFAD MULTI PRODUCTS LTD.','t@m.com','01719590478','IFAD MULTI PRODUCTS LTD.','op','2021-01-26','ADMIN',1,'CL799'),
(8,'MAN00008','FU-WANG FOODS LTD.','HOUSE: 55, ROAD: 17, BANANI C/A, DHAKA-1213\nTEL: 58815476, 9887359, 9887360,9889958,9889864\nFAX: 880-02-9847451 | E-MAIL: INFO@FUWANGFOODSLTD.COM','FU-WANG FOODS LTD.','t@m.com','04579624228','FU-WANG FOODS LTD.','op','2021-01-26','ADMIN',1,'CL799'),
(9,'MAN00009','ISPAHANI FOODS LTD.','THE ALLIANCE BUILDING (3RD FLOOR)\n63/KA, PRAGATI SHARANI, BARIDHARA, DHAKA-1212, BANGLADESH.\nPHONE : +88 02 55048375, +88 01755644002','ISPAHANI FOODS LTD.','lobotobo@gmail.com','01247854698','ISPAHANI FOODS LTD.','op','2021-01-26','ADMIN',1,'CL799'),
(10,'MAN00010','BOMBAY SWEETS & CO. LTD.','DELTA LIFE TOWER(8TH FLOOR),\n37, GULSHAN NORTH C/A, ROAD NO#90, GULSHAN -2, DHAKA-1213, BANGLADESH.\nPHONE : 9893800-1, 9896800, 9897100| FAX : 880-2-9893077, 8814780','BOMBAY SWEETS & CO. LTD.','t@m.com','9896800','BOMBAY SWEETS & CO. LTD.','op','2021-02-09','ADMIN',1,'CL799'),
(11,'MAN00011','UNILEVER INC.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','UNILEVER INC.','Unlilever@uni.com','01247854698','UNILEVER INC.','op','2021-01-26','ADMIN',1,'CL799'),
(12,'MAN00012','NESTLE FOODS LTD.','245, TEJGAON INDUSTRIAL AREA, DHAKA 1208, BANGLADESH\nTELEPHONE- 880 2 8878603 | FAX- 880 2 8878626, 8878619','NESTLE FOODS LTD.','lobotobo@gmail.com','6549651986','NESTLE FOODS LTD.','op','2021-01-26','ADMIN',1,'CL799'),
(13,'MAN00013','SAJEEB GROUP OF COMPANIES','SHEZAN POINT (LEVEL 6), 2 INDIRA ROAD, FARMGATE, DHAKA 1215, BANGLADESH','ISLAM AMAN','info@sajeebgroup.com.bd','88029116944','SAJEEB GROUP OF COMPANIES','op','2021-02-10','ADMIN',1,'CL799'),
(14,'MAN00014','BOMBAY SWEETS & CO. LTD.','GHURI ','BABU BOMBAY','BBAY@KU.com','0254687445','BOMBAY SWEETS & CO. LTD.','56 BIHAR','2021-02-11','ADMIN',1,'CL799'),
(15,'MAN00015','OTHERS','OTHERS','OTHERS','Others@gmail.com','0000000','OTHERS','Others','2021-02-11','ADMIN',1,'CL799');

/*Table structure for table `pos_log` */

DROP TABLE IF EXISTS `pos_log`;

CREATE TABLE `pos_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `supplier_code` varchar(50) DEFAULT NULL,
  `manufacturer_code` varchar(50) DEFAULT NULL,
  `category_code` varchar(50) DEFAULT NULL,
  `product_code` varchar(50) DEFAULT NULL,
  `transaction_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `pos_log` */

insert  into `pos_log`(`id`,`supplier_code`,`manufacturer_code`,`category_code`,`product_code`,`transaction_id`,`client_code`) values 
(1,'SUP00009','MAN00015','0032','00090021',NULL,'CL799');

/*Table structure for table `product_event_info` */

DROP TABLE IF EXISTS `product_event_info`;

CREATE TABLE `product_event_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(50) DEFAULT NULL,
  `transaction_type` varchar(50) DEFAULT NULL,
  `invoice` varchar(30) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  `supplier_code` varchar(50) DEFAULT NULL,
  `cr_discount` double(10,2) DEFAULT '0.00',
  `cr_amount` double(10,2) DEFAULT '0.00',
  `cr_total` double(10,2) DEFAULT '0.00',
  `dr_discount` double(10,2) DEFAULT '0.00',
  `dr_amount` double(10,2) DEFAULT '0.00',
  `dr_total` double(10,2) DEFAULT '0.00',
  `user_id` varchar(100) DEFAULT NULL,
  `client_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `product_event_info` */

insert  into `product_event_info`(`id`,`transaction_id`,`transaction_type`,`invoice`,`entry_date`,`supplier_name`,`supplier_code`,`cr_discount`,`cr_amount`,`cr_total`,`dr_discount`,`dr_amount`,`dr_total`,`user_id`,`client_code`) values 
(1,'TRX54454','PURCHASE','INV4566','2021-02-13','MD. MOAZZEM HOSSAIN','SUP00002',0.00,0.00,0.00,100.00,5100.00,5000.00,'ADMIN','CL799'),
(2,'TRX54454','PURCHASE','INV4567','2021-02-13','MD. ATIAR RAHMAN ','SUP00004',0.00,0.00,0.00,6.40,8006.40,8000.00,'ADMIN','CL799');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `product_info` */

insert  into `product_info`(`id`,`product_code`,`product_name`,`product_type`,`product_unit`,`quantity_in`,`quantity_out`,`quantity`,`unit_price`,`mrp_price`,`description`,`reorder_level`,`subcategory`,`subcategory_code`,`category`,`category_code`,`status`,`manufacturer_code`,`manufacturer`,`batch`,`entry_by`,`client_code`,`barcode`,`last_expire_date`) values 
(1,'00100001','MUM MINERAL WATER 2L',NULL,'Litre',20.00,0.00,20.00,20.32,25.00,'n/a',500.00,'WATER','001005','BEVERAGES','0010',1,'MAN00004','PARTEX BEVERAGE LTD.',NULL,NULL,'CL799',NULL,'2021-07-27'),
(2,'00100002','MUM MINERAL WATER 1L',NULL,'Litre',0.00,0.00,0.00,15.32,20.00,'n/a',500.00,'WATER','001005','BEVERAGES','0010',1,'MAN00004','PARTEX BEVERAGE LTD.',NULL,NULL,'CL799',NULL,'2021-02-20'),
(3,'00030003','PRAN GURA MOSOLA',NULL,'Kg',0.00,0.00,0.00,34.00,50.00,'n/A',100.00,'SPICES','000304','OILS, SAUCES & CONDIMENTS','0003',1,'MAN00005','PRAN FOODS LTD.',NULL,NULL,'CL799',NULL,'2021-02-20'),
(4,'00030004','PRAN TOMATO SAUCE',NULL,'Kg',0.00,0.00,0.00,80.00,100.00,'n/a',50.00,'SAUCES','000302','OILS, SAUCES & CONDIMENTS','0003',1,'MAN00005','PRAN FOODS LTD.',NULL,NULL,'CL799',NULL,'2021-02-20'),
(5,'00030005','PRAN SOYA SAUCE',NULL,'Kg',0.00,0.00,0.00,45.00,56.00,'n/a',50.00,'SAUCES','000302','OILS, SAUCES & CONDIMENTS','0003',1,'MAN00005','PRAN FOODS LTD.',NULL,NULL,'CL799',NULL,'2021-02-20'),
(6,'00010006','IFAD NOODLES',NULL,'Pc',0.00,0.00,0.00,35.00,40.00,'Spicy Noodles',50.00,'NOODLES','001107','DRY/BAKING GOODS','0011',1,'MAN00007','IFAD MULTI PRODUCTS LTD.',NULL,NULL,'CL799',NULL,'2021-02-20'),
(7,'00040007','CHASHI RICE (50 KGS)',NULL,'Kg',0.00,0.00,0.00,1600.00,1800.00,'N/A',15.00,'RICE','000401','RICE, LENTIL & DRIED LEGUMES ','0004',1,'MAN00007','IFAD MULTI PRODUCTS LTD.',NULL,NULL,'CL799',NULL,'2021-02-20'),
(8,'00110008','OLYMPIC TOAST BISCUIT',NULL,'Kg',50.00,0.00,50.00,67.00,75.00,'Ghee Toast',15.00,'BISCUITS','000108','BREAD & BAKERY','0001',1,'MAN00006','ACI FOODS LTD.',NULL,NULL,'CL799',NULL,'2021-02-25'),
(9,'00110009','MAGGY NOODLES',NULL,'Pc',0.00,0.00,0.00,25.00,30.00,'N/A',50.00,NULL,NULL,'DRY/BAKING GOODS','0011',1,'MAN00012','NESTLE FOODS LTD.',NULL,NULL,'CL799',NULL,'2021-02-20'),
(10,'00050010','KNORR SOUP',NULL,'Pc',0.00,0.00,0.00,23.00,30.00,'N/A',100.00,NULL,NULL,'INSTANT PRODUCTS','0031',1,'MAN00011','UNILEVER INC.',NULL,NULL,'CL799',NULL,'2021-02-20'),
(11,'00050011','DANISH CRACKERS',NULL,'Pc',0.00,0.00,0.00,560.00,600.00,'N/A',20.00,NULL,NULL,'TIN CANNED/JARRED GOODS','0005',1,'MAN00004','PARTEX BEVERAGE LTD.',NULL,NULL,'CL799','00050011','2021-02-20'),
(12,'00120012','WHEEL DETERGENT(1 KG)',NULL,'Kg',0.00,0.00,0.00,180.00,200.00,'Wheel Detergent(1 KG)',50.00,NULL,'001202','CLEANERS','0012',1,'MAN00011','UNILEVER INC.',NULL,NULL,'CL799','00120012','2021-02-20'),
(13,'00090013','COCA-COLA 1.5LITRES',NULL,'Pc',100.00,0.00,100.00,60.00,65.00,'N/A',50.00,'CHOCOLATES','000902','CONFECTIONARY','0009',1,'MAN00001','TRANSCOM BEVERAGES LTD. (TBL)',NULL,NULL,'CL799','00090013','2021-03-25'),
(14,'00100014','PRAN FROOTO 0.5 LITRS',NULL,'Pc',125.00,0.00,125.00,20.00,30.00,'N/A',50.00,'JUICE','001003','BEVERAGES','0010',1,'MAN00005','PRAN FOODS LTD.',NULL,NULL,'CL799','00100014','2021-02-28'),
(15,'00320015','BOMBAY POTATO CRACKERS',NULL,'Pc',0.00,0.00,0.00,8.50,10.00,'n/a',50.00,'CHIPS','003201','CHIPS AND PACKAGED PRODUCTS','0032',1,'MAN00014','BOMBAY SWEETS & CO. LTD.',NULL,NULL,'CL799','00320015','2021-02-20'),
(16,'00040016','MOSUR DAL(5 KGS)',NULL,'Kg',0.00,0.00,0.00,250.00,300.00,'N/A',50.00,'PULSE','000403','RICE, LENTIL & DRIED LEGUMES ','0004',1,'MAN00015','OTHERS',NULL,NULL,'CL799','00040016','2021-02-20'),
(17,'00030017','WELLS OLIVE OIL',NULL,'Litre',0.00,0.00,0.00,560.00,700.00,'n/a',50.00,'OILS','000301','OILS, SAUCES & CONDIMENTS','0003',1,'MAN00002','SQUARE FOOD & BEVERAGE LTD. (SFBL)',NULL,NULL,'CL799','00030017','2021-02-20'),
(18,'00200018','PHILLIPS CURLING IRON',NULL,'Pc',0.00,0.00,0.00,450.00,680.00,'n/a',70.00,'CURLING IRON','002004','ELECTRONICS','0020',1,'MAN00015','OTHERS',NULL,NULL,'CL799','00200018','2021-02-20'),
(19,'00150019','HUGGIES ULTRA NEW BORN (UP TO 5 KG) 24 PCS',NULL,'Pc',0.00,0.00,0.00,800.00,895.00,'n/a',20.00,'BABY ITEMS','001501','OTHER','0015',1,'MAN00015','OTHERS',NULL,NULL,'CL799','00150019','2021-02-20'),
(20,'00140020','SUNSILK L.& HEALTHY GROWTH SHAMPOO 375ML*',NULL,'Pc',0.00,0.00,0.00,301.50,375.50,'UI',20.00,'SHAMPOO','001401','PERSONAL CARE & TOILETRIES','0014',1,'MAN00011','UNILEVER INC.',NULL,NULL,'CL799','00140020','2021-02-20'),
(21,'00090021','CADBURY DAIRY MILK CHOCOLATE (16±2.8)G*',NULL,'Pc',50.00,0.00,50.00,17.00,20.00,'n/a',50.00,'CHOCOLATES','000902','CONFECTIONARY','0009',1,'MAN00015','OTHERS',NULL,NULL,'CL799','00090021','2021-02-28');

/*Table structure for table `product_stock` */

DROP TABLE IF EXISTS `product_stock`;

CREATE TABLE `product_stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(50) DEFAULT NULL,
  `product_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `manufacturer_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `supplier_code` varchar(50) DEFAULT NULL,
  `quantity_out` double(10,2) DEFAULT '0.00',
  `quantity_in` double(10,2) DEFAULT '0.00',
  `unit_price` double(10,2) DEFAULT '0.00',
  `total_price` double(10,2) DEFAULT '0.00',
  `mrp_price` double(10,2) DEFAULT '0.00',
  `expire_date` date DEFAULT '1000-01-01',
  `entry_date` date DEFAULT '1000-01-01',
  `invoice` varchar(50) DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `batch_no` varchar(100) DEFAULT NULL,
  `client_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `barcode` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `product_stock` */

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `product_stock_in` */

insert  into `product_stock_in`(`id`,`transaction_id`,`product_code`,`product_name`,`manufacturer_code`,`supplier_code`,`quantity`,`unit_price`,`total_price`,`mrp_price`,`expire_date`,`entry_date`,`invoice`,`user_id`,`batch_no`,`client_code`,`barcode`) values 
(1,'TRX54454','00090021','CADBURY DAIRY MILK CHOCOLATE (16±2.8)G*','MAN00015','SUP00002',50.00,17.00,850.00,20.00,'2021-02-28','2021-02-13','INV4566','ADMIN',NULL,'CL799','00090021'),
(2,'TRX54454','00100014','PRAN FROOTO 0.5 LITRS','MAN00005','SUP00002',45.00,20.00,900.00,30.00,'2021-02-28','2021-02-13','INV4566','ADMIN',NULL,'CL799','00100014'),
(3,'TRX54454','00110008','OLYMPIC TOAST BISCUIT','MAN00006','SUP00002',50.00,67.00,3350.00,75.00,'2021-02-25','2021-02-13','INV4566','ADMIN',NULL,'CL799',NULL),
(4,'TRX54454','00100014','PRAN FROOTO 0.5 LITRS','MAN00005','SUP00004',80.00,20.00,1600.00,30.00,'2021-02-28','2021-02-13','INV4567','ADMIN',NULL,'CL799','00100014'),
(5,'TRX54454','00100001','MUM MINERAL WATER 2L','MAN00004','SUP00004',20.00,20.32,406.40,25.00,'2021-07-27','2021-02-13','INV4567','ADMIN',NULL,'CL799',NULL),
(6,'TRX54454','00090013','COCA-COLA 1.5LITRES','MAN00001','SUP00004',100.00,60.00,6000.00,65.00,'2021-03-25','2021-02-13','INV4567','ADMIN',NULL,'CL799','00090013');

/*Table structure for table `product_stock_out` */

DROP TABLE IF EXISTS `product_stock_out`;

CREATE TABLE `product_stock_out` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(50) DEFAULT NULL,
  `product_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `manufacturer_name` varchar(100) DEFAULT NULL,
  `quantity` double(10,2) DEFAULT '0.00',
  `unit_price` double(10,2) DEFAULT '0.00',
  `total_price` double(10,2) DEFAULT '0.00',
  `mrp_price` double(10,2) DEFAULT '0.00',
  `expire_date` date DEFAULT NULL,
  `invoice` varchar(50) DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `batch_no` varchar(100) DEFAULT NULL,
  `client_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `category_code` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `product_stock_out` */

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8;

/*Data for the table `subcategory_info` */

insert  into `subcategory_info`(`id`,`code`,`name`,`description`,`client_code`,`category_code`,`category_name`) values 
(76,'000201','BEEF',NULL,'CL799','0002','MEAT & SEAFOOD'),
(77,'000202','MUTTON',NULL,'CL799','0002','MEAT & SEAFOOD'),
(78,'000203','LAMB',NULL,'CL799','0002','MEAT & SEAFOOD'),
(79,'000204','CHICKEN',NULL,'CL799','0002','MEAT & SEAFOOD'),
(80,'000205','FISH',NULL,'CL799','0002','MEAT & SEAFOOD'),
(81,'000206','SHELLFISH',NULL,'CL799','0002','MEAT & SEAFOOD'),
(82,'000207','SEAFOOD',NULL,'CL799','0002','MEAT & SEAFOOD'),
(83,'000301','OILS',NULL,'CL799','0003','OILS, SAUCES & CONDIMENTS'),
(84,'000302','SAUCES',NULL,'CL799','0003','OILS, SAUCES & CONDIMENTS'),
(85,'000303','ESSENCE',NULL,'CL799','0003','OILS, SAUCES & CONDIMENTS'),
(86,'000304','SPICES',NULL,'CL799','0003','OILS, SAUCES & CONDIMENTS'),
(87,'000305','CONDIMENTS',NULL,'CL799','0003','OILS, SAUCES & CONDIMENTS'),
(112,'000601','CHEESE',NULL,'CL799','0006','DAIRY & fARM PRODUCTS'),
(113,'000602','MILK',NULL,'CL799','0006','DAIRY & fARM PRODUCTS'),
(114,'000603','BUTTER',NULL,'CL799','0006','DAIRY & fARM PRODUCTS'),
(115,'000604','YOGHURT',NULL,'CL799','0006','DAIRY & fARM PRODUCTS'),
(116,'000605','GHEE',NULL,'CL799','0006','DAIRY & fARM PRODUCTS'),
(117,'000606','CURD',NULL,'CL799','0006','DAIRY & fARM PRODUCTS'),
(118,'000607','MILK PRODUCTS',NULL,'CL799','0006','DAIRY & fARM PRODUCTS'),
(119,'000701','FRUITS',NULL,'CL799','0007','PRODUCES'),
(120,'000702','VEGETABLES',NULL,'CL799','0007','PRODUCES'),
(121,'000703','PLANTS',NULL,'CL799','0007','PRODUCES'),
(122,'000704','POTATOES',NULL,'CL799','0007','PRODUCES'),
(123,'000705','ONIONS',NULL,'CL799','0007','PRODUCES'),
(124,'000706','GARLIC',NULL,'CL799','0007','PRODUCES'),
(125,'000801','FROZEN MEAT',NULL,'CL799','0008','FROZEN FOODS'),
(126,'000802','FROZEN FOOD',NULL,'CL799','0008','FROZEN FOODS'),
(127,'000803','ICE-CREAM',NULL,'CL799','0008','FROZEN FOODS'),
(128,'000901','CANDY',NULL,'CL799','0009','CONFECTIONARY'),
(129,'000902','CHOCOLATES',NULL,'CL799','0009','CONFECTIONARY'),
(130,'000903','CAKE',NULL,'CL799','0009','CONFECTIONARY'),
(131,'000904','SWEETS',NULL,'CL799','0009','CONFECTIONARY'),
(140,'001101','FLOUR',NULL,'CL799','0011','DRY/BAKING GOODS'),
(141,'001102','ATTA',NULL,'CL799','0011','DRY/BAKING GOODS'),
(142,'001103','SEMOLINA',NULL,'CL799','0011','DRY/BAKING GOODS'),
(143,'001104','SUGAR',NULL,'CL799','0011','DRY/BAKING GOODS'),
(144,'001105','SALT',NULL,'CL799','0011','DRY/BAKING GOODS'),
(145,'001106','PASTA',NULL,'CL799','0011','DRY/BAKING GOODS'),
(146,'001107','NOODLES',NULL,'CL799','0011','DRY/BAKING GOODS'),
(147,'001108','MIXES',NULL,'CL799','0011','DRY/BAKING GOODS'),
(148,'001109','CEREALS',NULL,'CL799','0011','DRY/BAKING GOODS'),
(149,'001201','ALL- PURPOSE',NULL,'CL799','0012','CLEANERS'),
(150,'001202','LAUNDRY DETERGENT',NULL,'CL799','0012','CLEANERS'),
(151,'001203','DISHWASHING LIQUID/DETERGENT',NULL,'CL799','0012','CLEANERS'),
(152,'001204','FLOOR/GLASS CLEANERS',NULL,'CL799','0012','CLEANERS'),
(153,'001205','BLEACH',NULL,'CL799','0012','CLEANERS'),
(154,'001301','PAPER TOWELS',NULL,'CL799','0013','PAPER GOODS'),
(155,'001302','TOILET PAPER',NULL,'CL799','0013','PAPER GOODS'),
(156,'001303','ALUMINUM FOIL',NULL,'CL799','0013','PAPER GOODS'),
(157,'001304','SANDWICH BAGS',NULL,'CL799','0013','PAPER GOODS'),
(158,'001401','SHAMPOO',NULL,'CL799','0014','PERSONAL CARE & TOILETRIES'),
(159,'001402','SOAP',NULL,'CL799','0014','PERSONAL CARE & TOILETRIES'),
(160,'001403','HAND SOAP',NULL,'CL799','0014','PERSONAL CARE & TOILETRIES'),
(161,'001404','SHAVING CREAM',NULL,'CL799','0014','PERSONAL CARE & TOILETRIES'),
(166,'001601','MEDICINE',NULL,'CL799','0016','PHARMACY'),
(167,'001602','SYRUP',NULL,'CL799','0016','PHARMACY'),
(168,'001603','BAND-AID',NULL,'CL799','0016','PHARMACY'),
(169,'001801','CHINA CERAMICS',NULL,'CL799','0018','CROCKERIES'),
(170,'001802','GLASS',NULL,'CL799','0018','CROCKERIES'),
(171,'001803','TEFLONS',NULL,'CL799','0018','CROCKERIES'),
(172,'001804','METAL',NULL,'CL799','0018','CROCKERIES'),
(173,'001805','PLASTICS',NULL,'CL799','0018','CROCKERIES'),
(174,'001901','GIFT CARDS',NULL,'CL799','0019','GIFT ITEMS'),
(175,'001902','BALLONS',NULL,'CL799','0019','GIFT ITEMS'),
(176,'001903','DECORATIONS',NULL,'CL799','0019','GIFT ITEMS'),
(177,'002001','MICROWAVE OVEN',NULL,'CL799','0020','ELECTRONICS'),
(178,'002002','ELECTRIC IRON ',NULL,'CL799','0020','ELECTRONICS'),
(179,'002003','HAIR DRYER',NULL,'CL799','0020','ELECTRONICS'),
(180,'002004','CURLING IRON',NULL,'CL799','0020','ELECTRONICS'),
(182,'000401','RICE',NULL,'CL799','0004','RICE, LENTIL & DRIED LEGUMES '),
(183,'000402','LENTIL',NULL,'CL799','0004','RICE, LENTIL & DRIED LEGUMES '),
(184,'000403','PULSE',NULL,'CL799','0004','RICE, LENTIL & DRIED LEGUMES '),
(185,'000404','BEANS',NULL,'CL799','0004','RICE, LENTIL & DRIED LEGUMES '),
(186,'000405','PEAS',NULL,'CL799','0004','RICE, LENTIL & DRIED LEGUMES '),
(187,'000406','NUTS',NULL,'CL799','0004','RICE, LENTIL & DRIED LEGUMES '),
(198,'002901','ART SUPPLY',NULL,'CL799','0029','ARTS AND CRAFTS'),
(199,'003007','PENSTAND',NULL,'CL799','0030','STATIONERY'),
(200,'003006','BOOKS',NULL,'CL799','0030','STATIONERY'),
(201,'003005','SHARPNER',NULL,'CL799','0030','STATIONERY'),
(202,'003004','ERASER',NULL,'CL799','0030','STATIONERY'),
(203,'003003','PENCIL',NULL,'CL799','0030','STATIONERY'),
(204,'003002','PAPER',NULL,'CL799','0030','STATIONERY'),
(205,'003008','OFFICE SUPPLY',NULL,'CL799','0030','STATIONERY'),
(206,'003001','PEN',NULL,'CL799','0030','STATIONERY'),
(211,'001001','COFFEE',NULL,'CL799','0010','BEVERAGES'),
(212,'001002','TEA',NULL,'CL799','0010','BEVERAGES'),
(213,'001003','JUICE',NULL,'CL799','0010','BEVERAGES'),
(214,'001004','CARBONATED BEVERAGES',NULL,'CL799','0010','BEVERAGES'),
(215,'001005','WATER',NULL,'CL799','0010','BEVERAGES'),
(216,'000101','SANDWITCH BREAD',NULL,'CL799','0001','BREAD & BAKERY'),
(217,'000102','ROTI',NULL,'CL799','0001','BREAD & BAKERY'),
(218,'000103','PARATHA',NULL,'CL799','0001','BREAD & BAKERY'),
(219,'000104','BUNS',NULL,'CL799','0001','BREAD & BAKERY'),
(220,'000105','BREAD',NULL,'CL799','0001','BREAD & BAKERY'),
(221,'000106','ROLLS',NULL,'CL799','0001','BREAD & BAKERY'),
(222,'000107','PASTRYS',NULL,'CL799','0001','BREAD & BAKERY'),
(223,'000108','BISCUITS',NULL,'CL799','0001','BREAD & BAKERY'),
(224,'003101','COFFEE',NULL,'CL799','0031','Instant Products'),
(225,'003102','SOUP',NULL,'CL799','0031','Instant Products'),
(226,'003103','JUICE POWDER',NULL,'CL799','0031','Instant Products'),
(227,'003104','JELLY POWDER',NULL,'CL799','0031','Instant Products'),
(228,'003105','ICING SUGAR',NULL,'CL799','0031','Instant Products'),
(229,'003106','MILK POWDER',NULL,'CL799','0031','Instant Products'),
(230,'000501','JAM',NULL,'CL799','0005','Tin CANNED/JARRED GOODS'),
(231,'000502','JELLY',NULL,'CL799','0005','Tin CANNED/JARRED GOODS'),
(232,'000503','VINEGAR',NULL,'CL799','0005','Tin CANNED/JARRED GOODS'),
(233,'000504','CANNED FRUITS',NULL,'CL799','0005','Tin CANNED/JARRED GOODS'),
(234,'000505','CANNED VEGETABLES',NULL,'CL799','0005','Tin CANNED/JARRED GOODS'),
(235,'000506','PICKLES',NULL,'CL799','0005','Tin CANNED/JARRED GOODS'),
(236,'003201','CHIPS',NULL,'CL799','0032','Chips and Packaged products'),
(237,'003202','POPCORN',NULL,'CL799','0032','Chips and Packaged products'),
(238,'003203','NUTS',NULL,'CL799','0032','Chips and Packaged products'),
(239,'003204','DALMUT',NULL,'CL799','0032','Chips and Packaged products'),
(240,'001501','BABY ITEMS',NULL,'CL799','0015','OTHER'),
(241,'001502','PET ITEMS',NULL,'CL799','0015','OTHER'),
(242,'001503','BATTERIES',NULL,'CL799','0015','OTHER'),
(243,'001504','GREETING CARDS',NULL,'CL799','0015','OTHER'),
(244,'001505','TOYS',NULL,'CL799','0015','OTHER');

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
(3,'SUP00001','MD. SHAHIDUZZAMAN','SHAHID TRADERS','TALKONA','DHAKA','MADARIPUR','SHIBCHAR','019675347','tanjin@email.com',1,'Nothing','2021-01-26','ADMIN','CL799'),
(4,'SUP00002','MD. MOAZZEM HOSSAIN','ZEM FOODS','BASHABO','DHAKA','DHAKA','SABUJBAGH','016575446','gh@email.com',1,'Nothing','2021-01-26','ADMIN','CL799'),
(5,'SUP00003','SUMON MEHEDI','MEHEDI CORP.','BASHABO','DHAKA','DHAKA','SABUJBAGH','015675755','nf@email.com',1,'Nothing','2021-01-26','ADMIN','CL799'),
(6,'SUP00004','MD. ATIAR RAHMAN ','LIJAN TRADERS','JBN','DHAKA','DHAKA','SHAH ALI','015657455','yt3245@email.com',1,'Nothing','2021-02-11','ADMIN','CL799'),
(7,'SUP00005','MD. MIZANUR RAHMAN','ZAN TRADERS','BASHABO','DHAKA','DHAKA','SABUJBAGH','012355757','kj3456@email.com',1,'Nothing','2021-01-26','ADMIN','CL799'),
(8,'SUP00006','MUHAMMAD MASUM BILLAH','BILLAH & BILLAH','BASHABO','DHAKA','DHAKA','SABUJBAGH','015767566','poi46467@email.com',1,'Nothing','2021-01-26','ADMIN','CL799'),
(9,'SUP00007','MD GOLAM ROBBANI','ROBBA BAKERY','SHONKOR','DHAKA','DHAKA','DHANMONDI','0165489653','sobuj@molla.com',1,'Nothing Important','2021-01-26','ADMIN','CL799'),
(11,'SUP00008','MD. MOZIBOR RAHMAN','RAHMAN LTD.','JANATA TOWER','DHAKA','DHAKA','TEJGAON','0195736823','nice@nice.com',0,'asdfsdfasdgfdg','2021-01-26','ADMIN','CL799'),
(12,'SUP00009','REZAUL AZAM FARUQUI','AZAM INC.','RESHAT','RANGPUR','NILPHAMARI','NILPHAMARI SADAR','01478796548','t@m.com',1,'Nice','2021-01-26','ADMIN','CL799');

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
