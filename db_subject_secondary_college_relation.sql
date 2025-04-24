-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1
-- 生成日期： 2025-04-23 09:32:52
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
-- 表的结构 `db_subject_secondary_college_relation`
--

CREATE TABLE `db_subject_secondary_college_relation` (
  `id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `secondary_college_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `db_subject_secondary_college_relation`
--

INSERT INTO `db_subject_secondary_college_relation` (`id`, `subject_id`, `secondary_college_id`) VALUES
(1, 22, 1),
(2, 23, 1),
(3, 24, 1),
(4, 26, 1),
(5, 3, 2),
(6, 21, 2),
(7, 24, 2),
(8, 26, 2);

--
-- 转储表的索引
--

--
-- 表的索引 `db_subject_secondary_college_relation`
--
ALTER TABLE `db_subject_secondary_college_relation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `secondary_collage_id` (`secondary_college_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `db_subject_secondary_college_relation`
--
ALTER TABLE `db_subject_secondary_college_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 限制导出的表
--

--
-- 限制表 `db_subject_secondary_college_relation`
--
ALTER TABLE `db_subject_secondary_college_relation`
  ADD CONSTRAINT `db_subject_secondary_college_relation_ibfk_1` FOREIGN KEY (`secondary_college_id`) REFERENCES `db_secondary_college` (`id`),
  ADD CONSTRAINT `db_subject_secondary_college_relation_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `db_subject` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
