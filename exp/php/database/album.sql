-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 06, 2014 at 11:25 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `album`
--
CREATE DATABASE IF NOT EXISTS `album` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `album`;

-- --------------------------------------------------------

--
-- Table structure for table `album`
--

CREATE TABLE IF NOT EXISTS `album` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `owner` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `album`
--

INSERT INTO `album` (`id`, `name`, `owner`) VALUES
(1, '元元精选集 1', 'jerry'),
(2, '元元精选集 2', 'jerry'),
(3, '小绵羊丑小鸭篇', 'jerry'),
(4, '爱情鸟撒野篇', 'jean'),
(5, '爱情鸟洗澡篇', 'jean'),
(6, '小绵羊成熟篇', 'jerry'),
(7, '小绵羊天鹅篇', 'jerry'),
(8, '小绵羊爱困篇', 'jerry'),
(9, '瓜瓜肉鸡', 'jerry');

-- --------------------------------------------------------

--
-- Table structure for table `photo`
--

CREATE TABLE IF NOT EXISTS `photo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `filename` varchar(64) NOT NULL,
  `comment` varchar(512) DEFAULT NULL,
  `album_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=134 ;

--
-- Dumping data for table `photo`
--

INSERT INTO `photo` (`id`, `name`, `filename`, `comment`, `album_id`) VALUES
(26, 'IMG_0152.jpg', '49db3a1c689f8.jpg', NULL, 1),
(27, 'IMG_0160.jpg', '49db3a1c80931.jpg', NULL, 1),
(28, 'IMG_0164.jpg', '49db3a1c93876.jpg', NULL, 1),
(29, 'IMG_0165.jpg', '49db3a1ca75ba.jpg', NULL, 1),
(30, 'IMG_0166.jpg', '49db3a2b315ab.jpg', NULL, 1),
(31, 'IMG_0167.jpg', '49db3a2b45822.jpg', NULL, 1),
(32, 'IMG_0168.jpg', '49db3a2b5b33c.jpg', NULL, 1),
(33, 'IMG_0169.jpg', '49db3a2b6e5f6.jpg', NULL, 1),
(34, 'IMG_0170.jpg', '49db3a35ab078.jpg', NULL, 1),
(35, 'IMG_0171.jpg', '49db3a35bf2eb.jpg', NULL, 1),
(36, 'IMG_0173.jpg', '49db3a4aa83f1.jpg', NULL, 2),
(37, 'IMG_0176.jpg', '49db3a4abce52.jpg', NULL, 2),
(38, 'IMG_0178.jpg', '49db3a4ad1bfd.jpg', NULL, 2),
(39, 'IMG_0179.jpg', '49db3a4ae64e5.jpg', '唷... 我只是虚胖啦', 2),
(40, 'IMG_0180.jpg', '49db3a526a619.jpg', NULL, 2),
(41, 'IMG_0181.jpg', '49db3a528042e.jpg', NULL, 2),
(42, 'IMG_0182.jpg', '49db3a5295929.jpg', NULL, 2),
(58, 'IMG_0324.jpg', '49db3d094bd08.jpg', NULL, 4),
(61, 'IMG_0318.jpg', '49db3e217abd1.jpg', NULL, 4),
(62, 'IMG_0321.jpg', '49db3e21c6dc3.jpg', NULL, 4),
(63, 'IMG_0322.jpg', '49db3e21e94d0.jpg', NULL, 4),
(64, 'IMG_0315.jpg', '49db3e2218185.jpg', NULL, 4),
(65, 'IMG_0316.jpg', '49db3e2644648.jpg', NULL, 4),
(66, 'IMG_0333.jpg', '49db40054a0e9.jpg', NULL, 5),
(67, 'IMG_0331.jpg', '49db40056b188.jpg', NULL, 5),
(68, 'IMG_0338.jpg', '49db40058b684.jpg', NULL, 5),
(69, 'IMG_0343.jpg', '49db4005b517d.jpg', NULL, 5),
(70, 'IMG_0344.jpg', '49db400ec7021.jpg', NULL, 5),
(71, 'IMG_0345.jpg', '49db400ef0661.jpg', NULL, 5),
(72, 'IMG_0346.jpg', '49db400f22eea.jpg', NULL, 5),
(73, 'IMG_0467.jpg', '49db419f58ff9.jpg', NULL, 6),
(74, 'IMG_0471.jpg', '49db419f7b0c6.jpg', NULL, 6),
(75, 'IMG_0465.jpg', '49db419f9c858.jpg', NULL, 6),
(76, 'IMG_0462.jpg', '49db419fbb709.jpg', NULL, 6),
(77, 'IMG_0459.jpg', '49db41a90fb50.jpg', NULL, 6),
(78, 'IMG_0453.jpg', '49db41a931f9b.jpg', NULL, 6),
(79, 'IMG_0430.jpg', '49db41a9514c2.jpg', NULL, 6),
(80, 'IMG_0192.jpg', '49db42a261ef0.jpg', NULL, 7),
(81, 'IMG_0193.jpg', '49db42a2870e1.jpg', NULL, 7),
(82, 'IMG_0191.jpg', '49db42a2db83e.jpg', '装无辜', 7),
(83, 'IMG_0190.jpg', '49db42a306864.jpg', '人家长大变漂漂了', 7),
(84, 'IMG_0189.jpg', '49db42ac60140.jpg', NULL, 7),
(85, 'IMG_0188.jpg', '49db42ac80fcb.jpg', NULL, 7),
(86, 'DSC00052.JPG', '49db446185238.jpg', NULL, 8),
(87, 'DSC00051.JPG', '49db4461c4702.jpg', NULL, 8),
(88, 'DSC00050.JPG', '49db44620c0df.jpg', NULL, 8),
(89, 'DSC00049.JPG', '49db4462403da.jpg', NULL, 8),
(90, 'DSC00048.JPG', '49db446c41da9.jpg', NULL, 8),
(91, 'DSC00047.JPG', '49db446c800ce.jpg', NULL, 8),
(92, 'DSC00046.JPG', '49db446cbbc44.jpg', NULL, 8),
(93, 'DSC00045.JPG', '49db446d04f63.jpg', NULL, 8),
(94, 'DSC00044.JPG', '49db447809049.jpg', NULL, 8),
(95, 'DSC00043.JPG', '49db447847984.jpg', NULL, 8),
(96, 'DSC00042.JPG', '49db447885d04.jpg', NULL, 8),
(97, 'DSC00041.JPG', '49db4478c353e.jpg', NULL, 8),
(98, 'DSC00040.JPG', '49db448a07b30.jpg', NULL, 8),
(99, 'DSC00039.JPG', '49db448a44ef4.jpg', NULL, 8),
(100, 'DSC00038.JPG', '49db448a7d7f1.jpg', NULL, 8),
(101, 'DSC00037.JPG', '49db448ab4c4e.jpg', NULL, 8),
(102, 'DSC00036.JPG', '49db44945cf40.jpg', NULL, 8),
(103, 'DSC00035.JPG', '49db44949c31c.jpg', NULL, 8),
(104, 'DSC00034.JPG', '49db4494d405d.jpg', NULL, 8),
(105, 'DSC00033.JPG', '49db44951617c.jpg', NULL, 8),
(106, 'DSC00032.JPG', '49db44a30fce1.jpg', NULL, 8),
(107, 'DSC00031.JPG', '49db44a345a77.jpg', NULL, 8),
(108, 'DSC00030.JPG', '49db44a3823c6.jpg', NULL, 8),
(109, 'DSC00029.JPG', '49db44a3bee7b.jpg', NULL, 8),
(110, 'DSC00028.JPG', '49db44acf0c18.jpg', NULL, 8),
(111, 'DSC00027.JPG', '49db44ad3b115.jpg', NULL, 8),
(112, 'DSC00026.JPG', '49db44ad6fd8d.jpg', NULL, 8),
(113, 'DSC00031.JPG', '49db45b507298.jpg', NULL, 3),
(114, 'DSC00030.JPG', '49db45b545317.jpg', NULL, 3),
(115, 'DSC00034.JPG', '49db45b57f05c.jpg', NULL, 3),
(116, 'DSC00035.JPG', '49db45b5b48fa.jpg', NULL, 3),
(117, 'DSC00037.JPG', '49db45c3b2351.jpg', NULL, 3),
(118, 'DSC00038.JPG', '49db45c3ee529.jpg', NULL, 3),
(119, 'DSC00041.JPG', '49db45c431796.jpg', NULL, 3),
(120, 'DSC00042.JPG', '49db45c4653a2.jpg', NULL, 3),
(121, 'DSC00043.JPG', '49db45cbf2db1.jpg', NULL, 3),
(122, 'DSC00044.JPG', '49db45cc37b12.jpg', NULL, 3),
(123, 'DSC00046.JPG', '49db45cc6e867.jpg', NULL, 3),
(129, 'IMG_20130828_002640.JPG', '53b915e68faaf.jpg', NULL, 9),
(130, 'IMG_20130828_002653.JPG', '53b915e6e55db.jpg', NULL, 9),
(131, 'IMG_20130828_184855.JPG', '53b915e74342e.jpg', NULL, 9),
(132, 'IMG_20130828_231020.JPG', '53b915eeed88e.jpg', NULL, 9),
(133, 'IMG_20130828_231449.JPG', '53b915ef51c73.jpg', NULL, 9);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `account` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`account`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`account`, `password`, `name`) VALUES
('jean', 'jean', 'Jean'),
('jerry', 'jerry', 'Jerry');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
