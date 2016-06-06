-- MySQL dump 10.13  Distrib 5.5.32, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: vote
-- ------------------------------------------------------
-- Server version	5.5.32-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `club`
--

DROP TABLE IF EXISTS `club`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `club` (
  `id` int(11) NOT NULL,
  `name` varchar(11) CHARACTER SET utf8 NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club`
--

LOCK TABLES `club` WRITE;
/*!40000 ALTER TABLE `club` DISABLE KEYS */;
INSERT INTO `club` VALUES (1,'黄慧仪',62),(2,'范巧文',52),(3,'李怡君',65),(4,'潘浩彬',21),(5,'刘志伟',47),(6,'苏嘉阳',39),(7,'黄伟鹏',33),(8,'袁伟佳',32),(9,'王凯斌',48),(10,'左君博',53),(11,'杨煜荣',47),(12,'刘永康',34);
/*!40000 ALTER TABLE `club` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `management`
--

DROP TABLE IF EXISTS `management`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `management` (
  `id` int(11) NOT NULL,
  `name` varchar(11) CHARACTER SET utf8 NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `management`
--

LOCK TABLES `management` WRITE;
/*!40000 ALTER TABLE `management` DISABLE KEYS */;
INSERT INTO `management` VALUES (1,'张铭',6),(2,'黄志镐',1),(3,'孙中阳',1),(4,'刘永康',1),(5,'刘思进',1),(6,'王闯',3),(7,'朱希冉',0),(8,'徐航',0);
/*!40000 ALTER TABLE `management` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `openid` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(11) DEFAULT NULL,
  `m_vote` varchar(30) NOT NULL DEFAULT '',
  `auth` int(11) NOT NULL DEFAULT '1',
  `code` varchar(30) NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT '0',
  `c_vote` varchar(30) NOT NULL DEFAULT '',
  `state` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('olJ-hjkGnvxG-YBxK2pUqWvu4-PQ','蒙家永','7 3 5 4',1,'0040u6',1,'4 10 3 7 12',2),('olJ-hjjXJfCeI1hnHboSWRH1FP6A','李健华','1 5 6 8',1,'04jdki',1,'1 3 4 7 8 11',2),('olJ-hjsEaabPbuTUC3IJBzY6PdEg','方锡鑫','6',1,'0728my',1,'1 3 5 9 11 12',2),('olJ-hjvhqHMj-Za1HVsM8pPWKrvU','吴嘉华','2 4 5 6 7 8',1,'0amsps',1,'1 2 3 5 8 10 12',2),('olJ-hjgk36IYb28EZ1HkTal4v50c','何文杰','1 3 4 5 7',1,'0j2b4e',1,'2 3 5 8 11',2),('','吕泽立','',1,'0p7g60',0,'',0),('olJ-hjuCt7f2_mfOtwfuzXdl6VQ0','卢建业','',1,'0pyn2m',1,'',0),('olJ-hjry6HvzqTOVwlC49gd3ybYg','许伟原','1 2 5 7 8',1,'0r3asj',1,'1 2 3 9 6',2),('','袁晓晖','',1,'0vrx5n',0,'',0),('','王莲君','',1,'0yn0mc',0,'',0),('olJ-hjhlkx53RStq52FSDK0VPBzw','杨易柔','',1,'11sxie',1,'',0),('olJ-hjihrJCBdIt497oEi-r5jEEg','程键生','5 7 8',1,'1kqrtt',1,'3',2),('olJ-hjmGkRGHKTF1L7eXc96xVO6Y','彭俊凯','3 4 5 6 7 8',1,'1lqmj9',1,'1 2 5 6 8 10 11',2),('olJ-hjnQQDloFZE9et3N_Ggo-JiI','邓丽雯','6',1,'1x9rmx',1,'1 2 7 4 10 11 9',2),('olJ-hjlB1pFVMyumkCukqkBqozH8','李培荣','1 3 4 5 7 8',1,'20sb1e',1,'2 3 5 8 9 11 12',2),('olJ-hjt6oW_WzFRJziGFsm0Z5PPA','江帆','',1,'2ca8p8',1,'',0),('olJ-hjlXYxHeB30NtWGljsrmlPyY','胡晓渊','1 2 5',1,'2o5cfw',1,'1 2 3 4 5 6 10',2),('','李喆','',1,'2tn4q8',0,'',0),('olJ-hjrgMtMDNE3-x18paZZj_tNs','林育新','',1,'3b7zsv',1,'',0),('','黄伊姿','',1,'3ihyx9',0,'',0),('','陈鹏志','',1,'3twsdi',0,'',0),('','邓有鹏','',1,'3vngd3',0,'',0),('olJ-hjvvOLyIew65gPV5W2JhciDE','吕双全','1 4 5 7',1,'3vxqoe',1,'3 5 6 8 9 10 12',2),('olJ-hjqv9Cye8wQRWpiNiyIAs6uk','张羽怡','7 1 2 4 5 6',1,'4cgs8a',1,'1 8 11 12 3 9 11',2),('','苏贵宾','',1,'4cj2wl',0,'',0),('olJ-hjom1374p_2HSg1nIZzSJ6p0','陈华环','4 5 8',1,'4cx9wb',1,'1 2 3 12 7 9 10',2),('olJ-hjgLgVaDB6oCS2PCeosJNngM','袁伟佳','1 3 4 5 7 8',1,'4tmn8c',1,'1 5 6 7 8 11 12',2),('olJ-hjuvxyli0TQpTP5HHQyXOTi0','叶炽凯','8 8 8 8 8 8',1,'570zuq',1,'1 2 3 5 8 9 11',2),('olJ-hjkI4jidNaC5t0hVaLeh5kRY','庞登广','1',1,'5odpxl',1,'',1),('olJ-hjiwc4Rt4Oo9WxGFv5LRixQs','邱迪聪','3 4 5 6 8',1,'63ustx',1,'3 4 5 10 11 12',2),('olJ-hjvPxDuyKj7mS26mWl67W9lk','罗斯','',1,'67s8md',1,'',0),('','吴俊宇','',1,'68dhqz',0,'',0),('olJ-hjh6r3-rD7cWsYP1o7rEyQII','李骁','',1,'69myio',1,'',0),('olJ-hjiu3TEIBnbsH1igepL3IDdo','熊力','1',1,'6fp90x',1,'2 10',2),('olJ-hjmkCQKGnsw1N_3UPDhSeeEs','洪泽铨','4 5 6 7 8',1,'6h3hyr',1,'1',2),('olJ-hjkdbgBuhYg818vRpZ2e9I3Y','常昊天','2 4 5 6 7 8',1,'6ilwkc',1,'1 2 3 5 6 8 10',2),('olJ-hjsK4DXzaJsY_CjnpRy7vlY4','王学灿','2 3 5 6 7 8',1,'6qn3eq',1,'1 2 3 5 8 9 11',2),('olJ-hjg8vYV358A3rcf6djvi39k8','关璐','1',1,'6x389a',1,'2 5 8 9 3 11 12',2),('olJ-hjkTyjWMN2AmCSHhGo8p_6y0','徐欣','1 2 5 6 7 8',1,'740pk2',1,'3 4 5 6 7 10 11',2),('olJ-hjlVb1qJneGGRy3XMBWVhci8','钟盼盼','',1,'76cwpp',1,'',0),('','陈昱升','',1,'77z756',0,'',0),('olJ-hjoLB1zsmyIFFqNr3XnHQ7x4','宿志鹏','6',1,'7diplx',1,'2 3 4 9 10 11 6',2),('olJ-hjpuBoPw25CN6xigWaucLuHg','石晓辉','',1,'7emrfe',1,'',0),('olJ-hjl9h5HP3oR8EIU6nXwGW8JU','胡江川','3 4 7 8',1,'7gljn6',1,'3 5 8 9 10 11 12',2),('','张炜杰','',1,'7k2mk3',0,'',0),('olJ-hjhtSP-FgA2CjAFu18RylGyI','汪欣言','6',1,'7vfonh',1,'2 6 8 9 11 12 10',2),('olJ-hjuOYkzfnALJ9wGN6zSUHSSc','闫晓敏','6',1,'7w5wih',1,'1 3 5 7 8 9 11',2),('','杨培君','',1,'8esn8g',0,'',0),('','左君博','',1,'8nh4xu',0,'',0),('','陈子轩','',1,'8rnp34',0,'',0),('olJ-hjjUCfttVu__qpzB0XbCX2NQ','田澍','',1,'8svk1k',1,'',0),('olJ-hjqphuk42M9ubdDqgfI7jTks','王挺','8 6 4 2 1 5',1,'8vjoak',1,'1 5 9 6 10 11 12',2),('olJ-hjm27zE3dMHwrSAaZrNgBoF0','周启贤','1 3 5 6 7 8',1,'96qfx2',1,'1 3 5 6 9 10 11',2),('','苏嘉阳','',1,'9dh772',0,'',0),('olJ-hjq9K8BWOUEcDEqcPmNwx3Yk','康伟丹','1 4 5 6 7 8',1,'9f8ld4',1,'1 3 5 6 10 11 12',2),('olJ-hjv_68K-Qh_yqWiqKXbP5RK8','刘振东','4 4 4',1,'9gulj2',1,'',1),('olJ-hjp_D7Agn4dlU49cMmZhmdYk','梁日荣','1 2 3 4 5 6',1,'9nn6pw',1,'',1),('olJ-hjskMP7qHTXI5AAt4AQhvnvA','叶铭毅','6',1,'9uuce1',1,'2 3 4 10 11 12',2),('olJ-hjild18uch1lPaXmH0p3rn1A','廖绪磷','',1,'a5k8cp',1,'',0),('olJ-hjtnpId-KG7b6JW0cllXN_Mk','龚琬婷','1 3 5 6 7 8',1,'a7xi9z',1,'1 5 7 8 9 10 12',2),('olJ-hjoa3TJzFYso789e2batiojE','陈响','1 2',1,'aagrjj',1,'2 5 8 10 11 12',2),('olJ-hjsdJ2dMzyasA9AGiX1UW9oQ','马亚光','',1,'aejy58',1,'',0),('olJ-hjtlzAh-N2mEiWZJGR697T_U','余浩强','3 4 5 7',1,'ahwhcm',1,'1 3 7 8 9 10 11',2),('olJ-hjgSObMExaRZEQUmNQ5mOE_M','李展文','6',1,'alebtk',1,'6 7 8 9 10',2),('','吴晓彤','',1,'alw155',0,'',0),('olJ-hjnGEFmH7IB9v_ZCAbDcjm30','林俊凡','3 4 5 6 7 8',1,'aw8eme',1,'1 2 3 9 10 11 6',2),('olJ-hjkZZXjeQnT_XRxL4f3DEaBA','鲁一鸣','3 4 6',1,'azwhjr',1,'9 6 1 3',2),('olJ-hjtpTBNw21Utkm_fC8968RUw','张初成','1 6',1,'b5u0cw',1,'3 7 9 10 11 12',2),('olJ-hjt53eRvbn38yBHtcbUriZAk','黄炼楷','4',1,'b5wayi',1,'1 1 2 7 7 9 12',2),('olJ-hjm5CX7wbbfBYgXisgSqKk5k','葛剑航','',1,'b8dbwt',1,'',0),('olJ-hjpGBXammBHG5_Gi4sUIX3fU','林国雄','1 2 4 6 7 8',1,'bd6vdk',1,'1 2 3 5 9 10 11',2),('','陈铭津','',1,'bstba1',0,'',0),('olJ-hjpGVD4lHf_Tj9h6_98MskRY','冯中俊','6',1,'bubmhs',1,'1 9',2),('olJ-hjs444MBLO4ocQSO_Ztmg9q0','顾海月','4 8 1 2 3 5',1,'bv38m6',1,'1 3 5 7 9 10 12',2),('olJ-hjsgvXTlOGWeYmLi_N1O4_rI','陈磊','',1,'bwr8sj',1,'',0),('olJ-hjlhVXfUhq_BDL8JGQeylOTA','黄嘉敏','1',1,'chau6z',1,'',1),('','刘永康','',1,'ckx0dl',0,'',0),('olJ-hju-R4nKy6LCgRPynFrviAt8','唐文强','3 6',1,'cmnpgw',1,'9 10 12',2),('olJ-hjhkP3kpZTZ_iWuDHqvd09AU','罗添仁','3 4 5 6 7 8',1,'cnuj5q',1,'1 3 5 7 8 9 10',2),('olJ-hjlzKh3T4jL4MahALPtq0LFc','罗运姣','',1,'cqmu7g',1,'',0),('olJ-hjiQ-vOWopjc1SvYinsrsSWo','彭够妹','8 7 5 3 4 6',1,'cuvwpb',1,'3 4 5 7 10 12 11',2),('','温景新','',1,'cvytgt',0,'',0),('olJ-hjnHm3r5nLpI0dXYnQFf6aLA','邱彩珊','2 4 5 6 7 8',1,'cwd54d',1,'1 5 6 8 10 11 12',2),('','傅梦圆','',1,'d443k4',0,'',0),('olJ-hjqJoVB8dXhXNK5U1oTGrNhQ','刘经伦','',1,'dacenj',1,'',0),('olJ-hjs4OH6zwlY0-KcGECz3J9Co','黄珑','1 1 1 1 1 1',1,'dieb4g',1,'1',2),('olJ-hjkLAY9Qwrc7dW-bxhbiSCdM','崔颢','1 2 3 5 6 8',1,'dtwpfi',1,'1 3 5 7 8 9 10',2),('','谈润杰','',1,'ducol4',0,'',0),('olJ-hjm96j3IDtqUonQ51pkEPUo4','黄志婷','1 2 3 5 7 8',1,'edej7r',1,'1 3 4 5 8 10 11',2),('olJ-hjtW-xeia797b4tH82z_5plw','叶嘉祺','6',1,'ekq85w',1,'1 3 5 9 12',2),('olJ-hjlf5I1NvTfaViPDy5qinjvM','蒋志强','',1,'eonz99',1,'',0),('olJ-hjm7-395IpPBVuPMDP_uHAVY','叶嘉骏','3 5 7 8',1,'filscs',1,'',1),('','方弼清','',1,'fmyq4d',0,'',0),('olJ-hjinnZJfJnrSS5d_VjvUBlw4','何隆滨','3 4 5 6 7 8',1,'fo6i6r',1,'1 2 5 6 10 11 12',2),('olJ-hjqbL56eRWKNFNW1L-Jimv6A','张婷婷','6',1,'fronwl',1,'1 3 5 7 9 10 11',2),('olJ-hjiafuaNLVZAF2R-SqQKAJhw','陈群锋','1 2 3 4 5 6',1,'fxuldb',1,'7 2',2),('olJ-hjimww0N2yAWDX-9R_Pa487A','江华君','3 4 5 6',1,'fz06l0',1,'2 3 4 7 8 9 11',2),('olJ-hjk4axTskNz5CuOb2XBuDPYI','高璐','1 3 5 6 7 8',1,'g4pquf',1,'2 3 5 6 7 10 11',2),('olJ-hjoiPqenWu-2fFFwlXRh4fIA','周小静','1 3 6 7 8',1,'gh46qc',1,'2 3 5 6 7 10 12',2),('olJ-hjjHITpTyy0_n6DYzW7tsbMQ','张天意','3 4 5 6 7 8',1,'gzgagz',1,'1 5 8 9 10 11 12',2),('olJ-hjkYf1MkJwRmjlUKoD8K2rew','卢健','4 4 4 4 4 4',1,'h0901q',1,'12 12 12 12 12 12 12',2),('','王喆','',1,'h232oq',0,'',0),('olJ-hjpp8i1453DrHqJI_UbtsJhs','郑詠心','1 4 5 6 7 8',1,'h44axl',1,'3 4 5 7 9 11 10',2),('olJ-hjhHbaguTlhSsZQPqApBb4e4','高原','1',1,'hdniqg',1,'3 5 7 10 11 12',2),('olJ-hjgTmLQ3BY7e4jTf6I-sw8gg','谢明森','6',1,'hey5to',1,'2 3 4 9 10 11',2),('olJ-hjuqsYNOLrQsYe9eD7lXk1O0','闫琰','1',1,'hhisay',1,'3 5 7 11 12 9 10',2),('olJ-hjnUHdkaiv-5dCi1R1I1z70Y','薛昭','',1,'hpzkwj',1,'',0),('olJ-hjtZc0tprcs4NJB3B4o3Xwlw','吴腾','1',1,'hvneec',1,'',1),('olJ-hjoQ_iN6h_yuAk_aHLkC7KOI','夏孟友','2 3 4 5 7 8',1,'hvr3y8',1,'',1),('olJ-hjhx9WKfYVudrZrZO93wIETw','蔡艳','6',1,'ia3z0o',1,'1 3 6 9 10 11 12',2),('','王梓杰','',1,'iceouc',0,'',0),('olJ-hjmai4RMdCmo3CyDT0IQ3uIk','周亮','2 4 5 6 7 8',1,'ifcwmc',1,'2 5 6 7 10 11 12',2),('','陈冰','',1,'j0gjj6',0,'',0),('olJ-hjihc1jd3vD_qUUOYDsBmD18','徐称称','4 5 7 8',1,'j41jte',1,'5 6 9 10 11 12',2),('olJ-hjlelXVOomzq6jlNfMDC4ks4','胡高佳','7 8 6',1,'j5he7h',1,'1 2 3',2),('','陈慧冰','',1,'jhfryr',0,'',0),('olJ-hjrXJdohB0L7FNZOhfLjnEkU','莫冠钊','3 4 5',1,'jjufpc',1,'1 3 4 5 8 9 10',2),('olJ-hjj2n6ocu2TmkXhlibwWIqwo','黄仲祺','',1,'jrz9t4',1,'',0),('olJ-hjrPsZXfDso9ZVlVw21yjI_k','胡立恒','3',1,'jse6mt',1,'',1),('olJ-hjhcbemLsfQefSJl23qE-Etw','邓小康','',1,'jsowit',1,'',0),('olJ-hjgUsZRHK3B3tAYsMLB4FpE0','利伟健','1 3 4 5 6 7',1,'jw9gxp',1,'1 3 4 6 8 9 10',2),('olJ-hjphM8znlJEnl9ANscAVOJ_A','张远玮','4 7',1,'jzxvlg',1,'1 5 3 2 8 9 11',2),('olJ-hjl8Lx1cbsbXQdDCO3wpwR1I','刘冠志','',1,'kbpmro',1,'',0),('','李嘉琦','',1,'kjz80r',0,'',0),('olJ-hjiL1VlUFIbYFu7HAGd8KOCY','连沛轩','1 2 4 5 7 8',1,'kt8wt2',1,'1 2 3 4 6 9 10',2),('olJ-hjpUi4UV1Z10vpaniKWEvZbI','陆莹','1',1,'l6errf',1,'',1),('olJ-hjtqyUeD7Sm3O0vlpyLyvnsI','季浩泽','3 4 5 7 8',1,'lftosr',1,'3 5 7 8 10 11 12',2),('olJ-hjofB4e1BG5NdaWT6sBjkysM','吴沛霖','1 2',1,'louxrn',1,'5 5 5 5 5 5 5',2),('olJ-hjmPIrciR0pdLVom2CvqGcro','陈泽宇','1 3 4 5 6 8',1,'loxxdw',1,'2 3 6 7 8 11 12',2),('olJ-hjh7ZEweKBil-giBABJ9y_HI','喻乐','7 4',1,'lseask',1,'9 1',2),('olJ-hjtcdDRWzEeF9urs937xRVLI','李亦卿','3 4 5 6 7 8',1,'luu5d9',1,'1 2 3 5 10 11 12',2),('olJ-hjilS7utgTVkF_uEjUmWPTx0','方学宇','',1,'m3ud22',1,'',0),('','李建成','',1,'m4b0mx',0,'',0),('oMDgBj2ANrOcCtQaGRjQ6PMtvmxI','管理员','',0,'master_ctdt_2014',1,'',0),('','何金连','',1,'mg97m4',0,'',0),('olJ-hjtkg2DMXjgKmorjT43pjoa0','王金鑫','1 2 3 5 7',1,'mgp383',1,'',1),('olJ-hjjbC_bQZ7z0zv2X7uw9Mnwk','张天晴','1',1,'mhbn7i',1,'3 7 10',2),('','白杨','',1,'mn07xw',0,'',0),('olJ-hjt6Ih6yhRfiLV2LP6Jrwa7o','郑镇贤','1',1,'mobdg4',1,'1 5 6 4 8 2 7',2),('olJ-hjnFZmUtNRPdunEmYFaviznk','黎洋','3 8',1,'mtymqt',1,'3 4 8 9 10 11 12',2),('olJ-hjmPEV9efTxlfdRW0hw1CDc0','江绍峰','6',1,'mui99d',1,'2 3 5 9 10 11 12',2),('olJ-hjoLOor8ZQ171Af3EIUQv6tY','莫世苑','3 4 5 6 7 8',1,'mupgg7',1,'3',2),('olJ-hjj3J1Lls8Bz8V3HP48z_eXY','杜小庆','2 4 5 6 7 8',1,'n0t1jr',1,'1 2 3 9 10 11 12',2),('olJ-hjs99lpowkfePuLacc4ce9X0','朱侨荣','',1,'n5p9hf',1,'',0),('olJ-hjr5seT3IoTkk2SI8kXB8NrU','敖凌洲','2 4 5 6 7 8',1,'n89bqx',1,'1 2 3 6 7 10 12',2),('','何衡','',1,'n9hq61',0,'',0),('olJ-hjtHKl5tuwqmX_lMpr0k53WE','陈侨安','1 1 1 1 1 1',1,'ngigyr',1,'1 3 5 7 9 10 11',2),('olJ-hjsjptkvZlHMGE7WjHxv4_m0','郑雅迪','1',1,'njdzjn',1,'3 9 11 10',2),('olJ-hjlMc9n-2_KYNMS7J6R4TFKo','张志翔','1',1,'nkq6tj',1,'3 8 10 11 5 9 12',2),('olJ-hjhbZRl7GaRBmyrwc3LyGthc','魏毓航','1',1,'nzzm0a',1,'11 7 3 9 2 6 12',2),('','郑少涌','',1,'o5uu7o',0,'',0),('','杜艺菲','',1,'oncw7a',0,'',0),('olJ-hjg2mG5DXNZucWosBHj5gb5g','周冰楠','',1,'oqw3b0',1,'',0),('','孙薪','',1,'or5t0v',0,'',0),('','谢议尊','',1,'osasxx',0,'',0),('olJ-hjrbmPDhwIhy0y-O_dUeSf34','孙砚','1 2 3 5 7 8',1,'ovbzt1',1,'1 3 4 7 10 9 6',2),('olJ-hjhoNZbN893PD0bRpsyhAVB4','许莉','8',1,'ozaafa',1,'1 3 5 6 8 10 11',2),('olJ-hjhm9Ni_XgZ88cALKvxmGUSs','曾艳红','2 3 4 5 7 8',1,'paojvy',1,'2 3 8 9 10 11 12',2),('','林楚庭','',1,'pbn2pf',0,'',0),('olJ-hjh_SWx2MhBs4UDLVv6yrrFg','张博南','7 4 5',1,'pedee1',1,'9 1 5',2),('olJ-hjkhZJBt2uoVUdsNE2f7cCK8','林逸凡','1 3 4 5 7 8',1,'pmjxbs',1,'',1),('olJ-hjm4a21aupS92DE9mOVlmHZc','叶铭毅','6',1,'pw9kpq',1,'1 2 3 5 9 10 11',2),('olJ-hjoGxPuK4bX0q8Cn93tN8nls','李胜沛','6',1,'qe14ey',1,'',1),('olJ-hjiOc_bZwIcb5mKyspNkuXzw','郑雯琪','1 5 7',1,'qrx807',1,'1 8 9 11',2),('','罗云涛','',1,'qw43zz',0,'',0),('olJ-hjrT9qtBH9dNRmMkiBat6r08','许洋','',1,'r0uou9',1,'',0),('olJ-hjhJxzmOyixmvgdpbUKtc_4Y','周少雄','4 7',1,'r2a940',1,'1 2 3 8 9 11',2),('olJ-hjvBMo9z0OKIZyNl20tm7Tvo','杨振杰','5 6',1,'r753oy',1,'3 5 9 10 11 12',2),('olJ-hjiAyCNrmr_gDwBuagFkwraA','郑燕于','1 2 4 6 7',1,'r7ax6t',1,'1 2 6 8 11 12',2),('olJ-hjjgJQdNNGku9fvCIljbeB6Y','郑卓彬','3 4 5 6 7 8',1,'re7dxv',1,'1 4 8 9 11',2),('','牟夏松','',1,'s2d64r',0,'',0),('olJ-hjnksqbXHA8zgFY3Iq5eWBAg','张晓武','3 4 5 6 7 8',1,'s2gwy4',1,'3 4 5 1 10 11 1',2),('olJ-hjiGfK4ryI8mmgtDtczkwz8k','杨煜荣','1',1,'s9qf97',1,'2 3 6 8 9 11 12',2),('','陈卓君','',1,'sqt77c',0,'',0),('olJ-hjrLCCDsZ157H8XaEjkEN72w','刘启明','1 4 5 8',1,'srvwe3',1,'2 3 4 6 8 10 11',2),('','管理员2','',0,'sstdcenter_2014',0,'',0),('olJ-hjvoqbttvP5ZawOMhAwQY_CE','管理员3','',0,'sstd_2014',1,'',0),('olJ-hjo47zp9o3-piyFLqP5N1AMI','毛庆文','',1,'t035qd',1,'',0),('olJ-hjgOJF_Ue4ruFrhfwrpEsJhw','邓霭霖','2 3 6 7 8',1,'t6jb11',1,'3 4 5 6 8 10 11',2),('olJ-hjqHK1D3xxMomc9MLz4A6GLA','樊夏玥','6',1,'t8bl08',1,'2',2),('olJ-hjokwu1HqJWa5IzVtIKTF6HE','林创伟','1',1,'t8slzt',1,'1 3 5 6 9 10 11',2),('olJ-hjhOBliuGRUnlXv2vmyF0uQM','胡震','2 3 4 5',1,'tbwlft',1,'10 11',2),('olJ-hjkmmfVaYVX_B716ugjap5lc','尤远','1 3 4 5 7 8',1,'tm5f4w',1,'1 2 5 7 8 11 12',2),('','魏杰伟','',1,'u1ilvg',0,'',0),('','林健宏','',1,'udbtmx',0,'',0),('olJ-hjh0-pzYoUhw9i5g0qxyBjkQ','李嘉','',1,'uoy0az',1,'',0),('','范文卓','',1,'us8216',0,'',0),('olJ-hjjEMjVahgrE36CWg9_11f2I','戴嘉华','3 4 5 6 7 8',1,'v0iqut',1,'7 1 2 3 4 9 10',2),('olJ-hjgTfCAC82xPafLiRGoLj8mM','宋凯','1',1,'v82hvo',1,'',1),('olJ-hjqAYSWv7YNkFGiymCsfYiHQ','陈坤俊','1 3 5 6 7 8',1,'v9tg2g',1,'2 3 5 7 9 10 11',2),('olJ-hjiVsSvF-yJ87PwPviERzqMY','龚琪莹','2 3 4 5 7 8',1,'va36xa',1,'3 4 5 6 10 11 12',2),('','吴金霞','',1,'vdiiem',0,'',0),('olJ-hjkllKX7En3wGu2sH6EXiRKM','王宇翔','1 5 6 7 8',1,'vf8sjg',1,'2 6 10',2),('olJ-hjq4ORN1LLvhoZGtUlK29iBU','马先明','1 2 3 4 5 6',1,'vp7fml',1,'2 6 10',2),('olJ-hjjKeXVfKGqNWZuMp0Smi2n8','李鑫','1 7 8',1,'vq7780',1,'1 3 5 9 11 12',2),('','徐称称','',1,'w69yaz',0,'',0),('olJ-hjnOWeJXf3d3HcyquBIlFxR0','沈成晟','3 4 5 6 7 8',1,'wo0gzp',1,'1 2 3 5 6 7 10',2),('olJ-hji2jWIvs8Oae1NLadweD2dI','肖志栋','4 6 8',1,'ww37r1',1,'2 3 5 6 10 11 12',2),('','徐泽斌','',1,'x9xbhq',0,'',0),('','侯文林','',1,'xcflwr',0,'',0),('olJ-hjhtBEE9B5f6kw8NbE8AExD0','李雪','3 4 5 6 7 8',1,'xds7ap',1,'6 7 8 9 10 11 12',2),('olJ-hjjFG4DFJpeF53F4N84N6GhY','杨宇灏','8 5 7 3 1 4',1,'xqoppx',1,'2 3 7 8 9 11 12',2),('olJ-hjoep4AqdwHcGrpPopYtslaA','林晨舸','3 5 7',1,'xw7vfr',1,'9 1',2),('olJ-hjogdWzpLi__8-CtzjXIAinA','张浩宇','1 3 5 6 7 8',1,'y0xvrq',1,'1 3 8 9 11',2),('olJ-hjhfhiJU5IxZJ6rxuH-QMRKE','邓圣杰','1 5 3',1,'y2selq',1,'2 6',2),('olJ-hjh5KE8nRW7EoCiyspfd4x4Q','王登昊','',1,'y7nlcd',1,'',0),('olJ-hjjlKRjxTZa4zGr9BP18LK8Q','林虎','',1,'ycpty5',1,'',0),('olJ-hjn4kIi9yxrEKd_af4vO6jBk','张子轩','2 6 7',1,'ydful5',1,'7 11 10 9',2),('olJ-hjudLRBTQ_rMow9bcD_uOUYM','刘育江','',1,'ygfgm9',1,'',0),('olJ-hjhaasN4W0nJvQ9mtRsRBvT8','吴家荣','6',1,'yky6nt',1,'1 3 5 7 9 10 12',2),('olJ-hjv19bM9jlwluyh0V4yLJLiY','吴晓华','6',1,'yn0row',1,'',1),('olJ-hjtMPxkfiKFUJMhLXSs37r0Q','杜盈仪','4 7 8',1,'yon3jy',1,'2 6 12',2),('olJ-hjhJNFhXSMy4YBm2B-GC2D7U','李丽珊','1 3 4 5 7 8',1,'z0ax68',1,'',1),('','李昂','',1,'z4zo9b',0,'',0),('olJ-hjhudygY6GcYkBf5oE5mUR4w','杨柳','6',1,'z5qeho',1,'2 6 7 8 9 11 12',2),('olJ-hjgu9YKopR-d7KCsvscHQdiQ','林木得','1 2 3 2 3 1',1,'z8q3zm',1,'7 8 9 10 11 7 6',2),('olJ-hjhM-CBlcYcU6D7digumkNnA','陈弘桂','1 2 3 4 5 7',1,'ztas31',1,'1 2 3',2),('olJ-hjlMvBMkWTmYXY_Rf36gA8w4','丘南海','',2,'丘南海',1,'',0),('olJ-hjiWhQsRH06ZQPs3y1p2WF9o','侯雪莹','',2,'侯雪莹',1,'',0),('olJ-hjt-hN6ZmD0B4L-XVFaYrjpE','廖喜扬','',2,'廖喜扬',1,'',0),('olJ-hjjtf5tp33msqsfmKcpUh6XI','张硕辰','',2,'张硕辰',1,'',0),('','谭英耀','',2,'谭英耀',0,'',0),('olJ-hjn0Lb6korIAN37tR6Vu9x6c','黄玲娟','',2,'黄玲娟',1,'',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_info`
--

DROP TABLE IF EXISTS `vote_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vote_info` (
  `state` int(11) NOT NULL,
  PRIMARY KEY (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_info`
--

LOCK TABLES `vote_info` WRITE;
/*!40000 ALTER TABLE `vote_info` DISABLE KEYS */;
INSERT INTO `vote_info` VALUES (4);
/*!40000 ALTER TABLE `vote_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-05-17 11:17:12
