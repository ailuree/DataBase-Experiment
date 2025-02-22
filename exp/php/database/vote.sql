-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 06, 2014 at 04:58 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `vote`
--
CREATE DATABASE IF NOT EXISTS `vote` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `vote`;

-- --------------------------------------------------------

--
-- Table structure for table `candidate`
--

CREATE TABLE IF NOT EXISTS `candidate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `introduction` text NOT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=45 ;

--
-- Dumping data for table `candidate`
--

INSERT INTO `candidate` (`id`, `name`, `introduction`, `score`) VALUES
(1, '朴信惠', '韩剧《继承者们》的女主角\r\n', 8051),
(2, '李敏镐', '韩剧《继承者们》的男主角', 7597),
(3, '陈意涵', '台剧《痞子英雄》的女主角', 12895),
(4, '张钧宁', '台剧《你照亮我星球》的女主角', 14857),
(5, '金泰希', '韩剧《特务情人 IRIS》的女主角', 10875),
(6, '李炳宪', '韩剧《特务情人 IRIS》的男主角', 8000);

-- --------------------------------------------------------

--
-- Table structure for table `id_number`
--

CREATE TABLE IF NOT EXISTS `id_number` (
  `id` varchar(10) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
