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
-- Table structure for table `add_course`
--

DROP TABLE IF EXISTS `add_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `add_course` (
  `course_id` int NOT NULL,
  `student_id` int NOT NULL,
  `status` enum('PENDING','SUCCESSFULL','FAILED') DEFAULT 'PENDING',
  PRIMARY KEY (`student_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `add_course_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE,
  CONSTRAINT `add_course_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `add_course`
--

LOCK TABLES `add_course` WRITE;
/*!40000 ALTER TABLE `add_course` DISABLE KEYS */;
INSERT INTO `add_course` VALUES (5,1,'SUCCESSFULL'),(8,4,'SUCCESSFULL'),(19,4,'SUCCESSFULL'),(17,5,'SUCCESSFULL'),(14,6,'FAILED'),(7,9,'FAILED'),(11,9,'SUCCESSFULL'),(9,10,'FAILED'),(16,10,'SUCCESSFULL'),(7,11,'SUCCESSFULL'),(16,12,'SUCCESSFULL'),(8,13,'SUCCESSFULL'),(17,13,'SUCCESSFULL'),(10,17,'SUCCESSFULL'),(20,18,'SUCCESSFULL'),(1,19,'SUCCESSFULL'),(4,20,'FAILED'),(11,20,'SUCCESSFULL'),(17,22,'SUCCESSFULL'),(14,25,'FAILED'),(3,26,'SUCCESSFULL'),(2,29,'SUCCESSFULL'),(9,29,'FAILED'),(9,30,'FAILED'),(20,30,'SUCCESSFULL'),(3,32,'SUCCESSFULL'),(6,32,'FAILED'),(10,33,'SUCCESSFULL'),(18,33,'FAILED'),(12,35,'SUCCESSFULL'),(19,35,'SUCCESSFULL'),(20,37,'FAILED'),(20,38,'SUCCESSFULL'),(18,39,'FAILED'),(8,41,'SUCCESSFULL'),(11,41,'SUCCESSFULL'),(5,42,'SUCCESSFULL'),(6,43,'FAILED'),(15,43,'SUCCESSFULL'),(8,45,'SUCCESSFULL'),(11,45,'SUCCESSFULL'),(3,49,'SUCCESSFULL'),(12,49,'SUCCESSFULL'),(15,51,'SUCCESSFULL'),(8,52,'FAILED'),(18,52,'FAILED'),(2,54,'SUCCESSFULL'),(9,54,'FAILED'),(5,58,'SUCCESSFULL'),(1,59,'SUCCESSFULL'),(6,60,'FAILED'),(19,60,'SUCCESSFULL'),(8,61,'FAILED'),(7,65,'SUCCESSFULL'),(9,65,'FAILED'),(11,66,'FAILED'),(12,66,'SUCCESSFULL'),(9,68,'FAILED'),(18,68,'FAILED'),(3,71,'SUCCESSFULL'),(1,72,'FAILED'),(14,72,'FAILED'),(6,73,'FAILED'),(15,77,'SUCCESSFULL'),(19,77,'SUCCESSFULL'),(6,78,'FAILED'),(15,78,'SUCCESSFULL'),(17,79,'SUCCESSFULL'),(13,84,'SUCCESSFULL'),(1,85,'FAILED'),(9,85,'FAILED'),(1,87,'FAILED'),(18,87,'FAILED'),(15,88,'SUCCESSFULL'),(5,89,'SUCCESSFULL'),(9,89,'FAILED'),(6,90,'FAILED'),(20,90,'SUCCESSFULL'),(1,91,'FAILED'),(15,91,'SUCCESSFULL'),(10,92,'SUCCESSFULL'),(11,93,'SUCCESSFULL'),(14,93,'FAILED'),(1,94,'FAILED'),(18,94,'FAILED'),(10,95,'FAILED'),(18,95,'FAILED'),(18,96,'FAILED'),(6,97,'FAILED'),(8,97,'FAILED'),(10,98,'FAILED'),(16,98,'SUCCESSFULL'),(8,99,'FAILED');
/*!40000 ALTER TABLE `add_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assists`
--

DROP TABLE IF EXISTS `assists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assists` (
  `teacher_id` int NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`teacher_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `assists_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assists_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assists`
--

LOCK TABLES `assists` WRITE;
/*!40000 ALTER TABLE `assists` DISABLE KEYS */;
INSERT INTO `assists` VALUES (4,1),(7,1),(7,2),(15,2),(2,3),(5,3),(5,4),(10,4),(2,5),(9,5),(8,6),(9,6),(1,7),(6,7),(6,8),(9,8),(5,9),(9,9),(2,10),(15,10),(3,11),(12,11),(8,12),(12,12),(6,13),(9,13),(1,14),(12,14),(4,15),(12,15),(6,16),(13,16),(4,17),(11,17),(3,18),(11,18),(3,19),(7,19),(13,20),(14,20);
/*!40000 ALTER TABLE `assists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL DEFAULT 'Course',
  `capacity` float(2,0) NOT NULL DEFAULT '20',
  `seats_left` float(2,0) NOT NULL DEFAULT '20',
  `IC_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IC_id` (`IC_id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`IC_id`) REFERENCES `teacher` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'Chartered accountant',35,0,3),(2,'Sports development officer',42,6,7),(3,'Administrator, education',66,15,13),(4,'Engineer, civil (consulting)',91,43,13),(5,'Pharmacist, community',87,41,7),(6,'Physicist, medical',22,0,8),(7,'Ambulance person',57,21,1),(8,'Newspaper journalist',42,0,7),(9,'Charity fundraiser',23,0,8),(10,'Data processing manager',36,0,1),(11,'Magazine journalist',62,18,5),(12,'Engineer, communications',65,19,4),(13,'Waste management officer',85,44,13),(14,'Medical illustrator',26,0,13),(15,'Engineer, manufacturing',35,2,15),(16,'Contracting civil engineer',84,42,11),(17,'Surveyor, building',61,13,6),(18,'Surveyor, commercial/residential',25,0,9),(19,'Psychotherapist',61,19,7),(20,'Chief Financial Officer',86,43,6);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `myAdditions`
--

DROP TABLE IF EXISTS `myAdditions`;
/*!50001 DROP VIEW IF EXISTS `myAdditions`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `myAdditions` AS SELECT 
 1 AS `course_id`,
 1 AS `course_name`,
 1 AS `seats_left`,
 1 AS `student_id`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `myCourses`
--

DROP TABLE IF EXISTS `myCourses`;
/*!50001 DROP VIEW IF EXISTS `myCourses`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `myCourses` AS SELECT 
 1 AS `course_id`,
 1 AS `course_name`,
 1 AS `IC_id`,
 1 AS `course_IC`,
 1 AS `course_capacity`,
 1 AS `student_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `mySubstitutions`
--

DROP TABLE IF EXISTS `mySubstitutions`;
/*!50001 DROP VIEW IF EXISTS `mySubstitutions`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `mySubstitutions` AS SELECT 
 1 AS `curr_course_id`,
 1 AS `curr_course_name`,
 1 AS `curr_course_seats_left`,
 1 AS `subn_course_id`,
 1 AS `subn_course_name`,
 1 AS `subn_course_seats_left`,
 1 AS `student_id`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `myWithdrawals`
--

DROP TABLE IF EXISTS `myWithdrawals`;
/*!50001 DROP VIEW IF EXISTS `myWithdrawals`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `myWithdrawals` AS SELECT 
 1 AS `course_id`,
 1 AS `course_name`,
 1 AS `seats_left`,
 1 AS `student_id`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL DEFAULT 'Student',
  `username` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'Martin Howard','Martin Howard'),(2,'Charles Hernandez','Charles Hernandez'),(3,'Aaron Floyd','Aaron Floyd'),(4,'Amanda Mcguire','Amanda Mcguire'),(5,'Kara Miller','Kara Miller'),(6,'Cathy Wallace','Cathy Wallace'),(7,'Bobby Shelton','Bobby Shelton'),(8,'Timothy Schaefer','Timothy Schaefer'),(9,'Lisa Rojas','Lisa Rojas'),(10,'Stacy Parker','Stacy Parker'),(11,'Misty Gill','Misty Gill'),(12,'Donna Smith MD','Donna Smith MD'),(13,'Elizabeth Anderson','Elizabeth Anderson'),(14,'David Douglas','David Douglas'),(15,'Andrew Mccarthy','Andrew Mccarthy'),(16,'Matthew Waters','Matthew Waters'),(17,'Steven James','Steven James'),(18,'Peter Harper','Peter Harper'),(19,'Julia Vincent','Julia Vincent'),(20,'Juan Huber','Juan Huber'),(21,'Virginia Bowen','Virginia Bowen'),(22,'Diana Hamilton','Diana Hamilton'),(23,'Chelsea Guzman','Chelsea Guzman'),(24,'Mary Ayala','Mary Ayala'),(25,'Stephen Terrell','Stephen Terrell'),(26,'Chelsea Bates','Chelsea Bates'),(27,'Jessica Small','Jessica Small'),(28,'Nicholas Peters','Nicholas Peters'),(29,'Shannon Fitzgerald','Shannon Fitzgerald'),(30,'Craig Casey','Craig Casey'),(31,'Wendy Johnson','Wendy Johnson'),(32,'Aaron Sheppard','Aaron Sheppard'),(33,'Shawn Herman','Shawn Herman'),(34,'Shannon Chavez','Shannon Chavez'),(35,'Steven Choi','Steven Choi'),(36,'Elizabeth Scott','Elizabeth Scott'),(37,'Alexa Green','Alexa Green'),(38,'Michael Moore','Michael Moore'),(39,'Annette Mitchell','Annette Mitchell'),(40,'Amber Manning','Amber Manning'),(41,'James Robinson','James Robinson'),(42,'Tracy Crawford','Tracy Crawford'),(43,'Stephen Evans','Stephen Evans'),(44,'Sara Ibarra','Sara Ibarra'),(45,'David Ross','David Ross'),(46,'Jill Jordan','Jill Jordan'),(47,'Christopher Harris','Christopher Harris'),(48,'Stephanie Jones','Stephanie Jones'),(49,'Tonya Haynes','Tonya Haynes'),(50,'Bobby Spencer','Bobby Spencer'),(51,'Kathryn Castro','Kathryn Castro'),(52,'Melanie Thomas','Melanie Thomas'),(53,'Danielle Brown','Danielle Brown'),(54,'Isaac Bryant','Isaac Bryant'),(55,'Leslie Johnson','Leslie Johnson'),(56,'Emily Ross','Emily Ross'),(57,'Brian Daniel','Brian Daniel'),(58,'Monique Miller','Monique Miller'),(59,'Misty Gordon','Misty Gordon'),(60,'Tracy Mills','Tracy Mills'),(61,'Katherine Evans','Katherine Evans'),(62,'Stacy Stewart','Stacy Stewart'),(63,'Tyler Robinson','Tyler Robinson'),(64,'Brandon Steele','Brandon Steele'),(65,'Margaret Salinas','Margaret Salinas'),(66,'Dr. Brandi Harper MD','Dr. Brandi Harper MD'),(67,'James Gonzales','James Gonzales'),(68,'Nicole Henderson','Nicole Henderson'),(69,'William Jackson','William Jackson'),(70,'Scott Jones','Scott Jones'),(71,'Gregg Garcia','Gregg Garcia'),(72,'Kathy Suarez','Kathy Suarez'),(73,'William Nelson','William Nelson'),(74,'Deborah Diaz','Deborah Diaz'),(75,'Kevin Anderson','Kevin Anderson'),(76,'Lindsey Petersen','Lindsey Petersen'),(77,'Desiree Andrade','Desiree Andrade'),(78,'Derrick Roberts PhD','Derrick Roberts PhD'),(79,'Lisa Ellison','Lisa Ellison'),(80,'Laura Kerr','Laura Kerr'),(81,'Gary Moore','Gary Moore'),(82,'Stephanie Atkinson','Stephanie Atkinson'),(83,'Kayla Marquez','Kayla Marquez'),(84,'Russell Oliver','Russell Oliver'),(85,'Brittany Stewart','Brittany Stewart'),(86,'Bonnie Reyes','Bonnie Reyes'),(87,'Angelica Cruz','Angelica Cruz'),(88,'Stephanie Dunn','Stephanie Dunn'),(89,'Rebecca Richardson','Rebecca Richardson'),(90,'Stephanie Allen','Stephanie Allen'),(91,'Gabrielle Michael','Gabrielle Michael'),(92,'Diana Bishop','Diana Bishop'),(93,'Joshua Meyer','Joshua Meyer'),(94,'Jennifer Oliver','Jennifer Oliver'),(95,'Stephen Tucker','Stephen Tucker'),(96,'Tammy Adams','Tammy Adams'),(97,'Michael Serrano','Michael Serrano'),(98,'Bradley Benitez','Bradley Benitez'),(99,'Darren Duke','Darren Duke'),(100,'Ashley Hamilton','Ashley Hamilton');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_course`
--

DROP TABLE IF EXISTS `sub_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_course` (
  `curr_course_id` int NOT NULL,
  `subn_course_id` int NOT NULL,
  `student_id` int NOT NULL,
  `status` enum('PENDING','SUCCESSFULL','FAILED') DEFAULT 'PENDING',
  PRIMARY KEY (`student_id`,`curr_course_id`,`subn_course_id`),
  KEY `curr_course_id` (`curr_course_id`),
  KEY `subn_course_id` (`subn_course_id`),
  CONSTRAINT `sub_course_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sub_course_ibfk_2` FOREIGN KEY (`curr_course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sub_course_ibfk_3` FOREIGN KEY (`subn_course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_course`
--

LOCK TABLES `sub_course` WRITE;
/*!40000 ALTER TABLE `sub_course` DISABLE KEYS */;
INSERT INTO `sub_course` VALUES (8,13,2,'SUCCESSFULL'),(15,9,2,'SUCCESSFULL'),(11,9,3,'SUCCESSFULL'),(3,17,4,'FAILED'),(16,15,4,'SUCCESSFULL'),(1,2,5,'SUCCESSFULL'),(1,5,6,'SUCCESSFULL'),(4,10,6,'SUCCESSFULL'),(9,3,8,'SUCCESSFULL'),(20,7,9,'SUCCESSFULL'),(1,4,10,'SUCCESSFULL'),(15,3,13,'SUCCESSFULL'),(13,18,15,'SUCCESSFULL'),(20,8,15,'SUCCESSFULL'),(2,8,17,'SUCCESSFULL'),(12,18,17,'SUCCESSFULL'),(14,16,18,'SUCCESSFULL'),(10,2,19,'SUCCESSFULL'),(14,4,20,'SUCCESSFULL'),(8,19,23,'SUCCESSFULL'),(13,15,23,'SUCCESSFULL'),(3,11,25,'FAILED'),(15,18,25,'SUCCESSFULL'),(11,1,26,'FAILED'),(12,19,28,'SUCCESSFULL'),(17,7,28,'SUCCESSFULL'),(11,3,29,'SUCCESSFULL'),(17,1,29,'SUCCESSFULL'),(4,3,30,'SUCCESSFULL'),(14,7,30,'SUCCESSFULL'),(17,9,32,'SUCCESSFULL'),(20,10,32,'SUCCESSFULL'),(5,17,33,'SUCCESSFULL'),(15,13,33,'SUCCESSFULL'),(19,8,34,'SUCCESSFULL'),(8,20,37,'SUCCESSFULL'),(4,10,38,'SUCCESSFULL'),(10,14,39,'SUCCESSFULL'),(1,6,40,'SUCCESSFULL'),(13,3,40,'SUCCESSFULL'),(7,1,42,'SUCCESSFULL'),(9,2,42,'SUCCESSFULL'),(10,4,43,'SUCCESSFULL'),(1,18,44,'FAILED'),(7,6,44,'SUCCESSFULL'),(8,13,46,'SUCCESSFULL'),(10,6,47,'FAILED'),(17,12,47,'FAILED'),(1,15,49,'SUCCESSFULL'),(2,4,49,'SUCCESSFULL'),(10,16,52,'SUCCESSFULL'),(16,8,53,'SUCCESSFULL'),(3,13,54,'SUCCESSFULL'),(15,1,54,'SUCCESSFULL'),(8,9,56,'SUCCESSFULL'),(16,13,56,'SUCCESSFULL'),(8,6,57,'FAILED'),(11,4,57,'SUCCESSFULL'),(2,11,58,'SUCCESSFULL'),(13,5,61,'SUCCESSFULL'),(8,14,64,'SUCCESSFULL'),(8,11,66,'SUCCESSFULL'),(19,18,66,'FAILED'),(7,5,68,'SUCCESSFULL'),(16,8,68,'SUCCESSFULL'),(7,18,69,'FAILED'),(15,9,69,'SUCCESSFULL'),(13,20,71,'SUCCESSFULL'),(7,1,73,'SUCCESSFULL'),(20,16,73,'SUCCESSFULL'),(2,8,74,'FAILED'),(20,1,77,'SUCCESSFULL'),(11,9,78,'FAILED'),(8,16,79,'SUCCESSFULL'),(4,15,83,'SUCCESSFULL'),(7,8,83,'SUCCESSFULL'),(2,10,85,'SUCCESSFULL'),(5,14,85,'SUCCESSFULL'),(7,14,86,'SUCCESSFULL'),(19,8,87,'SUCCESSFULL'),(11,14,88,'FAILED'),(12,4,89,'SUCCESSFULL'),(17,6,89,'FAILED'),(4,15,93,'SUCCESSFULL'),(13,12,94,'SUCCESSFULL'),(17,8,94,'SUCCESSFULL'),(8,10,95,'FAILED'),(13,14,96,'FAILED'),(19,15,96,'FAILED'),(11,8,97,'SUCCESSFULL'),(5,9,98,'FAILED'),(20,18,98,'FAILED'),(13,18,99,'FAILED'),(7,14,100,'FAILED');
/*!40000 ALTER TABLE `sub_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `takes`
--

DROP TABLE IF EXISTS `takes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `takes` (
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`student_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `takes_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE,
  CONSTRAINT `takes_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `takes`
--

LOCK TABLES `takes` WRITE;
/*!40000 ALTER TABLE `takes` DISABLE KEYS */;
INSERT INTO `takes` VALUES (1,1),(8,1),(9,1),(12,1),(15,1),(16,1),(18,1),(19,1),(20,1),(25,1),(27,1),(29,1),(30,1),(31,1),(32,1),(34,1),(35,1),(37,1),(42,1),(43,1),(44,1),(45,1),(50,1),(52,1),(54,1),(59,1),(60,1),(61,1),(62,1),(63,1),(64,1),(65,1),(66,1),(73,1),(77,1),(2,2),(4,2),(5,2),(6,2),(7,2),(14,2),(19,2),(20,2),(27,2),(29,2),(36,2),(42,2),(43,2),(44,2),(45,2),(53,2),(54,2),(55,2),(59,2),(60,2),(62,2),(63,2),(66,2),(69,2),(70,2),(77,2),(79,2),(80,2),(81,2),(84,2),(88,2),(91,2),(92,2),(94,2),(99,2),(100,2),(2,3),(6,3),(8,3),(9,3),(11,3),(13,3),(16,3),(17,3),(26,3),(29,3),(30,3),(31,3),(32,3),(33,3),(34,3),(35,3),(40,3),(41,3),(42,3),(43,3),(44,3),(46,3),(49,3),(50,3),(52,3),(56,3),(58,3),(59,3),(61,3),(62,3),(63,3),(66,3),(68,3),(69,3),(71,3),(72,3),(75,3),(78,3),(79,3),(83,3),(85,3),(86,3),(87,3),(89,3),(91,3),(92,3),(93,3),(95,3),(97,3),(98,3),(99,3),(3,4),(7,4),(10,4),(12,4),(14,4),(20,4),(21,4),(23,4),(24,4),(25,4),(26,4),(27,4),(29,4),(31,4),(32,4),(33,4),(34,4),(37,4),(43,4),(44,4),(47,4),(49,4),(52,4),(55,4),(57,4),(60,4),(61,4),(63,4),(64,4),(65,4),(67,4),(72,4),(73,4),(74,4),(78,4),(80,4),(82,4),(84,4),(85,4),(86,4),(88,4),(89,4),(94,4),(95,4),(97,4),(98,4),(99,4),(100,4),(1,5),(3,5),(5,5),(6,5),(17,5),(18,5),(19,5),(22,5),(24,5),(25,5),(26,5),(28,5),(29,5),(30,5),(37,5),(39,5),(41,5),(42,5),(44,5),(51,5),(53,5),(58,5),(59,5),(60,5),(61,5),(65,5),(68,5),(71,5),(73,5),(74,5),(75,5),(76,5),(77,5),(80,5),(82,5),(83,5),(84,5),(86,5),(89,5),(90,5),(91,5),(92,5),(93,5),(94,5),(96,5),(98,5),(1,6),(3,6),(8,6),(10,6),(20,6),(22,6),(25,6),(28,6),(31,6),(33,6),(36,6),(39,6),(40,6),(41,6),(44,6),(45,6),(48,6),(50,6),(53,6),(59,6),(62,6),(64,6),(1,7),(3,7),(9,7),(11,7),(13,7),(20,7),(23,7),(24,7),(28,7),(30,7),(33,7),(36,7),(38,7),(45,7),(49,7),(54,7),(57,7),(58,7),(59,7),(64,7),(65,7),(69,7),(71,7),(75,7),(78,7),(79,7),(81,7),(85,7),(87,7),(89,7),(90,7),(91,7),(93,7),(96,7),(97,7),(99,7),(4,8),(7,8),(12,8),(13,8),(15,8),(16,8),(17,8),(18,8),(19,8),(22,8),(30,8),(32,8),(34,8),(35,8),(40,8),(41,8),(43,8),(45,8),(48,8),(53,8),(54,8),(55,8),(57,8),(58,8),(67,8),(68,8),(75,8),(78,8),(81,8),(82,8),(83,8),(84,8),(86,8),(87,8),(88,8),(89,8),(91,8),(93,8),(94,8),(96,8),(97,8),(98,8),(1,9),(2,9),(3,9),(4,9),(6,9),(20,9),(21,9),(24,9),(26,9),(31,9),(32,9),(35,9),(37,9),(38,9),(39,9),(40,9),(45,9),(46,9),(47,9),(48,9),(50,9),(56,9),(69,9),(2,10),(4,10),(6,10),(8,10),(10,10),(13,10),(16,10),(17,10),(18,10),(22,10),(23,10),(25,10),(26,10),(32,10),(33,10),(35,10),(38,10),(41,10),(44,10),(47,10),(51,10),(53,10),(58,10),(59,10),(61,10),(66,10),(68,10),(70,10),(71,10),(73,10),(74,10),(76,10),(77,10),(79,10),(85,10),(92,10),(7,11),(9,11),(10,11),(12,11),(14,11),(15,11),(16,11),(19,11),(20,11),(24,11),(31,11),(36,11),(38,11),(40,11),(41,11),(43,11),(45,11),(47,11),(48,11),(51,11),(54,11),(56,11),(58,11),(59,11),(65,11),(66,11),(68,11),(69,11),(70,11),(71,11),(72,11),(73,11),(74,11),(76,11),(78,11),(84,11),(89,11),(90,11),(91,11),(92,11),(93,11),(95,11),(98,11),(100,11),(5,12),(6,12),(8,12),(9,12),(11,12),(16,12),(19,12),(21,12),(24,12),(27,12),(32,12),(35,12),(40,12),(41,12),(46,12),(49,12),(50,12),(51,12),(54,12),(55,12),(57,12),(58,12),(61,12),(62,12),(63,12),(66,12),(67,12),(68,12),(71,12),(72,12),(74,12),(75,12),(76,12),(77,12),(79,12),(81,12),(82,12),(83,12),(87,12),(92,12),(94,12),(95,12),(96,12),(97,12),(98,12),(100,12),(2,13),(3,13),(7,13),(10,13),(12,13),(13,13),(21,13),(22,13),(24,13),(25,13),(27,13),(28,13),(32,13),(33,13),(35,13),(36,13),(46,13),(49,13),(50,13),(54,13),(56,13),(57,13),(63,13),(64,13),(67,13),(69,13),(70,13),(72,13),(78,13),(79,13),(80,13),(81,13),(82,13),(83,13),(84,13),(87,13),(88,13),(90,13),(92,13),(96,13),(98,13),(1,14),(4,14),(5,14),(7,14),(8,14),(11,14),(12,14),(14,14),(17,14),(19,14),(23,14),(24,14),(26,14),(27,14),(28,14),(36,14),(38,14),(39,14),(44,14),(46,14),(52,14),(53,14),(55,14),(64,14),(85,14),(86,14),(4,15),(8,15),(10,15),(11,15),(17,15),(19,15),(20,15),(23,15),(26,15),(29,15),(38,15),(39,15),(41,15),(42,15),(43,15),(45,15),(47,15),(48,15),(49,15),(50,15),(51,15),(52,15),(55,15),(61,15),(62,15),(67,15),(75,15),(77,15),(78,15),(83,15),(88,15),(91,15),(93,15),(1,16),(7,16),(10,16),(12,16),(15,16),(18,16),(22,16),(23,16),(27,16),(28,16),(29,16),(30,16),(31,16),(33,16),(38,16),(41,16),(48,16),(49,16),(51,16),(52,16),(54,16),(63,16),(65,16),(67,16),(70,16),(72,16),(73,16),(76,16),(79,16),(80,16),(81,16),(82,16),(84,16),(86,16),(87,16),(90,16),(93,16),(94,16),(95,16),(96,16),(98,16),(99,16),(2,17),(5,17),(6,17),(8,17),(12,17),(13,17),(14,17),(16,17),(17,17),(22,17),(23,17),(31,17),(33,17),(34,17),(36,17),(37,17),(38,17),(39,17),(40,17),(41,17),(43,17),(45,17),(48,17),(49,17),(52,17),(57,17),(58,17),(59,17),(69,17),(70,17),(71,17),(72,17),(75,17),(76,17),(77,17),(79,17),(82,17),(84,17),(85,17),(86,17),(87,17),(88,17),(89,17),(90,17),(93,17),(95,17),(97,17),(100,17),(3,18),(9,18),(11,18),(13,18),(14,18),(15,18),(17,18),(21,18),(22,18),(25,18),(35,18),(37,18),(48,18),(49,18),(50,18),(54,18),(56,18),(57,18),(60,18),(62,18),(65,18),(67,18),(70,18),(71,18),(72,18),(2,19),(4,19),(5,19),(7,19),(9,19),(11,19),(12,19),(13,19),(15,19),(17,19),(18,19),(23,19),(28,19),(29,19),(35,19),(42,19),(46,19),(47,19),(49,19),(51,19),(55,19),(57,19),(60,19),(65,19),(66,19),(68,19),(69,19),(73,19),(77,19),(80,19),(83,19),(84,19),(85,19),(88,19),(89,19),(90,19),(91,19),(92,19),(94,19),(97,19),(99,19),(100,19),(2,20),(4,20),(5,20),(10,20),(18,20),(19,20),(21,20),(22,20),(26,20),(30,20),(33,20),(34,20),(35,20),(37,20),(38,20),(40,20),(42,20),(43,20),(45,20),(46,20),(51,20),(52,20),(56,20),(60,20),(62,20),(63,20),(64,20),(66,20),(71,20),(74,20),(75,20),(80,20),(81,20),(82,20),(85,20),(88,20),(89,20),(90,20),(92,20),(93,20),(96,20),(97,20),(98,20);
/*!40000 ALTER TABLE `takes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL DEFAULT 'Teacher',
  `username` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (1,'Manuel Garza','Manuel Garza'),(2,'Rebecca Taylor','Rebecca Taylor'),(3,'Lauren Smith','Lauren Smith'),(4,'Blake Bullock','Blake Bullock'),(5,'Sarah Curry','Sarah Curry'),(6,'Jason Rivera','Jason Rivera'),(7,'Jodi Cox','Jodi Cox'),(8,'Sherry Thompson','Sherry Thompson'),(9,'Gina Williams','Gina Williams'),(10,'Christina Myers','Christina Myers'),(11,'Kevin Lopez','Kevin Lopez'),(12,'Gregory King','Gregory King'),(13,'Michael Moore','Michael Moore'),(14,'Beth Cohen','Beth Cohen'),(15,'Lori Leach','Lori Leach');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdraw_course`
--

DROP TABLE IF EXISTS `withdraw_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdraw_course` (
  `course_id` int NOT NULL,
  `student_id` int NOT NULL,
  `status` enum('PENDING','SUCCESSFULL','FAILED') DEFAULT 'PENDING',
  PRIMARY KEY (`student_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `withdraw_course_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE,
  CONSTRAINT `withdraw_course_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdraw_course`
--

LOCK TABLES `withdraw_course` WRITE;
/*!40000 ALTER TABLE `withdraw_course` DISABLE KEYS */;
INSERT INTO `withdraw_course` VALUES (18,1,'SUCCESSFULL'),(19,1,'SUCCESSFULL'),(1,3,'SUCCESSFULL'),(3,4,'SUCCESSFULL'),(7,4,'SUCCESSFULL'),(3,5,'SUCCESSFULL'),(9,5,'SUCCESSFULL'),(15,6,'SUCCESSFULL'),(14,9,'SUCCESSFULL'),(17,9,'SUCCESSFULL'),(5,10,'SUCCESSFULL'),(2,11,'SUCCESSFULL'),(17,11,'SUCCESSFULL'),(12,13,'SUCCESSFULL'),(16,13,'SUCCESSFULL'),(10,14,'SUCCESSFULL'),(16,14,'SUCCESSFULL'),(3,15,'SUCCESSFULL'),(15,15,'SUCCESSFULL'),(2,16,'SUCCESSFULL'),(6,18,'SUCCESSFULL'),(13,18,'SUCCESSFULL'),(19,20,'SUCCESSFULL'),(5,21,'SUCCESSFULL'),(15,21,'SUCCESSFULL'),(3,25,'SUCCESSFULL'),(11,26,'SUCCESSFULL'),(5,27,'SUCCESSFULL'),(4,28,'SUCCESSFULL'),(7,29,'SUCCESSFULL'),(2,30,'SUCCESSFULL'),(15,30,'SUCCESSFULL'),(2,32,'SUCCESSFULL'),(9,34,'SUCCESSFULL'),(15,34,'SUCCESSFULL'),(9,36,'SUCCESSFULL'),(10,37,'SUCCESSFULL'),(11,39,'SUCCESSFULL'),(20,39,'SUCCESSFULL'),(11,42,'SUCCESSFULL'),(18,42,'SUCCESSFULL'),(10,46,'SUCCESSFULL'),(17,47,'SUCCESSFULL'),(18,47,'SUCCESSFULL'),(8,51,'SUCCESSFULL'),(4,53,'SUCCESSFULL'),(11,53,'SUCCESSFULL'),(5,55,'SUCCESSFULL'),(5,56,'SUCCESSFULL'),(17,56,'SUCCESSFULL'),(13,58,'SUCCESSFULL'),(7,60,'SUCCESSFULL'),(12,60,'SUCCESSFULL'),(20,61,'SUCCESSFULL'),(5,64,'SUCCESSFULL'),(6,65,'SUCCESSFULL'),(16,66,'SUCCESSFULL'),(1,67,'SUCCESSFULL'),(13,68,'SUCCESSFULL'),(19,70,'SUCCESSFULL'),(15,73,'SUCCESSFULL'),(2,74,'SUCCESSFULL'),(17,74,'SUCCESSFULL'),(13,76,'SUCCESSFULL'),(15,76,'SUCCESSFULL'),(3,77,'SUCCESSFULL'),(4,77,'SUCCESSFULL'),(2,78,'SUCCESSFULL'),(16,78,'SUCCESSFULL'),(4,79,'SUCCESSFULL'),(12,80,'SUCCESSFULL'),(11,81,'SUCCESSFULL'),(17,83,'SUCCESSFULL'),(19,86,'SUCCESSFULL'),(4,87,'SUCCESSFULL'),(11,88,'SUCCESSFULL'),(3,90,'SUCCESSFULL'),(4,91,'SUCCESSFULL'),(3,94,'SUCCESSFULL'),(5,95,'SUCCESSFULL'),(8,95,'SUCCESSFULL'),(19,96,'SUCCESSFULL'),(13,99,'SUCCESSFULL'),(17,99,'SUCCESSFULL'),(5,100,'SUCCESSFULL'),(7,100,'SUCCESSFULL');
/*!40000 ALTER TABLE `withdraw_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `myAdditions`
--

/*!50001 DROP VIEW IF EXISTS `myAdditions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mohitdmak`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `myAdditions` AS select `c`.`id` AS `course_id`,`c`.`name` AS `course_name`,`c`.`seats_left` AS `seats_left`,`s`.`id` AS `student_id`,`a`.`status` AS `status` from ((`add_course` `a` join `student` `s`) join `course` `c` on(((`a`.`student_id` = `s`.`id`) and (`a`.`course_id` = `c`.`id`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `myCourses`
--

/*!50001 DROP VIEW IF EXISTS `myCourses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mohitdmak`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `myCourses` AS select `c`.`id` AS `course_id`,`c`.`name` AS `course_name`,`c`.`IC_id` AS `IC_id`,(select `teacher`.`name` from `teacher` where (`teacher`.`id` = `c`.`IC_id`)) AS `course_IC`,`c`.`capacity` AS `course_capacity`,`t`.`student_id` AS `student_id` from (`course` `c` join `takes` `t` on((`c`.`id` = `t`.`course_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mySubstitutions`
--

/*!50001 DROP VIEW IF EXISTS `mySubstitutions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mohitdmak`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `mySubstitutions` AS select `sub_course`.`curr_course_id` AS `curr_course_id`,(select `course`.`name` from `course` where (`course`.`id` = `sub_course`.`curr_course_id`)) AS `curr_course_name`,(select `course`.`seats_left` from `course` where (`course`.`id` = `sub_course`.`curr_course_id`)) AS `curr_course_seats_left`,`sub_course`.`subn_course_id` AS `subn_course_id`,(select `course`.`name` from `course` where (`course`.`id` = `sub_course`.`subn_course_id`)) AS `subn_course_name`,(select `course`.`seats_left` from `course` where (`course`.`id` = `sub_course`.`subn_course_id`)) AS `subn_course_seats_left`,`sub_course`.`student_id` AS `student_id`,`sub_course`.`status` AS `status` from `sub_course` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `myWithdrawals`
--

/*!50001 DROP VIEW IF EXISTS `myWithdrawals`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mohitdmak`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `myWithdrawals` AS select `withdraw_course`.`course_id` AS `course_id`,(select `course`.`name` from `course` where (`course`.`id` = `withdraw_course`.`course_id`)) AS `course_name`,(select `course`.`seats_left` from `course` where (`course`.`id` = `withdraw_course`.`course_id`)) AS `seats_left`,`withdraw_course`.`student_id` AS `student_id`,`withdraw_course`.`status` AS `status` from `withdraw_course` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-13  1:01:23
