-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1
-- 生成日期： 2025-04-09 09:40:06
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
-- 数据库： `db_education`
--

-- --------------------------------------------------------

--
-- 表的结构 `db_career`
--

CREATE TABLE `db_career` (
  `id` int(11) NOT NULL,
  `career_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `db_career`
--

INSERT INTO `db_career` (`id`, `career_name`) VALUES
(242, '2D/3D Animator'),
(266, 'Academic Research Fellow'),
(196, 'Academic Researcher'),
(186, 'Accountant'),
(254, 'Acting Coach'),
(259, 'Actor'),
(210, 'Agricultural Consultant'),
(209, 'Agronomist'),
(263, 'Architectural Consultant'),
(238, 'Art Consultant'),
(205, 'Art Curator'),
(245, 'Ballet Dancer'),
(220, 'Behavioral Analyst'),
(222, 'Behavioral Therapist'),
(236, 'Biomedical Data Analyst'),
(226, 'Biomedical Scientist'),
(244, 'Choreographer'),
(216, 'Cinematographer'),
(193, 'Civil Engineer'),
(227, 'Clinical Research Associate'),
(192, 'Communications Officer'),
(223, 'Composer'),
(255, 'Contemporary Artist'),
(191, 'Content Strategist'),
(203, 'Corporate Strategy Advisor'),
(204, 'Creative Director'),
(213, 'Crop Researcher'),
(208, 'Dance Lecturer'),
(187, 'Data Analyst'),
(200, 'Data Scientist'),
(217, 'Dental Hygienist'),
(247, 'Director of Photography'),
(202, 'Economic Analyst'),
(233, 'Environmental Analyst'),
(229, 'Environmental Consultant'),
(214, 'Film Director'),
(246, 'Film Editor'),
(184, 'Financial Analyst'),
(256, 'Gallery Assistant'),
(241, 'Graphic Designer'),
(279, 'Health Administrator'),
(280, 'Healthcare Analyst'),
(240, 'Industrial Designer'),
(283, 'IT And Data'),
(189, 'Lab Technician'),
(185, 'Management Consultant'),
(194, 'Mechanical Engineer'),
(235, 'Medical Researcher'),
(267, 'Medical Scientist'),
(276, 'Mental Health Counselor'),
(243, 'Motion Designer'),
(224, 'Music Director'),
(231, 'Musicologist'),
(277, 'Nurse'),
(278, 'Nutritionist'),
(262, 'Oral Health Researcher'),
(218, 'Oral Health Therapist'),
(268, 'Pathology Researcher'),
(281, 'Physician Assistant'),
(197, 'Policy Advisor'),
(190, 'Policy Analyst'),
(211, 'Precision Farming Analyst'),
(264, 'Product Designer'),
(250, 'Production Designer'),
(206, 'Professional Artist'),
(207, 'Professional Dancer'),
(225, 'Professional Musician'),
(195, 'Project Engineer'),
(219, 'Psychologist'),
(201, 'Research Fellow'),
(188, 'Research Scientist'),
(265, 'Scientific Analyst'),
(199, 'Scientific Officer'),
(215, 'Screen Producer'),
(252, 'Scriptwriter'),
(212, 'Senior Agronomist'),
(261, 'Senior Dental Hygienist'),
(232, 'Senior Music Instructor'),
(198, 'Social Researcher'),
(221, 'Social Worker'),
(257, 'Stage Actor'),
(251, 'Stage Manager'),
(248, 'Stage Performer'),
(253, 'Story Consultant'),
(230, 'Sustainability Analyst'),
(258, 'Theatre Director'),
(228, 'Urban Planner'),
(234, 'Urban Researcher'),
(239, 'UX Designer'),
(237, 'Visual Artist'),
(249, 'Vocal Coach'),
(260, 'Voice Artist');

-- --------------------------------------------------------

--
-- 表的结构 `db_job_type`
--

CREATE TABLE `db_job_type` (
  `id` int(11) NOT NULL,
  `job_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `db_job_type`
--

INSERT INTO `db_job_type` (`id`, `job_name`) VALUES
(1, 'IT & Date');

-- --------------------------------------------------------

--
-- 表的结构 `db_major`
--

CREATE TABLE `db_major` (
  `id` int(11) NOT NULL,
  `major_name` varchar(200) NOT NULL,
  `course_code` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `db_major`
--

INSERT INTO `db_major` (`id`, `major_name`, `course_code`) VALUES
(1, 'Bachelor of Commerce', '002143B'),
(2, 'Bachelor of Science', '002153M'),
(3, 'Bachelor of Arts', '002167E'),
(4, 'Bachelor of Engineering', '003626G'),
(5, 'Bachelor of Arts (Degree with Honours)', '009645A'),
(6, 'Bachelor of Science (Degree with Honours)', '014791D'),
(7, 'Bachelor of Commerce (Degree with Honours)', '014798G'),
(8, 'Bachelor of Fine Arts (Honours)', '029294J'),
(9, 'Bachelor of Dance (Degree with Honours)', '037218K'),
(10, 'Bachelor of Agriculture', '037228G'),
(11, 'Bachelor of Agriculture (Degree with Honours)', '037229G'),
(12, 'Bachelor of Film and Television (Degree with Honours)', '049961B'),
(13, 'Bachelor of Oral Health', '053176D'),
(14, 'Bachelor of Science (Honours) Psychology', '053177C'),
(15, 'Bachelor of Arts (Honours) Psychology', '053178B'),
(16, 'Bachelor of Music', '058837J'),
(17, 'Bachelor of Biomedicine', '058838G'),
(18, 'Bachelor of Environments', '058839G'),
(19, 'Bachelor of Music (Honours)', '060219F'),
(20, 'Bachelor of Environments (Honours)', '073112K'),
(21, 'Bachelor of Biomedicine (Honours)', '073113J'),
(22, 'Bachelor of Fine Arts', '075490A'),
(23, 'Bachelor of Design', '090744C'),
(24, 'Bachelor of Fine Arts (Animation)', '093582C'),
(25, 'Bachelor of Fine Arts (Dance)', '093583B'),
(26, 'Bachelor of Fine Arts (Film and Television)', '093584A'),
(27, 'Bachelor of Fine Arts (Music Theatre)', '093585M'),
(28, 'Bachelor of Fine Arts (Production)', '093586K'),
(29, 'Bachelor of Fine Arts (Screenwriting)', '093587J'),
(30, 'Bachelor of Fine Arts (Theatre Practice)', '093588G'),
(31, 'Bachelor of Fine Arts (Visual Art)', '093589G'),
(32, 'Bachelor of Fine Arts (Theatre)', '094860M'),
(33, 'Bachelor of Fine Arts (Acting)', '094861K'),
(34, 'Bachelor of Oral Health (Degree with Honours)', '097031B'),
(35, 'Bachelor of Design (Degree with Honours)', '107132K'),
(36, 'Bachelor of Science Advanced (Honours)', '112780B'),
(37, 'Bachelor of Medical Science (Degree with Honours)', '113001D');

-- --------------------------------------------------------

--
-- 表的结构 `db_uni`
--

CREATE TABLE `db_uni` (
  `id` int(11) NOT NULL,
  `uni_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `db_uni`
--

INSERT INTO `db_uni` (`id`, `uni_name`) VALUES
(1, 'The University of Melbourne');

-- --------------------------------------------------------

--
-- 表的结构 `db_uni_major`
--

CREATE TABLE `db_uni_major` (
  `id` int(11) NOT NULL,
  `uni_id` int(11) NOT NULL,
  `major_id` int(11) NOT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `atar` varchar(255) DEFAULT NULL,
  `subjects` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `db_uni_major`
--

INSERT INTO `db_uni_major` (`id`, `uni_id`, `major_id`, `duration`, `atar`, `subjects`) VALUES
(1, 1, 1, '36 months full-time or 72 months part-time', '93.00', 'English (25) or EAL (30), Chemistry or Biology (25)'),
(2, 1, 2, 'English (25) or EAL (30), Mathematical Methods (25), one of Biology, Chemistry or Physics', '89.00', 'English (25) or EAL (30), Mathematical Methods (25), one of Biology, Chemistry or Physics\n'),
(3, 1, 3, '36 months full-time or 72 months part-time', '85.00\n', 'English (25) or EAL (30)\n'),
(4, 1, 4, '48 months full-time', '', 'English (25) or EAL (30), Chemistry or Biology (25)English (25) or EAL (30), Mathematical Methods (25), Physics (25)\n');

-- --------------------------------------------------------

--
-- 表的结构 `job_career_relation`
--

CREATE TABLE `job_career_relation` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `career_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `job_career_relation`
--

INSERT INTO `job_career_relation` (`id`, `job_id`, `career_id`) VALUES
(1, 1, 242),
(2, 1, 196);

-- --------------------------------------------------------

--
-- 表的结构 `major_careers_relation`
--

CREATE TABLE `major_careers_relation` (
  `id` int(11) NOT NULL,
  `uni_major_id` int(11) NOT NULL,
  `career_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `major_careers_relation`
--

INSERT INTO `major_careers_relation` (`id`, `uni_major_id`, `career_id`) VALUES
(1, 1, 281),
(2, 1, 280),
(3, 1, 279),
(4, 1, 278),
(5, 1, 276),
(6, 1, 277),
(7, 1, 238),
(8, 1, 283);

--
-- 转储表的索引
--

--
-- 表的索引 `db_career`
--
ALTER TABLE `db_career`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `job_name` (`career_name`);

--
-- 表的索引 `db_job_type`
--
ALTER TABLE `db_job_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `job_name` (`job_name`);

--
-- 表的索引 `db_major`
--
ALTER TABLE `db_major`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `major_name` (`major_name`),
  ADD UNIQUE KEY `course_code` (`course_code`);

--
-- 表的索引 `db_uni`
--
ALTER TABLE `db_uni`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uni_name` (`uni_name`);

--
-- 表的索引 `db_uni_major`
--
ALTER TABLE `db_uni_major`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uni_id` (`uni_id`),
  ADD KEY `major_id` (`major_id`);

--
-- 表的索引 `job_career_relation`
--
ALTER TABLE `job_career_relation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `career_id` (`career_id`),
  ADD KEY `job_id` (`job_id`);

--
-- 表的索引 `major_careers_relation`
--
ALTER TABLE `major_careers_relation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `career_id` (`career_id`),
  ADD KEY `uni_major_id` (`uni_major_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `db_career`
--
ALTER TABLE `db_career`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=284;

--
-- 使用表AUTO_INCREMENT `db_job_type`
--
ALTER TABLE `db_job_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `db_major`
--
ALTER TABLE `db_major`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- 使用表AUTO_INCREMENT `db_uni`
--
ALTER TABLE `db_uni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `db_uni_major`
--
ALTER TABLE `db_uni_major`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `job_career_relation`
--
ALTER TABLE `job_career_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `major_careers_relation`
--
ALTER TABLE `major_careers_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 限制导出的表
--

--
-- 限制表 `db_uni_major`
--
ALTER TABLE `db_uni_major`
  ADD CONSTRAINT `db_uni_major_ibfk_2` FOREIGN KEY (`uni_id`) REFERENCES `db_uni` (`id`),
  ADD CONSTRAINT `db_uni_major_ibfk_3` FOREIGN KEY (`major_id`) REFERENCES `db_major` (`id`);

--
-- 限制表 `job_career_relation`
--
ALTER TABLE `job_career_relation`
  ADD CONSTRAINT `job_career_relation_ibfk_1` FOREIGN KEY (`career_id`) REFERENCES `db_career` (`id`),
  ADD CONSTRAINT `job_career_relation_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `db_job_type` (`id`);

--
-- 限制表 `major_careers_relation`
--
ALTER TABLE `major_careers_relation`
  ADD CONSTRAINT `major_careers_relation_ibfk_1` FOREIGN KEY (`career_id`) REFERENCES `db_career` (`id`),
  ADD CONSTRAINT `major_careers_relation_ibfk_2` FOREIGN KEY (`uni_major_id`) REFERENCES `db_uni_major` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
