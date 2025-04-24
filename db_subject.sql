-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1
-- 生成日期： 2025-04-23 09:32:40
-- 服务器版本： 10.4.27-MariaDB
-- PHP 版本： 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `db_education2`
--

-- --------------------------------------------------------

--
-- 表的结构 `db_subject`
--

CREATE TABLE `db_subject` (
  `id` int(11) NOT NULL,
  `subject_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `db_subject`
--

INSERT INTO `db_subject` (`id`, `subject_name`) VALUES
(3, 'English Standard'),
(4, 'English Essentials'),
(5, 'English Advanced'),
(6, 'English Language'),
(7, 'English as an Additional Language'),
(8, 'Literature'),
(9, 'French'),
(10, 'German'),
(11, 'Indonesian'),
(12, 'Biology'),
(13, 'Chemistry'),
(14, 'Environmental Science'),
(15, 'Mathematics Pathways'),
(16, 'Mathematics: Foundation'),
(17, 'Mathematics: General'),
(18, 'Mathematical Methods'),
(19, 'Mathematics: Specialist'),
(20, 'Physics'),
(21, 'Psychology'),
(22, 'Accounting'),
(23, 'Algorithmics'),
(24, 'Applied Computing'),
(25, 'Applied Computing Data Analytics'),
(26, 'Applied Computing Software Development'),
(27, 'Business Management'),
(28, 'Classical Studies'),
(29, 'Economics'),
(30, 'Extended Investigation'),
(31, 'Geography'),
(32, 'History: Modern'),
(33, 'History: Ancient'),
(34, 'History: Australian'),
(35, 'History: Empires'),
(36, 'History: Revolutions'),
(37, 'Industry and Enterprise'),
(38, 'Legal Studies'),
(39, 'Philosophy'),
(40, 'Politics'),
(41, 'Sociology'),
(42, 'Drama'),
(43, 'Health and Human Development'),
(44, 'Music'),
(45, 'Music Composition'),
(46, 'Music Inquiry'),
(47, 'Music Performance'),
(48, 'Outdoor and Environmental Studies'),
(49, 'Physical Education'),
(50, 'Theatre Studies'),
(51, 'Art Creative Practice'),
(52, 'Art Making and Exhibiting (Drawing, Painting & Print making, Photography or Sculpture)'),
(53, 'Food Studies'),
(54, 'Media'),
(55, 'Product Design and Technology'),
(56, 'Systems Engineering'),
(57, 'Visual Communication Design'),
(58, 'Visual Communication Design Technical');

--
-- 转储表的索引
--

--
-- 表的索引 `db_subject`
--
ALTER TABLE `db_subject`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `db_subject`
--
ALTER TABLE `db_subject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
