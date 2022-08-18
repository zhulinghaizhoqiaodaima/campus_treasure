/*
SQLyog Enterprise v12.4.3 (64 bit)
MySQL - 8.0.28 : Database - campus_treasure
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`campus_treasure` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `campustreasure`;

/*Table structure for table `file` */

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) DEFAULT NULL COMMENT '文件类型',
  `size` bigint DEFAULT NULL COMMENT '文件大小(KB)',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文件地址',
  `isDelete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `enable` tinyint(1) DEFAULT '1' COMMENT '是否禁用',
  `md5` varchar(255) DEFAULT NULL COMMENT '文件md5',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `file` */



/*Table structure for table `goods` */

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `goodsId` int NOT NULL AUTO_INCREMENT,
  `goodsName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `stuNum` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `classification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `place` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `contactInfo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `remarks` longtext,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `goodsImg` varchar(255) DEFAULT NULL,
  `isFind` tinyint DEFAULT '0',
  PRIMARY KEY (`goodsId`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `goods` */

insert  into `goods`(`goodsId`,`goodsName`,`stuNum`,`classification`,`category`,`place`,`contactInfo`,`remarks`,`time`,`goodsImg`,`isFind`) values 
(45,'书','0191123759','拾取','书籍','赛罕区内蒙古自治区人民政府(敕勒川大街)','1234567567',NULL,'2022-05-26 10:47:22','http://localhost:8088/file/97ea19691d7d4e0da6a33cfd56d52c2e.jpg',0),
(46,'书','0191123759','拾取','书籍','赛罕区内蒙古自治区人民政府(敕勒川大街)','13394713056',NULL,'2022-05-26 10:55:22','http://localhost:8088/file/640a417dfe524235aa17a506a8e54e12.jpg',0),
(47,'书','0191123759','拾取','书籍','赛罕区内蒙古自治区人民政府(敕勒川大街)','133914713056',NULL,'2022-05-26 10:59:37','http://localhost:8088/file/1fe584a477404152a6781dbc41dd9f5a.jpeg',0),
(49,'高数书','0181121845','拾取','书籍','赛罕区内蒙古自治区人民政府(敕勒川大街)','13394713056',NULL,'2022-05-26 11:06:54','http://localhost:8088/file/84775dedffa74f00b9e2075b5e7802de.jpg',0),
(50,'书','0191123759','拾取','书籍','赛罕区内蒙古自治区人民政府(敕勒川大街)','13394713056',NULL,'2022-05-26 11:10:26','http://localhost:8088/file/9898b6aeb05d4b4a847e303d492242c9.jpg',0);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `nickname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `stuNum` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pwd` varchar(20) NOT NULL,
  `grade` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(11) NOT NULL,
  `avatar_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `isAdmin` tinyint DEFAULT '0',
  `iscontactInfo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`stuNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user` */

insert  into `user`(`nickname`,`stuNum`,`pwd`,`grade`,`phone`,`avatar_url`,`createTime`,`isAdmin`,`iscontactInfo`) values 
('橘子2','0181121593','190219aa','2018','1234567897','../../imgs/title.png','2022-03-31 21:35:07',0,'橘子,13394713056'),
('橘子','0181121845','190219aa','2018','13394713056','http://localhost:8088/file/f6895f8721344169aa56ca0a4c4a7dfe.jpg','2022-03-13 15:49:39',0,NULL),
('图片测试用户','0181121948','123','123','123','http://localhost:8088/file/f066f2bf09604a8c91b58d4839f931db.jpg','2022-03-09 23:25:14',0,'憨批,13977705429'),
('橘子2','0191123759','190219aa','2019','1339786578',NULL,'2022-03-13 16:25:22',0,'橘子,13394713056'),
('管理员','123','123','2019','13977705429','http://localhost:8088/file/b04e282ea2c54d0cb9d1a069b56e77e6.jpg','2022-07-03 22:33:52',1,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
