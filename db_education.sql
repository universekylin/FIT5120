-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: db_education
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `db_career`
--

DROP TABLE IF EXISTS `db_career`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `db_career` (
  `id` int NOT NULL AUTO_INCREMENT,
  `career_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_name` (`career_name`)
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_career`
--

LOCK TABLES `db_career` WRITE;
/*!40000 ALTER TABLE `db_career` DISABLE KEYS */;
INSERT INTO `db_career` VALUES (242,'2D/3D Animator'),(266,'Academic Research Fellow'),(196,'Academic Researcher'),(186,'Accountant'),(254,'Acting Coach'),(259,'Actor'),(210,'Agricultural Consultant'),(209,'Agronomist'),(263,'Architectural Consultant'),(238,'Art Consultant'),(205,'Art Curator'),(245,'Ballet Dancer'),(220,'Behavioral Analyst'),(222,'Behavioral Therapist'),(236,'Biomedical Data Analyst'),(226,'Biomedical Scientist'),(244,'Choreographer'),(216,'Cinematographer'),(193,'Civil Engineer'),(227,'Clinical Research Associate'),(192,'Communications Officer'),(223,'Composer'),(255,'Contemporary Artist'),(191,'Content Strategist'),(203,'Corporate Strategy Advisor'),(204,'Creative Director'),(213,'Crop Researcher'),(208,'Dance Lecturer'),(187,'Data Analyst'),(200,'Data Scientist'),(217,'Dental Hygienist'),(247,'Director of Photography'),(202,'Economic Analyst'),(233,'Environmental Analyst'),(229,'Environmental Consultant'),(214,'Film Director'),(246,'Film Editor'),(184,'Financial Analyst'),(256,'Gallery Assistant'),(241,'Graphic Designer'),(279,'Health Administrator'),(280,'Healthcare Analyst'),(240,'Industrial Designer'),(189,'Lab Technician'),(185,'Management Consultant'),(194,'Mechanical Engineer'),(235,'Medical Researcher'),(267,'Medical Scientist'),(276,'Mental Health Counselor'),(243,'Motion Designer'),(224,'Music Director'),(231,'Musicologist'),(277,'Nurse'),(278,'Nutritionist'),(262,'Oral Health Researcher'),(218,'Oral Health Therapist'),(268,'Pathology Researcher'),(281,'Physician Assistant'),(197,'Policy Advisor'),(190,'Policy Analyst'),(211,'Precision Farming Analyst'),(264,'Product Designer'),(250,'Production Designer'),(206,'Professional Artist'),(207,'Professional Dancer'),(225,'Professional Musician'),(195,'Project Engineer'),(219,'Psychologist'),(201,'Research Fellow'),(188,'Research Scientist'),(265,'Scientific Analyst'),(199,'Scientific Officer'),(215,'Screen Producer'),(252,'Scriptwriter'),(212,'Senior Agronomist'),(261,'Senior Dental Hygienist'),(232,'Senior Music Instructor'),(198,'Social Researcher'),(221,'Social Worker'),(257,'Stage Actor'),(251,'Stage Manager'),(248,'Stage Performer'),(253,'Story Consultant'),(230,'Sustainability Analyst'),(258,'Theatre Director'),(228,'Urban Planner'),(234,'Urban Researcher'),(239,'UX Designer'),(237,'Visual Artist'),(249,'Vocal Coach'),(260,'Voice Artist');
/*!40000 ALTER TABLE `db_career` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db_job_type`
--

DROP TABLE IF EXISTS `db_job_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `db_job_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_name` (`job_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_job_type`
--

LOCK TABLES `db_job_type` WRITE;
/*!40000 ALTER TABLE `db_job_type` DISABLE KEYS */;
INSERT INTO `db_job_type` VALUES (1,'Agriculture Environment And Natural Sciences'),(2,'Business and Management'),(3,'Creative Arts Media Communication and Journalism'),(4,'Education And Social Sciences'),(5,'Engineering And Science'),(6,'Health And Human Services'),(7,'IT And Data'),(8,'Law And Public Services'),(9,'Math And Theoretical Sciences');
/*!40000 ALTER TABLE `db_job_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db_major`
--

DROP TABLE IF EXISTS `db_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `db_major` (
  `id` int NOT NULL AUTO_INCREMENT,
  `major_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `course_code` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_code` (`course_code`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_major`
--

LOCK TABLES `db_major` WRITE;
/*!40000 ALTER TABLE `db_major` DISABLE KEYS */;
INSERT INTO `db_major` VALUES (1,'Bachelor of Commerce','002143B'),(2,'Bachelor of Science','002153M'),(3,'Bachelor of Arts','002167E'),(4,'Bachelor of Engineering','003626G'),(5,'Bachelor of Arts (Degree with Honours)','009645A'),(6,'Bachelor of Science (Degree with Honours)','014791D'),(7,'Bachelor of Commerce (Degree with Honours)','014798G'),(8,'Bachelor of Fine Arts (Honours)','029294J'),(9,'Bachelor of Dance (Degree with Honours)','037218K'),(10,'Bachelor of Agriculture','037228G'),(11,'Bachelor of Agriculture (Degree with Honours)','037229G'),(12,'Bachelor of Film and Television (Degree with Honours)','049961B'),(13,'Bachelor of Oral Health','053176D'),(14,'Bachelor of Science (Honours) Psychology','053177C'),(15,'Bachelor of Arts (Honours) Psychology','053178B'),(16,'Bachelor of Music','058837J'),(17,'Bachelor of Biomedicine','058838G'),(18,'Bachelor of Environments','058839G'),(19,'Bachelor of Music (Honours)','060219F'),(20,'Bachelor of Environments (Honours)','073112K'),(21,'Bachelor of Biomedicine (Honours)','073113J'),(22,'Bachelor of Fine Arts','075490A'),(23,'Bachelor of Design','090744C'),(24,'Bachelor of Fine Arts (Animation)','093582C'),(25,'Bachelor of Fine Arts (Dance)','093583B'),(26,'Bachelor of Fine Arts (Film and Television)','093584A'),(27,'Bachelor of Fine Arts (Music Theatre)','093585M'),(28,'Bachelor of Fine Arts (Production)','093586K'),(29,'Bachelor of Fine Arts (Screenwriting)','093587J'),(30,'Bachelor of Fine Arts (Theatre Practice)','093588G'),(31,'Bachelor of Fine Arts (Visual Art)','093589G'),(32,'Bachelor of Fine Arts (Theatre)','094860M'),(33,'Bachelor of Fine Arts (Acting)','094861K'),(34,'Bachelor of Oral Health (Degree with Honours)','097031B'),(35,'Bachelor of Design (Degree with Honours)','107132K'),(36,'Bachelor of Science Advanced (Honours)','112780B'),(37,'Bachelor of Medical Science (Degree with Honours)','113001D');
/*!40000 ALTER TABLE `db_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db_uni`
--

DROP TABLE IF EXISTS `db_uni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `db_uni` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uni_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_name` (`uni_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_uni`
--

LOCK TABLES `db_uni` WRITE;
/*!40000 ALTER TABLE `db_uni` DISABLE KEYS */;
INSERT INTO `db_uni` VALUES (1,'The University of Melbourne');
/*!40000 ALTER TABLE `db_uni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db_uni_major`
--

DROP TABLE IF EXISTS `db_uni_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `db_uni_major` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uni_id` int NOT NULL,
  `major_id` int NOT NULL,
  `duration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `atar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `subjects` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uni_id` (`uni_id`),
  KEY `major_id` (`major_id`),
  CONSTRAINT `db_uni_major_ibfk_2` FOREIGN KEY (`uni_id`) REFERENCES `db_uni` (`id`),
  CONSTRAINT `db_uni_major_ibfk_3` FOREIGN KEY (`major_id`) REFERENCES `db_major` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=322 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_uni_major`
--

LOCK TABLES `db_uni_major` WRITE;
/*!40000 ALTER TABLE `db_uni_major` DISABLE KEYS */;
INSERT INTO `db_uni_major` VALUES (1,1,1,'36 months full-time or 72 months part-time','93.00','English (25) or EAL (30), Chemistry or Biology (25)'),(2,1,2,'English (25) or EAL (30), Mathematical Methods (25), one of Biology, Chemistry or Physics','89.00','English (25) or EAL (30), Mathematical Methods (25), one of Biology, Chemistry or Physics\n'),(3,1,3,'36 months full-time or 72 months part-time','85.00\n','English (25) or EAL (30)\n'),(4,1,4,'48 months full-time','','English (25) or EAL (30), Chemistry or Biology (25)English (25) or EAL (30), Mathematical Methods (25), Physics (25)\n'),(5,1,1,'36 months full-time or 72 months part-time','93.00','English (25) or EAL (30), Mathematical Methods (25)'),(6,1,2,'36 months full-time or 72 months part-time','89.00','English (25) or EAL (30), Mathematical Methods (25), one of Biology, Chemistry or Physics'),(7,1,3,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(8,1,4,'48 months full-time','91.00','English (25) or EAL (30), Mathematical Methods (25), Physics (25)'),(9,1,5,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30)'),(10,1,6,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(11,1,7,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(12,1,8,'12 months full-time','N/A','English (25) or EAL (30), Folio review'),(13,1,9,'12 months full-time','N/A','English (25) or EAL (30), Audition required'),(14,1,10,'36 months full-time or 72 months part-time','70.00','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(15,1,11,'12 months full-time','N/A','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(16,1,12,'12 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(17,1,13,'36 months full-time','85.00','English (25) or EAL (30), Biology or Chemistry (25)'),(18,1,14,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(19,1,15,'N/A','N/A','English (25) or EAL (30)'),(20,1,16,'36 months full-time or 72 months part-time','N/A (audition)','English (25) or EAL (30), Audition required'),(21,1,17,'36 months full-time or 72 months part-time','96.00','English (25) or EAL (30), Chemistry (25)'),(22,1,18,'36 months full-time or 72 months part-time','N/A','English (25) or EAL (30)'),(23,1,19,'N/A','N/A','English (25) or EAL (30), Audition required'),(24,1,20,'N/A','N/A','English (25) or EAL (30)'),(25,1,21,'N/A','N/A','English (25) or EAL (30), Chemistry (25)'),(26,1,22,'N/A','N/A','English (25) or EAL (30), Folio review'),(27,1,23,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(28,1,24,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(29,1,25,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(30,1,26,'36 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(31,1,27,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(32,1,28,'N/A','N/A','English (25) or EAL (30), Interview required'),(33,1,29,'36 months full-time','N/A','English (25) or EAL (30), Writing sample'),(34,1,30,'N/A','N/A','English (25) or EAL (30), Audition required'),(35,1,31,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(36,1,32,'N/A','N/A','English (25) or EAL (30), Audition required'),(37,1,33,'N/A','N/A','English (25) or EAL (30), Audition required'),(38,1,34,'N/A','N/A','English (25) or EAL (30), Biology or Chemistry (25)'),(39,1,35,'N/A','N/A','English (25) or EAL (30)'),(40,1,36,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(41,1,37,'N/A','N/A','English (25) or EAL (30), Chemistry or Biology (25)'),(68,1,1,'36 months full-time or 72 months part-time','93.00','English (25) or EAL (30), Mathematical Methods (25)'),(69,1,2,'36 months full-time or 72 months part-time','89.00','English (25) or EAL (30), Mathematical Methods (25), one of Biology, Chemistry or Physics'),(70,1,3,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(71,1,4,'48 months full-time','91.00','English (25) or EAL (30), Mathematical Methods (25), Physics (25)'),(72,1,5,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30)'),(73,1,6,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(74,1,7,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(75,1,8,'12 months full-time','N/A','English (25) or EAL (30), Folio review'),(76,1,9,'12 months full-time','N/A','English (25) or EAL (30), Audition required'),(77,1,10,'36 months full-time or 72 months part-time','70.00','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(78,1,11,'12 months full-time','N/A','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(79,1,12,'12 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(80,1,13,'36 months full-time','85.00','English (25) or EAL (30), Biology or Chemistry (25)'),(81,1,14,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(82,1,15,'N/A','N/A','English (25) or EAL (30)'),(83,1,16,'36 months full-time or 72 months part-time','N/A (audition)','English (25) or EAL (30), Audition required'),(84,1,17,'36 months full-time or 72 months part-time','96.00','English (25) or EAL (30), Chemistry (25)'),(85,1,18,'36 months full-time or 72 months part-time','N/A','English (25) or EAL (30)'),(86,1,19,'N/A','N/A','English (25) or EAL (30), Audition required'),(87,1,20,'N/A','N/A','English (25) or EAL (30)'),(88,1,21,'N/A','N/A','English (25) or EAL (30), Chemistry (25)'),(89,1,22,'N/A','N/A','English (25) or EAL (30), Folio review'),(90,1,23,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(91,1,24,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(92,1,25,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(93,1,26,'36 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(94,1,27,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(95,1,28,'N/A','N/A','English (25) or EAL (30), Interview required'),(96,1,29,'36 months full-time','N/A','English (25) or EAL (30), Writing sample'),(97,1,30,'N/A','N/A','English (25) or EAL (30), Audition required'),(98,1,31,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(99,1,32,'N/A','N/A','English (25) or EAL (30), Audition required'),(100,1,33,'N/A','N/A','English (25) or EAL (30), Audition required'),(101,1,34,'N/A','N/A','English (25) or EAL (30), Biology or Chemistry (25)'),(102,1,35,'N/A','N/A','English (25) or EAL (30)'),(103,1,36,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(104,1,37,'N/A','N/A','English (25) or EAL (30), Chemistry or Biology (25)'),(105,1,1,'36 months full-time or 72 months part-time','93.00','English (25) or EAL (30), Mathematical Methods (25)'),(106,1,2,'36 months full-time or 72 months part-time','89.00','English (25) or EAL (30), Mathematical Methods (25), one of Biology, Chemistry or Physics'),(107,1,3,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(108,1,4,'48 months full-time','91.00','English (25) or EAL (30), Mathematical Methods (25), Physics (25)'),(109,1,5,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30)'),(110,1,6,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(111,1,7,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(112,1,8,'12 months full-time','N/A','English (25) or EAL (30), Folio review'),(113,1,9,'12 months full-time','N/A','English (25) or EAL (30), Audition required'),(114,1,10,'36 months full-time or 72 months part-time','70.00','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(115,1,11,'12 months full-time','N/A','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(116,1,12,'12 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(117,1,13,'36 months full-time','85.00','English (25) or EAL (30), Biology or Chemistry (25)'),(118,1,14,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(119,1,15,'N/A','N/A','English (25) or EAL (30)'),(120,1,16,'36 months full-time or 72 months part-time','N/A (audition)','English (25) or EAL (30), Audition required'),(121,1,17,'36 months full-time or 72 months part-time','96.00','English (25) or EAL (30), Chemistry (25)'),(122,1,18,'36 months full-time or 72 months part-time','N/A','English (25) or EAL (30)'),(123,1,19,'N/A','N/A','English (25) or EAL (30), Audition required'),(124,1,20,'N/A','N/A','English (25) or EAL (30)'),(125,1,21,'N/A','N/A','English (25) or EAL (30), Chemistry (25)'),(126,1,22,'N/A','N/A','English (25) or EAL (30), Folio review'),(127,1,23,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(128,1,24,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(129,1,25,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(130,1,26,'36 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(131,1,27,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(132,1,28,'N/A','N/A','English (25) or EAL (30), Interview required'),(133,1,29,'36 months full-time','N/A','English (25) or EAL (30), Writing sample'),(134,1,30,'N/A','N/A','English (25) or EAL (30), Audition required'),(135,1,31,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(136,1,32,'N/A','N/A','English (25) or EAL (30), Audition required'),(137,1,33,'N/A','N/A','English (25) or EAL (30), Audition required'),(138,1,34,'N/A','N/A','English (25) or EAL (30), Biology or Chemistry (25)'),(139,1,35,'N/A','N/A','English (25) or EAL (30)'),(140,1,36,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(141,1,37,'N/A','N/A','English (25) or EAL (30), Chemistry or Biology (25)'),(142,1,1,'36 months full-time or 72 months part-time','93.00','English (25) or EAL (30), Mathematical Methods (25)'),(143,1,2,'36 months full-time or 72 months part-time','89.00','English (25) or EAL (30), Mathematical Methods (25), one of Biology, Chemistry or Physics'),(144,1,3,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(145,1,4,'48 months full-time','91.00','English (25) or EAL (30), Mathematical Methods (25), Physics (25)'),(146,1,5,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30)'),(147,1,6,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(148,1,7,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(149,1,8,'12 months full-time','N/A','English (25) or EAL (30), Folio review'),(150,1,9,'12 months full-time','N/A','English (25) or EAL (30), Audition required'),(151,1,10,'36 months full-time or 72 months part-time','70.00','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(152,1,11,'12 months full-time','N/A','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(153,1,12,'12 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(154,1,13,'36 months full-time','85.00','English (25) or EAL (30), Biology or Chemistry (25)'),(155,1,14,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(156,1,15,'N/A','N/A','English (25) or EAL (30)'),(157,1,16,'36 months full-time or 72 months part-time','N/A (audition)','English (25) or EAL (30), Audition required'),(158,1,17,'36 months full-time or 72 months part-time','96.00','English (25) or EAL (30), Chemistry (25)'),(159,1,18,'36 months full-time or 72 months part-time','N/A','English (25) or EAL (30)'),(160,1,19,'N/A','N/A','English (25) or EAL (30), Audition required'),(161,1,20,'N/A','N/A','English (25) or EAL (30)'),(162,1,21,'N/A','N/A','English (25) or EAL (30), Chemistry (25)'),(163,1,22,'N/A','N/A','English (25) or EAL (30), Folio review'),(164,1,23,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(165,1,24,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(166,1,25,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(167,1,26,'36 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(168,1,27,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(169,1,28,'N/A','N/A','English (25) or EAL (30), Interview required'),(170,1,29,'36 months full-time','N/A','English (25) or EAL (30), Writing sample'),(171,1,30,'N/A','N/A','English (25) or EAL (30), Audition required'),(172,1,31,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(173,1,32,'N/A','N/A','English (25) or EAL (30), Audition required'),(174,1,33,'N/A','N/A','English (25) or EAL (30), Audition required'),(175,1,34,'N/A','N/A','English (25) or EAL (30), Biology or Chemistry (25)'),(176,1,35,'N/A','N/A','English (25) or EAL (30)'),(177,1,36,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(178,1,37,'N/A','N/A','English (25) or EAL (30), Chemistry or Biology (25)'),(195,1,1,'36 months full-time or 72 months part-time','93.00','English (25) or EAL (30), Mathematical Methods (25)'),(196,1,2,'36 months full-time or 72 months part-time','89.00','English (25) or EAL (30), Mathematical Methods (25), one of Biology, Chemistry or Physics'),(197,1,3,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(198,1,4,'48 months full-time','91.00','English (25) or EAL (30), Mathematical Methods (25), Physics (25)'),(199,1,5,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30)'),(200,1,6,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(201,1,7,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(202,1,8,'12 months full-time','N/A','English (25) or EAL (30), Folio review'),(203,1,9,'12 months full-time','N/A','English (25) or EAL (30), Audition required'),(204,1,10,'36 months full-time or 72 months part-time','70.00','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(205,1,11,'12 months full-time','N/A','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(206,1,12,'12 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(207,1,13,'36 months full-time','85.00','English (25) or EAL (30), Biology or Chemistry (25)'),(208,1,14,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(209,1,15,'N/A','N/A','English (25) or EAL (30)'),(210,1,16,'36 months full-time or 72 months part-time','N/A (audition)','English (25) or EAL (30), Audition required'),(211,1,17,'36 months full-time or 72 months part-time','96.00','English (25) or EAL (30), Chemistry (25)'),(212,1,18,'36 months full-time or 72 months part-time','N/A','English (25) or EAL (30)'),(213,1,19,'N/A','N/A','English (25) or EAL (30), Audition required'),(214,1,20,'N/A','N/A','English (25) or EAL (30)'),(215,1,21,'N/A','N/A','English (25) or EAL (30), Chemistry (25)'),(216,1,22,'N/A','N/A','English (25) or EAL (30), Folio review'),(217,1,23,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(218,1,24,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(219,1,25,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(220,1,26,'36 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(221,1,27,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(222,1,28,'N/A','N/A','English (25) or EAL (30), Interview required'),(223,1,29,'36 months full-time','N/A','English (25) or EAL (30), Writing sample'),(224,1,30,'N/A','N/A','English (25) or EAL (30), Audition required'),(225,1,31,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(226,1,32,'N/A','N/A','English (25) or EAL (30), Audition required'),(227,1,33,'N/A','N/A','English (25) or EAL (30), Audition required'),(228,1,34,'N/A','N/A','English (25) or EAL (30), Biology or Chemistry (25)'),(229,1,35,'N/A','N/A','English (25) or EAL (30)'),(230,1,36,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(231,1,37,'N/A','N/A','English (25) or EAL (30), Chemistry or Biology (25)'),(232,1,1,'36 months full-time or 72 months part-time','93.00','English (25) or EAL (30), Mathematical Methods (25)'),(233,1,2,'36 months full-time or 72 months part-time','89.00','English (25) or EAL (30), Mathematical Methods (25), one of Biology, Chemistry or Physics'),(234,1,3,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(235,1,4,'48 months full-time','91.00','English (25) or EAL (30), Mathematical Methods (25), Physics (25)'),(236,1,5,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30)'),(237,1,6,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(238,1,7,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(239,1,8,'12 months full-time','N/A','English (25) or EAL (30), Folio review'),(240,1,9,'12 months full-time','N/A','English (25) or EAL (30), Audition required'),(241,1,10,'36 months full-time or 72 months part-time','70.00','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(242,1,11,'12 months full-time','N/A','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(243,1,12,'12 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(244,1,13,'36 months full-time','85.00','English (25) or EAL (30), Biology or Chemistry (25)'),(245,1,14,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(246,1,15,'N/A','N/A','English (25) or EAL (30)'),(247,1,16,'36 months full-time or 72 months part-time','N/A (audition)','English (25) or EAL (30), Audition required'),(248,1,17,'36 months full-time or 72 months part-time','96.00','English (25) or EAL (30), Chemistry (25)'),(249,1,18,'36 months full-time or 72 months part-time','N/A','English (25) or EAL (30)'),(250,1,19,'N/A','N/A','English (25) or EAL (30), Audition required'),(251,1,20,'N/A','N/A','English (25) or EAL (30)'),(252,1,21,'N/A','N/A','English (25) or EAL (30), Chemistry (25)'),(253,1,22,'N/A','N/A','English (25) or EAL (30), Folio review'),(254,1,23,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(255,1,24,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(256,1,25,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(257,1,26,'36 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(258,1,27,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(259,1,28,'N/A','N/A','English (25) or EAL (30), Interview required'),(260,1,29,'36 months full-time','N/A','English (25) or EAL (30), Writing sample'),(261,1,30,'N/A','N/A','English (25) or EAL (30), Audition required'),(262,1,31,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(263,1,32,'N/A','N/A','English (25) or EAL (30), Audition required'),(264,1,33,'N/A','N/A','English (25) or EAL (30), Audition required'),(265,1,34,'N/A','N/A','English (25) or EAL (30), Biology or Chemistry (25)'),(266,1,35,'N/A','N/A','English (25) or EAL (30)'),(267,1,36,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(268,1,37,'N/A','N/A','English (25) or EAL (30), Chemistry or Biology (25)'),(269,1,1,'36 months full-time or 72 months part-time','93.00','English (25) or EAL (30), Mathematical Methods (25)'),(270,1,2,'36 months full-time or 72 months part-time','89.00','English (25) or EAL (30), Mathematical Methods (25), one of Biology, Chemistry or Physics'),(271,1,3,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(272,1,4,'48 months full-time','91.00','English (25) or EAL (30), Mathematical Methods (25), Physics (25)'),(273,1,5,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30)'),(274,1,6,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(275,1,7,'12 months full-time or 24 months part-time','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(276,1,8,'12 months full-time','N/A','English (25) or EAL (30), Folio review'),(277,1,9,'12 months full-time','N/A','English (25) or EAL (30), Audition required'),(278,1,10,'36 months full-time or 72 months part-time','70.00','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(279,1,11,'12 months full-time','N/A','English (25) or EAL (30), one of Math Methods, Specialist Maths or Physics'),(280,1,12,'12 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(281,1,13,'36 months full-time','85.00','English (25) or EAL (30), Biology or Chemistry (25)'),(282,1,14,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(283,1,15,'N/A','N/A','English (25) or EAL (30)'),(284,1,16,'36 months full-time or 72 months part-time','N/A (audition)','English (25) or EAL (30), Audition required'),(285,1,17,'36 months full-time or 72 months part-time','96.00','English (25) or EAL (30), Chemistry (25)'),(286,1,18,'36 months full-time or 72 months part-time','N/A','English (25) or EAL (30)'),(287,1,19,'N/A','N/A','English (25) or EAL (30), Audition required'),(288,1,20,'N/A','N/A','English (25) or EAL (30)'),(289,1,21,'N/A','N/A','English (25) or EAL (30), Chemistry (25)'),(290,1,22,'N/A','N/A','English (25) or EAL (30), Folio review'),(291,1,23,'36 months full-time or 72 months part-time','85.00','English (25) or EAL (30)'),(292,1,24,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(293,1,25,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(294,1,26,'36 months full-time','N/A','English (25) or EAL (30), Interview and portfolio'),(295,1,27,'36 months full-time','N/A','English (25) or EAL (30), Audition required'),(296,1,28,'N/A','N/A','English (25) or EAL (30), Interview required'),(297,1,29,'36 months full-time','N/A','English (25) or EAL (30), Writing sample'),(298,1,30,'N/A','N/A','English (25) or EAL (30), Audition required'),(299,1,31,'36 months full-time','N/A','English (25) or EAL (30), Folio review'),(300,1,32,'N/A','N/A','English (25) or EAL (30), Audition required'),(301,1,33,'N/A','N/A','English (25) or EAL (30), Audition required'),(302,1,34,'N/A','N/A','English (25) or EAL (30), Biology or Chemistry (25)'),(303,1,35,'N/A','N/A','English (25) or EAL (30)'),(304,1,36,'N/A','N/A','English (25) or EAL (30), Mathematical Methods (25)'),(305,1,37,'N/A','N/A','English (25) or EAL (30), Chemistry or Biology (25)');
/*!40000 ALTER TABLE `db_uni_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_career_relation`
--

DROP TABLE IF EXISTS `job_career_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_career_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `career_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `career_id` (`career_id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `job_career_relation_ibfk_1` FOREIGN KEY (`career_id`) REFERENCES `db_career` (`id`),
  CONSTRAINT `job_career_relation_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `db_job_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_career_relation`
--

LOCK TABLES `job_career_relation` WRITE;
/*!40000 ALTER TABLE `job_career_relation` DISABLE KEYS */;
INSERT INTO `job_career_relation` VALUES (1,7,187),(2,7,200),(3,7,239),(4,1,209),(5,1,210),(6,1,211),(7,1,212),(8,1,213),(9,1,229),(10,1,230),(11,1,233),(12,2,186),(13,2,203),(14,2,185),(15,2,184),(16,2,197),(17,2,190),(18,2,191),(19,2,264),(20,3,192),(21,3,204),(22,3,205),(23,3,214),(24,3,215),(25,3,216),(26,3,223),(27,3,224),(28,3,225),(29,3,237),(30,3,238),(31,3,244),(32,3,246),(33,3,248),(34,3,249),(35,3,251),(36,3,252),(37,3,253),(38,3,254),(39,3,255),(40,3,257),(41,3,258),(42,3,259),(43,3,260),(44,3,231),(45,4,196),(46,4,266),(47,4,198),(48,4,221),(49,4,276),(50,4,219),(51,4,220),(52,4,222),(53,4,232),(54,4,208),(55,5,193),(56,5,194),(57,5,195),(58,5,226),(59,5,235),(60,5,267),(61,5,268),(62,5,188),(63,5,201),(64,5,265),(65,5,199),(66,5,236),(67,5,189),(68,6,220),(69,6,222),(70,6,221),(71,6,227),(72,6,217),(73,6,218),(74,6,262),(75,6,276),(76,6,219),(77,6,279),(78,6,268),(79,6,235),(80,6,267),(81,6,280),(82,6,281),(88,8,197),(89,8,190),(90,8,198),(92,9,188),(93,9,184),(94,9,187),(95,9,200),(96,9,202),(97,9,265);
/*!40000 ALTER TABLE `job_career_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `major_careers_relation`
--

DROP TABLE IF EXISTS `major_careers_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `major_careers_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uni_major_id` int NOT NULL,
  `career_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `career_id` (`career_id`),
  KEY `uni_major_id` (`uni_major_id`),
  CONSTRAINT `major_careers_relation_ibfk_1` FOREIGN KEY (`career_id`) REFERENCES `db_career` (`id`),
  CONSTRAINT `major_careers_relation_ibfk_2` FOREIGN KEY (`uni_major_id`) REFERENCES `db_uni_major` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major_careers_relation`
--

LOCK TABLES `major_careers_relation` WRITE;
/*!40000 ALTER TABLE `major_careers_relation` DISABLE KEYS */;
INSERT INTO `major_careers_relation` VALUES (1,1,281),(2,1,280),(3,1,279),(4,1,278),(5,1,276),(6,1,277),(7,1,238),(8,2,187),(9,2,200),(10,2,239),(12,24,242),(13,36,266),(14,5,196),(15,1,186),(16,30,254),(17,33,259),(18,32,259),(19,10,210),(20,11,209),(21,10,209),(22,35,263),(23,22,238),(24,8,205),(25,25,245),(26,14,220),(27,15,222),(28,21,236),(29,17,226),(30,25,244),(31,9,244),(32,12,216),(33,4,193),(34,17,227),(35,3,192),(36,16,223),(37,31,255),(38,3,191),(39,7,203),(40,8,204),(41,11,213),(42,9,208),(43,21,187),(44,2,187),(45,6,200),(46,34,217),(47,13,217),(48,26,247),(49,7,202),(50,20,233),(51,18,229),(52,12,214),(53,26,246),(54,1,184),(55,31,256),(56,23,241),(57,23,240),(58,2,189),(59,1,185),(60,4,194),(61,21,235),(62,37,267),(63,17,267),(64,24,243),(65,16,224),(66,19,231),(67,34,262),(68,13,218),(69,37,268),(70,5,197),(71,3,190),(72,10,211),(73,35,264),(74,28,250),(75,8,206),(76,9,207),(77,16,225),(78,4,195),(79,14,219),(80,36,201),(81,6,201),(82,2,188),(83,36,265),(84,6,199),(85,12,215),(86,29,252),(87,11,212),(88,34,261),(89,19,232),(90,5,198),(91,15,221),(92,32,257),(93,28,251),(94,27,248),(95,29,253),(96,18,230),(97,32,258),(98,30,258),(99,18,228),(100,20,234),(101,23,239),(102,22,237),(103,27,249),(104,33,260);
/*!40000 ALTER TABLE `major_careers_relation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-10  0:27:15
