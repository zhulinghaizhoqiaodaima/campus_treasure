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

USE `campus_treasure`;

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

insert  into `file`(`id`,`name`,`type`,`size`,`url`,`isDelete`,`enable`,`md5`) values 
(11,'草莓2.jpg','jpg',239,'http://localhost:8088/file/01d407a9173e47f3adf4d7a4fea48abb.jpg',0,1,'9846bce08e5b615d899c066fcefa3631'),
(12,'草莓1.jpg','jpg',239,'http://localhost:8088/file/01d407a9173e47f3adf4d7a4fea48abb.jpg',0,1,'9846bce08e5b615d899c066fcefa3631'),
(13,'柚子一斤_7.jpg','jpg',20,'http://localhost:8088/file/20a7adb59103425b87f9775cb1cb4566.jpg',0,1,'cfb67ac48118d38a7bfda832af53213f'),
(14,'香蕉一斤_5.jpeg','jpeg',58,'http://localhost:8088/file/9ddba8f0277849cbb196cb589833026b.jpeg',0,1,'2291a2a5c28d84f9d7986a1f353fb0c7'),
(17,'附件2 桂林理工大学2021年秋季学期学生请假外出安全承诺书.docx','docx',87,'http://localhost:8088/file/e1dad03c1e1e4cc99536c1e4035165ca.docx',0,1,'236dc5d8a99e6eb82184b39d10a0d67a'),
(18,'blue-checked.png','png',0,'http://localhost:8088/file/9feb0af80c8f417d8d25a5ad05155fb6.png',0,1,'45284c5e8f0b962a423d561540e2221f'),
(19,'Dream_TradingCard (2).jpg','jpg',259,'http://localhost:8088/file/08e1ae37c094422f8f0f731cb105ca98.jpg',0,1,'43483294e88aba8f363cc94f6992bfee'),
(20,'Dream_TradingCard (2).jpg','jpg',259,'http://localhost:8088/file/08e1ae37c094422f8f0f731cb105ca98.jpg',0,1,'43483294e88aba8f363cc94f6992bfee'),
(21,'Dream_TradingCard (29).jpg','jpg',247,'http://localhost:8088/file/209e54cc40b649c4b638499cc1612fe3.jpg',0,1,'5dc74bb21986abdd8d2ec6d02dd4f5db'),
(22,'Dream_TradingCard (49).jpg','jpg',339,'http://localhost:8088/file/2ce4a07921684b03b367276160392d63.jpg',0,1,'f85ea9f605e793766f3c4d061b2d6f45'),
(23,'Dream_TradingCard.jpg','jpg',316,'http://localhost:8088/file/6421f40bce174b6cbd923590a4ed60fb.jpg',0,1,'76945747dedf1b67bd64893ff201e160'),
(24,'Dream_TradingCard (8).jpg','jpg',348,'http://localhost:8088/file/e8e5fe2892bc4a69b5b2a18b095537a7.jpg',0,1,'e4d9ba51d744651ac8a4f74c40f9c1f7'),
(25,'Dream_TradingCard (2).jpg','jpg',259,'http://localhost:8088/file/08e1ae37c094422f8f0f731cb105ca98.jpg',0,1,'43483294e88aba8f363cc94f6992bfee'),
(26,'Dream_TradingCard (2).jpg','jpg',259,'http://localhost:8088/file/08e1ae37c094422f8f0f731cb105ca98.jpg',0,1,'43483294e88aba8f363cc94f6992bfee'),
(27,'Dream_TradingCard (7).jpg','jpg',379,'http://localhost:8088/file/f17c58e560474842bad6f2ecb382eba9.jpg',0,1,'138f68a7a215692de5fa3f15ba2f310b'),
(28,'Dream_TradingCard (30).jpg','jpg',358,'http://localhost:8088/file/b4ad4fa5dcbd45c9b8c1da6f84ead526.jpg',0,1,'e78efab7df0dae54014c775531fb3c40'),
(29,'mmexport1cba16c925ef3002d7d8096a0142acf4_1625727.jpeg','jpeg',192,'http://localhost:8088/file/52ebd711f1f74bbc9ebbbb664a31534b.jpeg',0,1,'a64aabc0802be10be86777d3e3b67601'),
(30,'mmexport7697a49ac10a3583772fd279d5853b6e_1625381.jpeg','jpeg',84,'http://localhost:8088/file/ba6ef1bedbf3457291f01fee8b7eec38.jpeg',0,1,'5525341599ca9fec8bf4fedd5e06d0eb'),
(31,'mmexport5d9a41de9aff7874f720f4f897b34018_16257271.png','png',701,'http://localhost:8088/file/3eca8294d4b14a40b812a1d6ee7cb652.png',0,1,'5275b735526add05b4271a1836d2d17b'),
(32,'mmexport1606261411233.jpg','jpg',497,'http://localhost:8088/file/12cacd81c8cd460ab81daf0a690ff259.jpg',0,1,'8b2642a326becde509d7b875494a4ca8'),
(33,'mmexport6d587250f8b4927303f8dad574f937bf_1623908.jpeg','jpeg',159,'http://localhost:8088/file/35cd17bb74044acf8fd0f1abbdd2a404.jpeg',0,1,'3da818b37710234640801bd92ecfd56b'),
(34,'mmexport9a42756e1d5cbbd1d5e490cc60a8dd37_1625381.jpeg','jpeg',181,'http://localhost:8088/file/b092be9b494443aa9714d187ca63e4a4.jpeg',0,1,'caa60536793d43149b54407f6bd9c218'),
(35,'1.jpg','jpg',39,'http://localhost:8088/file/a5d4af4c490442b3a961a9210a9b4a82.jpg',0,1,'d77406bf2f712e408624a984cc05711b'),
(36,'2.jpg','jpg',37,'http://localhost:8088/file/066bfd5ebc264416bea5655006eea0c0.jpg',0,1,'93c6adfb389a0a6760f7fe336fefb9bb'),
(37,'0069TDIhgy1gc7uouo4btj34mo334b2n.jpg','jpg',672,'http://localhost:8088/file/0da76bce12724e6fa783ca9d2e23bb2a.jpg',0,1,'34d781d2950c6b367ec32fe3cf0c02d1'),
(38,'mmexportf4338a475ac9b8421348a3b7e259a7e3_1623300.jpeg','jpeg',118,'http://localhost:8088/file/aa3376b34d2c4388a978519c036f24e9.jpeg',0,1,'ffefad7336bfe2589dab812a50ed87af'),
(39,'pvyhTbtFqpHo315accaf08fe9cd589ca1112d6d0ac13.png','png',136,'http://localhost:8088/file/1f8c344d63b54b5897a3402931e1bf8c.png',0,1,'315accaf08fe9cd589ca1112d6d0ac13'),
(40,'i3yT2EQyPxav093be119d3707339bc7c46727dbb9aab.png','png',821,'http://localhost:8088/file/fe5a9a30e1494c93bd1b037f00f2217f.png',0,1,'093be119d3707339bc7c46727dbb9aab'),
(41,'Z1k3mq6VfkDCd919c34cd9fee2a91dae472309fbb482.png','png',114,'http://localhost:8088/file/be18f669e8b342a7863e3a7ae32f68be.png',0,1,'d919c34cd9fee2a91dae472309fbb482'),
(42,'RQ1nF5JwTVI9315accaf08fe9cd589ca1112d6d0ac13.png','png',136,'http://localhost:8088/file/1f8c344d63b54b5897a3402931e1bf8c.png',0,1,'315accaf08fe9cd589ca1112d6d0ac13'),
(43,'GhbStL9JsaEK226cebd34c408896b622f6a1bbcd18bc.png','png',264,'http://localhost:8088/file/c72201cadfba435cb61561dbe20928c4.png',0,1,'226cebd34c408896b622f6a1bbcd18bc'),
(44,'rNk7McgcXlnz226cebd34c408896b622f6a1bbcd18bc.png','png',264,'http://localhost:8088/file/c72201cadfba435cb61561dbe20928c4.png',0,1,'226cebd34c408896b622f6a1bbcd18bc'),
(45,'oFWS2QJSMxFW093be119d3707339bc7c46727dbb9aab.png','png',821,'http://localhost:8088/file/fe5a9a30e1494c93bd1b037f00f2217f.png',0,1,'093be119d3707339bc7c46727dbb9aab'),
(46,'m8UofaZhjOfbd919c34cd9fee2a91dae472309fbb482.png','png',114,'http://localhost:8088/file/be18f669e8b342a7863e3a7ae32f68be.png',0,1,'d919c34cd9fee2a91dae472309fbb482'),
(47,'3WKyfJiyIhUU93c6adfb389a0a6760f7fe336fefb9bb.jpg','jpg',37,'http://localhost:8088/file/066bfd5ebc264416bea5655006eea0c0.jpg',0,1,'93c6adfb389a0a6760f7fe336fefb9bb'),
(48,'vpA1eLfSjgZQ93c6adfb389a0a6760f7fe336fefb9bb.jpg','jpg',37,'http://localhost:8088/file/066bfd5ebc264416bea5655006eea0c0.jpg',0,1,'93c6adfb389a0a6760f7fe336fefb9bb'),
(49,'DY10fHhJjCHd93c6adfb389a0a6760f7fe336fefb9bb.jpg','jpg',37,'http://localhost:8088/file/066bfd5ebc264416bea5655006eea0c0.jpg',0,1,'93c6adfb389a0a6760f7fe336fefb9bb'),
(50,'JLPD9E4HyPMf93c6adfb389a0a6760f7fe336fefb9bb.jpg','jpg',37,'http://localhost:8088/file/066bfd5ebc264416bea5655006eea0c0.jpg',0,1,'93c6adfb389a0a6760f7fe336fefb9bb'),
(51,'UY3pPTxWBfCD93c6adfb389a0a6760f7fe336fefb9bb.jpg','jpg',37,'http://localhost:8088/file/066bfd5ebc264416bea5655006eea0c0.jpg',0,1,'93c6adfb389a0a6760f7fe336fefb9bb'),
(52,'IDxOeX4ymv5sd77406bf2f712e408624a984cc05711b.jpg','jpg',39,'http://localhost:8088/file/a5d4af4c490442b3a961a9210a9b4a82.jpg',0,1,'d77406bf2f712e408624a984cc05711b'),
(53,'AmYceNXnZuRdd77406bf2f712e408624a984cc05711b.jpg','jpg',39,'http://localhost:8088/file/a5d4af4c490442b3a961a9210a9b4a82.jpg',0,1,'d77406bf2f712e408624a984cc05711b'),
(54,'0IfkGXqSuH2j93c6adfb389a0a6760f7fe336fefb9bb.jpg','jpg',37,'http://localhost:8088/file/066bfd5ebc264416bea5655006eea0c0.jpg',0,1,'93c6adfb389a0a6760f7fe336fefb9bb'),
(55,'PBKD7HxVTzjVd77406bf2f712e408624a984cc05711b.jpg','jpg',39,'http://localhost:8088/file/a5d4af4c490442b3a961a9210a9b4a82.jpg',0,1,'d77406bf2f712e408624a984cc05711b'),
(56,'seMFfg4Nvmm193c6adfb389a0a6760f7fe336fefb9bb.jpg','jpg',37,'http://localhost:8088/file/066bfd5ebc264416bea5655006eea0c0.jpg',0,1,'93c6adfb389a0a6760f7fe336fefb9bb'),
(57,'ZzhaVp82Lah893c6adfb389a0a6760f7fe336fefb9bb.jpg','jpg',37,'http://localhost:8088/file/066bfd5ebc264416bea5655006eea0c0.jpg',0,1,'93c6adfb389a0a6760f7fe336fefb9bb'),
(58,'NwSrrPddjzJx93c6adfb389a0a6760f7fe336fefb9bb.jpg','jpg',37,'http://localhost:8088/file/066bfd5ebc264416bea5655006eea0c0.jpg',0,1,'93c6adfb389a0a6760f7fe336fefb9bb'),
(59,'W3ESCFdZlvsU93c6adfb389a0a6760f7fe336fefb9bb.jpg','jpg',37,'http://localhost:8088/file/066bfd5ebc264416bea5655006eea0c0.jpg',0,1,'93c6adfb389a0a6760f7fe336fefb9bb'),
(60,'rwOkJWtT98gk93c6adfb389a0a6760f7fe336fefb9bb.jpg','jpg',37,'http://localhost:8088/file/066bfd5ebc264416bea5655006eea0c0.jpg',0,1,'93c6adfb389a0a6760f7fe336fefb9bb'),
(61,'QC9cDHWF1n1Bd77406bf2f712e408624a984cc05711b.jpg','jpg',39,'http://localhost:8088/file/a5d4af4c490442b3a961a9210a9b4a82.jpg',0,1,'d77406bf2f712e408624a984cc05711b'),
(62,'xCH2tH3srzLmd77406bf2f712e408624a984cc05711b.jpg','jpg',39,'http://localhost:8088/file/a5d4af4c490442b3a961a9210a9b4a82.jpg',0,1,'d77406bf2f712e408624a984cc05711b'),
(63,'w6C0njA0FJ5Kd77406bf2f712e408624a984cc05711b.jpg','jpg',39,'http://localhost:8088/file/a5d4af4c490442b3a961a9210a9b4a82.jpg',0,1,'d77406bf2f712e408624a984cc05711b'),
(64,'6llSsPhZZVsDd77406bf2f712e408624a984cc05711b.jpg','jpg',39,'http://localhost:8088/file/a5d4af4c490442b3a961a9210a9b4a82.jpg',0,1,'d77406bf2f712e408624a984cc05711b'),
(65,'wduhLLO1o5UPd77406bf2f712e408624a984cc05711b.jpg','jpg',39,'http://localhost:8088/file/a5d4af4c490442b3a961a9210a9b4a82.jpg',0,1,'d77406bf2f712e408624a984cc05711b'),
(66,'au6PPrcx3EKkd77406bf2f712e408624a984cc05711b.jpg','jpg',39,'http://localhost:8088/file/a5d4af4c490442b3a961a9210a9b4a82.jpg',0,1,'d77406bf2f712e408624a984cc05711b'),
(67,'siLnpYZm1ufZ138f68a7a215692de5fa3f15ba2f310b.jpg','jpg',379,'http://localhost:8088/file/f17c58e560474842bad6f2ecb382eba9.jpg',0,1,'138f68a7a215692de5fa3f15ba2f310b'),
(68,'TOTtkmQYzpUa5f5fb315e6a33eeef424774d4d65337e.jpg','jpg',295,'http://localhost:8088/file/d1d71305ff584ed6a3bdc07e0d8548d7.jpg',0,1,'5f5fb315e6a33eeef424774d4d65337e'),
(69,'bq6evXlqFK3dc5e238aa1234751e3944c056beaa14de.jpg','jpg',257,'http://localhost:8088/file/fd89ff135d904472b8c0c5949ef00576.jpg',0,1,'c5e238aa1234751e3944c056beaa14de'),
(70,'SoxP5P3ZHz6W93b69222fdedcfd5b0b7555c82f886a0.jpeg','jpeg',312,'http://localhost:8088/file/6a82a6b271fe4eedafca67c90a7f985e.jpeg',0,1,'93b69222fdedcfd5b0b7555c82f886a0'),
(71,'HAHqfgmaeZYcd77406bf2f712e408624a984cc05711b.jpg','jpg',39,'http://localhost:8088/file/a5d4af4c490442b3a961a9210a9b4a82.jpg',0,1,'d77406bf2f712e408624a984cc05711b'),
(72,'rRtZvySqgbD63b496652a67e74121f59f32db2aacbf9.jpg','jpg',86,'http://localhost:8088/file/e01585717fd644198f81bf1a97237b44.jpg',0,1,'3b496652a67e74121f59f32db2aacbf9'),
(73,'mmexport1cba16c925ef3002d7d8096a0142acf4_1625727.jpeg','jpeg',192,'http://localhost:8088/file/52ebd711f1f74bbc9ebbbb664a31534b.jpeg',1,1,'a64aabc0802be10be86777d3e3b67601'),
(74,'20190404225110244.png','png',1203,'http://localhost:8088/file/066ea8151bd04cb8a2187774cab367b3.png',1,1,'5c630acd3f7575fe27691b171d4533a7'),
(75,'mmexport51fd74a35e26c8fd10d9220784f93377_1624594.jpeg','jpeg',90,'http://localhost:8088/file/4babc5b540ab4cd286e14564bc90a06b.jpeg',1,1,'55a4abf051942a056f86e43edbb88937'),
(76,'mmexport5d9a41de9aff7874f720f4f897b34018_16257271.png','png',701,'http://localhost:8088/file/3eca8294d4b14a40b812a1d6ee7cb652.png',1,1,'5275b735526add05b4271a1836d2d17b'),
(77,'1.png','png',264,'http://localhost:8088/file/c72201cadfba435cb61561dbe20928c4.png',0,1,'226cebd34c408896b622f6a1bbcd18bc'),
(78,'3.png','png',136,'http://localhost:8088/file/1f8c344d63b54b5897a3402931e1bf8c.png',0,1,'315accaf08fe9cd589ca1112d6d0ac13'),
(79,'JNQNyY9eg06Ica32c724058c50e43d8a74a64c845d0f.jpg','jpg',22,'http://localhost:8088/file/f066f2bf09604a8c91b58d4839f931db.jpg',0,1,'ca32c724058c50e43d8a74a64c845d0f'),
(80,'o6WL4XKMcGTucac1c658d604e27a256eacc4133b4fe9.jpeg','jpeg',194,'http://localhost:8088/file/5f19ab34b66b410f8b1479ade2e78dec.jpeg',0,1,'cac1c658d604e27a256eacc4133b4fe9'),
(81,'Wq5EI1XkXfFg91476a2a436199db6dfa00f191905bc5.jpeg','jpeg',141,'http://localhost:8088/file/f317777f4d6d4120a1760fd13e17ba9b.jpeg',0,1,'91476a2a436199db6dfa00f191905bc5'),
(82,'AR2riTcsDvAX8b2642a326becde509d7b875494a4ca8.jpg','jpg',497,'http://localhost:8088/file/12cacd81c8cd460ab81daf0a690ff259.jpg',0,1,'8b2642a326becde509d7b875494a4ca8'),
(83,'WbpMttS42Dzb5464d35339bc6875aae315c760de0a08.JPG','JPG',8,'http://localhost:8088/file/553a74ee865b4963808768db9571cc12.JPG',0,1,'5464d35339bc6875aae315c760de0a08'),
(84,'lSU7yixBzk4m91476a2a436199db6dfa00f191905bc5.jpeg','jpeg',141,'http://localhost:8088/file/f317777f4d6d4120a1760fd13e17ba9b.jpeg',0,1,'91476a2a436199db6dfa00f191905bc5'),
(85,'WPS图片编辑.png','png',129,'http://localhost:8088/file/d997b29878fa4c8c872d7e57e6079af3.png',0,1,'7ebd7b2b442b3bcc6e7d079eea8e166a'),
(86,'test.png','png',2792,'http://localhost:8088/file/c284e6fa87554961b45068f66ee3977c.png',0,1,'a9040d1bd7e4ae1ee8ed4cb9b29a170e'),
(87,'test.png','png',2792,'http://localhost:8088/file/c284e6fa87554961b45068f66ee3977c.png',0,1,'a9040d1bd7e4ae1ee8ed4cb9b29a170e'),
(88,'微信1.jpg','jpg',25,'http://localhost:8088/file/970eafc2bdf14f98840cb360274d34aa.jpg',0,1,'16d008ccccb8e9c7c238303c7c871906'),
(89,'IMG_20210509_173826.jpg','jpg',133,'http://localhost:8088/file/fad862c59fb74d8faed64d09d134db38.jpg',0,1,'323543697f795f980379d24b48aafadc'),
(90,'download_20210508203908.jpg','jpg',2053,'http://localhost:8088/file/f4f51e358e54431b8c2a99ab3fd15658.jpg',0,1,'d2b3f1cab863f731f5b9031004f30dcc'),
(91,'yoEDhh8xQmmEd77406bf2f712e408624a984cc05711b.jpg','jpg',39,'http://localhost:8088/file/a5d4af4c490442b3a961a9210a9b4a82.jpg',0,1,'d77406bf2f712e408624a984cc05711b'),
(92,'Y3jgAR6UkYlR024c91179f5c926b9feaa9e358831ef0.jpg','jpg',39,'http://localhost:8088/file/365ad668af4e4c26a33b471c20bf99ef.jpg',0,1,'024c91179f5c926b9feaa9e358831ef0'),
(93,'IMG_20210509_173826.jpg','jpg',133,'http://localhost:8088/file/fad862c59fb74d8faed64d09d134db38.jpg',0,1,'323543697f795f980379d24b48aafadc'),
(94,'IMG_20210509_173826.jpg','jpg',133,'http://localhost:8088/file/fad862c59fb74d8faed64d09d134db38.jpg',0,1,'323543697f795f980379d24b48aafadc'),
(95,'download_20210508203908.jpg','jpg',2053,'http://localhost:8088/file/f4f51e358e54431b8c2a99ab3fd15658.jpg',0,1,'d2b3f1cab863f731f5b9031004f30dcc'),
(96,'download_20210508203908.jpg','jpg',2053,'http://localhost:8088/file/f4f51e358e54431b8c2a99ab3fd15658.jpg',0,1,'d2b3f1cab863f731f5b9031004f30dcc'),
(97,'IMG_20210509_173826.jpg','jpg',133,'http://localhost:8088/file/fad862c59fb74d8faed64d09d134db38.jpg',0,1,'323543697f795f980379d24b48aafadc'),
(98,'download_20210509184647.jpg','jpg',988,'http://localhost:8088/file/6e75ccc3f50b40ff9fbcecffea43c8f6.jpg',0,1,'870aa6831a7fd62c3d1856779f85e31e'),
(99,'64FLP1ryesgBc3c14b07e9368fb756d900b98161b872.png','png',144,'http://localhost:8088/file/2aa1c68bf8404e81a9a8eef7b8ca5fd1.png',0,1,'c3c14b07e9368fb756d900b98161b872'),
(100,'wTpbxybLtCza18dff1cbe6db3254805c38d8324bea00.png','png',56,'http://localhost:8088/file/13b59e646fe1483aa15fd5c57ad6b0ee.png',0,1,'18dff1cbe6db3254805c38d8324bea00'),
(101,'kXOEf7TEsBZmc3c14b07e9368fb756d900b98161b872.png','png',144,'http://localhost:8088/file/2aa1c68bf8404e81a9a8eef7b8ca5fd1.png',0,1,'c3c14b07e9368fb756d900b98161b872'),
(102,'u0KGGslk2U1Ic3c14b07e9368fb756d900b98161b872.png','png',144,'http://localhost:8088/file/2aa1c68bf8404e81a9a8eef7b8ca5fd1.png',0,1,'c3c14b07e9368fb756d900b98161b872'),
(103,'download_20210509184647.jpg','jpg',988,'http://localhost:8088/file/6e75ccc3f50b40ff9fbcecffea43c8f6.jpg',0,1,'870aa6831a7fd62c3d1856779f85e31e'),
(104,'IMG_20210509_173826.jpg','jpg',133,'http://localhost:8088/file/fad862c59fb74d8faed64d09d134db38.jpg',0,1,'323543697f795f980379d24b48aafadc'),
(105,'download_20210508203908.jpg','jpg',2053,'http://localhost:8088/file/f4f51e358e54431b8c2a99ab3fd15658.jpg',0,1,'d2b3f1cab863f731f5b9031004f30dcc'),
(106,'download_20210509184647.jpg','jpg',988,'http://localhost:8088/file/6e75ccc3f50b40ff9fbcecffea43c8f6.jpg',0,1,'870aa6831a7fd62c3d1856779f85e31e'),
(107,'报名.jpg','jpg',8618,'http://localhost:8088/file/89ee2ebfa5f74ed69a3682460cef0ac4.jpg',0,1,'9e2da6a1038beeac7f76658a337a7443'),
(108,'download_20210509184917.jpg','jpg',678,'http://localhost:8088/file/b04e282ea2c54d0cb9d1a069b56e77e6.jpg',0,1,'f16715d9b71398c89e9d7ccb16d3d1d2'),
(109,'5dUDHOng9lTB0396de9d1af017a1982c2378d267ca6b.jpg','jpg',257,'http://localhost:8088/file/f6895f8721344169aa56ca0a4c4a7dfe.jpg',0,1,'0396de9d1af017a1982c2378d267ca6b'),
(110,'mwbMdw1g27480396de9d1af017a1982c2378d267ca6b.jpg','jpg',257,'http://localhost:8088/file/f6895f8721344169aa56ca0a4c4a7dfe.jpg',0,1,'0396de9d1af017a1982c2378d267ca6b'),
(111,'Js4OhfaJK34w0396de9d1af017a1982c2378d267ca6b.jpg','jpg',257,'http://localhost:8088/file/f6895f8721344169aa56ca0a4c4a7dfe.jpg',0,1,'0396de9d1af017a1982c2378d267ca6b'),
(112,'b9D9FdDW39kw209c8117c2431f095c7f2c33a23f3393.jpeg','jpeg',40,'http://localhost:8088/file/1fe584a477404152a6781dbc41dd9f5a.jpeg',0,1,'209c8117c2431f095c7f2c33a23f3393'),
(113,'PU8mNz5jeYvfb249cc878e09b5e8ff0a441f0a138bf3.jpg','jpg',332,'http://localhost:8088/file/9898b6aeb05d4b4a847e303d492242c9.jpg',0,1,'b249cc878e09b5e8ff0a441f0a138bf3'),
(114,'l0JOpU49wWke2bdb3805f9f237072362f2bacb8da0bc.jpg','jpg',168,'http://localhost:8088/file/84775dedffa74f00b9e2075b5e7802de.jpg',0,1,'2bdb3805f9f237072362f2bacb8da0bc'),
(115,'DB21DbwJt8wq209c8117c2431f095c7f2c33a23f3393.jpeg','jpeg',40,'http://localhost:8088/file/1fe584a477404152a6781dbc41dd9f5a.jpeg',0,1,'209c8117c2431f095c7f2c33a23f3393'),
(116,'ZwrCVZflvPhF25a35211dc03a68997c194020431ce4b.jpg','jpg',110,'http://localhost:8088/file/97ea19691d7d4e0da6a33cfd56d52c2e.jpg',0,1,'25a35211dc03a68997c194020431ce4b'),
(117,'FIw8fNeDlDcx9d6b154c0a04c799bf4306c7b87f1f79.jpg','jpg',130,'http://localhost:8088/file/640a417dfe524235aa17a506a8e54e12.jpg',0,1,'9d6b154c0a04c799bf4306c7b87f1f79'),
(118,'J8askqCTttHQ209c8117c2431f095c7f2c33a23f3393.jpeg','jpeg',40,'http://localhost:8088/file/1fe584a477404152a6781dbc41dd9f5a.jpeg',0,1,'209c8117c2431f095c7f2c33a23f3393'),
(119,'WiXSyIXpHH0wb249cc878e09b5e8ff0a441f0a138bf3.jpg','jpg',332,'http://localhost:8088/file/9898b6aeb05d4b4a847e303d492242c9.jpg',0,1,'b249cc878e09b5e8ff0a441f0a138bf3'),
(120,'khLGk4VlPx152bdb3805f9f237072362f2bacb8da0bc.jpg','jpg',168,'http://localhost:8088/file/84775dedffa74f00b9e2075b5e7802de.jpg',0,1,'2bdb3805f9f237072362f2bacb8da0bc'),
(121,'VZdApDwj2jMvb249cc878e09b5e8ff0a441f0a138bf3.jpg','jpg',332,'http://localhost:8088/file/9898b6aeb05d4b4a847e303d492242c9.jpg',0,1,'b249cc878e09b5e8ff0a441f0a138bf3');

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
