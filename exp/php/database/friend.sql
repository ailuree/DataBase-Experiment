-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 26, 2014 at 03:44 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `friend`
--
CREATE DATABASE IF NOT EXISTS `friend` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `friend`;

-- --------------------------------------------------------

--
-- Table structure for table `friend_club`
--

CREATE TABLE IF NOT EXISTS `friend_club` (
  `no` smallint(6) NOT NULL,
  `name` varchar(5) NOT NULL,
  `sex` char(1) NOT NULL,
  `age` varchar(10) NOT NULL,
  `star_signs` varchar(3) NOT NULL,
  `height` varchar(10) NOT NULL,
  `weight` varchar(10) NOT NULL,
  `career` varchar(10) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `friend_club`
--

INSERT INTO `friend_club` (`no`, `name`, `sex`, `age`, `star_signs`, `height`, `weight`, `career`) VALUES
(1, '孙小美', '女', '15 ~ 20', '双鱼座', '165 ~ 170', '50 ~ 55', '学生'),
(2, '小燕子', '女', '20 ~ 25', '牡羊座', '155 ~ 160', '45 ~ 50', '上班族'),
(3, '柏原崇', '男', '20 ~ 25', '天蝎座', '175 ~ 180', '65 ~ 70', 'SOHO 族'),
(4, '莫召奴', '男', '25 ~ 30', '天秤座', '175 ~ 180', '65 ~ 70', '上班族'),
(5, '叶小钗', '男', '30 ~ 35', '魔羯座', '165 ~ 170', '60 ~ 65', '老师'),
(6, '流川枫', '男', '15 ~ 20', '射手座', '180 ~ 185', '65 ~ 70', '上班族'),
(7, '林阿土', '男', '25 ~ 30', '牡羊座', '170 ~ 175', '65 ~ 70', '老师'),
(8, '赵冰冰', '女', '20 ~ 25', '处女座', '155 ~ 160', '45 ~ 50', '学生'),
(9, '嘟嘟', '男', '15 ~ 20', '狮子座', '165 ~ 170', '55 ~ 60', '学生'),
(10, '晴子', '女', '15 ~ 20', '双子座', '160 ~ 165', '45 ~ 50', '学生'),
(11, '小兰', '女', '25 ~ 30', '巨蟹座', '165 ~ 170', '50 ~ 55', '上班族'),
(12, '凯蒂', '女', '20 ~ 25', '双鱼座', '160 ~ 165', '45 ~ 50', '公务员'),
(13, '樱桃子', '女', '25 ~ 30', '天秤座', '155 ~ 160', '55 ~ 60', 'SOHO 族'),
(14, '亮亮', '女', '25 ~ 30', '射手座', '165 ~ 170', '50 ~ 55', '公务员'),
(15, '小齐', '男', '25 ~ 30', '水瓶座', '170 ~ 175', '55 ~ 60', '上班族'),
(16, '安琪', '女', '15 ~ 20', '狮子座', '165 ~ 170', '50 ~ 55', '学生'),
(17, '林达', '女', '20 ~ 25', '双鱼座', '165 ~ 170', '50 ~ 55', '公务员'),
(18, '陈小东', '男', '25 ~ 30', '魔羯座', '175 ~ 180', '65 ~ 70', '上班族'),
(19, 'CoCo', '女', '20 ~ 25', '狮子座', '170 ~ 175', '55 ~ 60', '上班族'),
(20, '安室', '女', '30 ~ 35', '处女座', '155 ~ 160', '45 ~ 50', '老师');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
