-- MySQL dump 10.13  Distrib 8.0.28, for Linux (x86_64)
--
-- Host: localhost    Database: erp
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.20.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `add_courses`
--

DROP TABLE IF EXISTS `add_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `add_courses` (
  `add_id` decimal(2,0) NOT NULL,
  `course_id` varchar(10) DEFAULT NULL,
  `stud_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`add_id`),
  KEY `course_id` (`course_id`),
  KEY `stud_id` (`stud_id`),
  CONSTRAINT `add_courses_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  CONSTRAINT `add_courses_ibfk_2` FOREIGN KEY (`stud_id`) REFERENCES `student` (`stud_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `course_name` varchar(20) DEFAULT NULL,
  `course_id` varchar(10) NOT NULL,
  `capacity` decimal(2,0) DEFAULT NULL,
  `course_IC_id` varchar(10) DEFAULT NULL,
  `course_asst_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `course_IC_id` (`course_IC_id`),
  KEY `course_asst_id` (`course_asst_id`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`course_IC_id`) REFERENCES `teacher` (`teacher_id`),
  CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`course_asst_id`) REFERENCES `teacher` (`teacher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `stud_name` varchar(20) DEFAULT NULL,
  `stud_id` varchar(10) NOT NULL,
  `course_id` varchar(10) DEFAULT NULL,
  `add_id` decimal(2,0) DEFAULT NULL,
  `sub_id` decimal(2,0) DEFAULT NULL,
  PRIMARY KEY (`stud_id`),
  KEY `course_id` (`course_id`),
  KEY `add_id` (`add_id`),
  KEY `sub_id` (`sub_id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`add_id`) REFERENCES `add_courses` (`add_id`),
  CONSTRAINT `student_ibfk_3` FOREIGN KEY (`sub_id`) REFERENCES `sub_courses` (`sub_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sub_courses`
--

DROP TABLE IF EXISTS `sub_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_courses` (
  `sub_id` decimal(2,0) NOT NULL,
  `course_id` varchar(10) DEFAULT NULL,
  `stud_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`sub_id`),
  KEY `course_id` (`course_id`),
  KEY `stud_id` (`stud_id`),
  CONSTRAINT `sub_courses_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  CONSTRAINT `sub_courses_ibfk_2` FOREIGN KEY (`stud_id`) REFERENCES `student` (`stud_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `teacher_name` varchar(20) DEFAULT NULL,
  `teacher_id` varchar(10) NOT NULL,
  `course_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`teacher_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-25 19:11:47
