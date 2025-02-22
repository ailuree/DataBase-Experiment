-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- 主机: 127.0.0.1
-- 生成时间： 2014 广06 ??25 ??17:25
-- 服务器版本: 5.6.17
-- PHP 版本： 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库： `students`
--
CREATE DATABASE IF NOT EXISTS `students` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `students`;

-- --------------------------------------------------------

--
-- 数据表结构 `grade`
--

CREATE TABLE IF NOT EXISTS `grade` (
  `no` varchar(8) NOT NULL DEFAULT '',
  `name` varchar(8) NOT NULL DEFAULT '',
  `chinese` tinyint(4) NOT NULL DEFAULT '0',
  `math` tinyint(4) NOT NULL DEFAULT '0',
  `english` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 数据表的导出数据 `grade`
--

INSERT INTO `grade` (`no`, `name`, `chinese`, `math`, `english`) VALUES
('A8608001', '王大明', 88, 96, 92),
('A8608002', '陈小新', 95, 89, 99),
('A8608003', '小红豆', 80, 86, 89),
('A8608004', '章小倩', 85, 91, 93),
('A8608005', '李青青', 90, 96, 80),
('A8608006', '孙小美', 80, 77, 82),
('A8608007', '林小佩', 100, 98, 95),
('A8608008', '张美丽', 79, 87, 86),
('A8608009', '林娟娟', 75, 73, 79),
('A8608010', '钟玲玲', 78, 83, 84);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
