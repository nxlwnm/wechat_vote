-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2014 at 01:56 AM
-- Server version: 5.5.32
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `vote`
--
CREATE DATABASE IF NOT EXISTS `vote` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `vote`;

-- --------------------------------------------------------

--
-- Table structure for table `club`
--

CREATE TABLE IF NOT EXISTS `club` (
  `id` int(11) NOT NULL,
  `name` varchar(11) CHARACTER SET utf8 NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `club`
--

INSERT INTO `club` (`id`, `name`, `count`) VALUES
(1, '曹婉婷', 0),
(2, '丰光南', 0),
(3, '胡南', 0),
(4, '黄宇阳', 0),
(5, '许纬闽', 0),
(6, '王禹尊', 0),
(7, '王粤秀', 0),
(8, '王粤秀', 0);

-- --------------------------------------------------------

--
-- Table structure for table `management`
--

CREATE TABLE IF NOT EXISTS `management` (
  `id` int(11) NOT NULL,
  `name` varchar(11) CHARACTER SET utf8 NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `management`
--

INSERT INTO `management` (`id`, `name`, `count`) VALUES
(1, '毕胜', 0),
(2, '焦轩', 0),
(3, '梁宇嫣', 0),
(4, '刘希海', 0),
(5, '王子城', 0),
(6, '张彧', 0),
(7, '张泽锦', 0),
(8, '周中柱', 0);

-- --------------------------------------------------------

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
-- --------------------------------------------------------

--
-- Table structure for table `vote_info`
--

CREATE TABLE IF NOT EXISTS `vote_info` (
  `state` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vote_info`
--

INSERT INTO `vote_info` (`state`) VALUES
(0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
