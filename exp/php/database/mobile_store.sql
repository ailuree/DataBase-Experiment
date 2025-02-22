-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 25, 2014 at 05:20 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mobile_store`
--
CREATE DATABASE IF NOT EXISTS `mobile_store` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `mobile_store`;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `book_id` int(11) NOT NULL,
  `image_name` varchar(32) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`book_id`, `image_name`, `description`) VALUES
(1, 'ACL037300.jpg', '价格：350　书号：ACL037300<br />网页开发人员升级至 HTML5 的最佳利器！'),
(2, 'ACL039600.jpg', '价格：540　书号：ACL039600<br/>★超值加码！使用 PhoneGap Build 将移动网站建设为跨平台 App！'),
(3, 'AEB002800.jpg', '价格：560　书号：AEB002800<br />访察多所院校的电子信息科系、理工科系教师意见编写而成，内容兼顾深度与广度，涵括最新信息科学的核心内容，并将研究所入学考试题型融合至内文、随堂练习与学习评测，为学生将来升学与就业提早做准备。'),
(4, 'AEB003100.jpg', '价格：520　书号：AEB003100<br />针对信息科学教育所设计，广泛且精要地探讨信息科学相关主题，内容涵盖信息科学的核心知识与实务应用。'),
(5, 'AEN003400.jpg', '价格：550　书号：AEN003400<br />完全针对网络概论、数据通讯所设计，广泛且精要地探讨网络与数据通讯相关主题，并纳入最新的技术信息与发展趋势。');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
