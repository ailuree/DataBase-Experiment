-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 30, 2014 at 02:32 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ecard`
--
CREATE DATABASE IF NOT EXISTS `ecard` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `ecard`;

-- --------------------------------------------------------

--
-- Table structure for table `card_message`
--

CREATE TABLE IF NOT EXISTS `card_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_id` varchar(30) NOT NULL DEFAULT '',
  `subject` tinytext NOT NULL,
  `from_name` varchar(30) NOT NULL DEFAULT '',
  `from_email` varchar(50) NOT NULL DEFAULT '',
  `to_name` varchar(30) NOT NULL DEFAULT '',
  `to_email` varchar(50) NOT NULL DEFAULT '',
  `music` varchar(30) NOT NULL DEFAULT '',
  `style` varchar(20) NOT NULL DEFAULT '',
  `size` varchar(10) NOT NULL DEFAULT '',
  `color` varchar(20) NOT NULL DEFAULT '',
  `message` mediumtext NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
