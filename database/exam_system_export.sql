-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: exam_system
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `questionID` int NOT NULL,
  `answerNum` int DEFAULT NULL,
  `answer` enum('True','False') DEFAULT NULL,
  PRIMARY KEY (`questionID`),
  UNIQUE KEY `questionID` (`questionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
INSERT INTO `answers` VALUES (1,1,'True'),(2,2,'False'),(3,1,'True'),(4,2,'False'),(5,1,'False'),(6,2,'True'),(7,1,'True'),(8,2,'True'),(9,1,'False'),(10,2,'True'),(11,1,'False'),(12,2,'False'),(13,1,'True'),(14,2,'True'),(15,1,'False'),(16,2,'True'),(17,1,'False'),(18,2,'False'),(19,1,'True'),(20,2,'False'),(21,NULL,'False'),(22,NULL,'True');
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `courseMeta` varchar(100) NOT NULL,
  `courseName` varchar(255) NOT NULL,
  `instructor` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`courseMeta`),
  UNIQUE KEY `courseMeta` (`courseMeta`),
  UNIQUE KEY `courseName` (`courseName`),
  KEY `instructor` (`instructor`),
  CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`instructor`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES ('ITC603_21603_Spring_2021','System Analysis, Mod & Desing(01)','Dr Ali'),('ITC604_21604_Spring_2021','System Analysis, Mod & Desing(02)','Dr Ali'),('ITC604_21605_Spring_2021','Design Analysis and Algorithms','Dr Ali');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exams`
--

DROP TABLE IF EXISTS `exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exams` (
  `examID` int NOT NULL AUTO_INCREMENT,
  `examName` varchar(255) NOT NULL,
  `dat` date DEFAULT NULL,
  `tim` time DEFAULT NULL,
  `duration` int NOT NULL,
  `courseMeta` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`examID`),
  KEY `courseMeta` (`courseMeta`),
  CONSTRAINT `exams_ibfk_1` FOREIGN KEY (`courseMeta`) REFERENCES `courses` (`courseMeta`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exams`
--

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;
INSERT INTO `exams` VALUES (1,'New Exam','2021-04-14','12:00:00',2,'ITC603_21603_Spring_2021'),(2,'DAA-Q1','2021-04-15','22:00:00',1,'ITC604_21605_Spring_2021'),(3,'DSA','2021-04-17','13:00:00',2,'ITC604_21605_Spring_2021'),(4,'Calculus Exam-3','2021-04-09','02:00:00',1,'ITC604_21604_Spring_2021'),(5,'Mobile Development','2021-04-20','20:46:00',2,'ITC603_21603_Spring_2021'),(6,'Mobile Development-2','2021-04-20','20:46:00',2,'ITC603_21603_Spring_2021'),(7,'Quiz-2','2021-04-12','10:00:00',2,'ITC604_21605_Spring_2021'),(8,'Quiz-infinite','2021-04-13','12:00:00',2,'ITC604_21604_Spring_2021'),(9,'Quiz-5','2021-04-28','13:00:00',2,'ITC604_21605_Spring_2021'),(10,'Quiz-95','2021-04-29','12:13:00',1,'ITC604_21604_Spring_2021'),(11,'Chemistry','2021-04-14','17:30:00',1,'ITC603_21603_Spring_2021');
/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `questionID` int NOT NULL AUTO_INCREMENT,
  `examID` int NOT NULL,
  `questionNum` int NOT NULL,
  `question` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`questionID`),
  KEY `examID` (`examID`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`examID`) REFERENCES `exams` (`examID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,1,1,'Pappo can\'t pass saala!'),(2,1,2,'Pappo naach nahi sktaa!'),(3,2,1,'The reflexive property hold for o (little-oh) and w.'),(4,2,2,'For two algorithms A and B, if O(A) = n^100 and O(B) = 10^n, then algorithm A is the better choice.'),(5,3,1,'Array is a pointer.'),(6,3,2,'Linked Lists are lovely.'),(7,4,1,'Calculus is cool'),(8,4,2,'Calculus is very cool'),(9,5,1,'You can make this with that and that with this.'),(10,5,2,'That was first this and then it make that.'),(11,6,1,'You can make this with that and that with this.'),(12,6,2,'That was first this and then it make that.'),(13,7,1,'You can make this with that and that with this.'),(14,7,2,'Calculus is very cool'),(15,8,1,'You can make this with that and that with this.'),(16,8,2,'Pappo naach nahi sktaa!'),(17,9,1,'Calculus is cool'),(18,9,2,'Linked Lists are lovely.'),(19,10,1,'Array is a pointer.'),(20,10,2,'Calculus is very cool'),(21,11,1,'Covalent Bonds are weaker than ionic bonds.'),(22,11,2,'Hydrogen bonding is less strong than ionic bond.');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_name` varchar(255) NOT NULL,
  `courseMeta` varchar(255) NOT NULL,
  `student_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseMeta` (`courseMeta`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`courseMeta`) REFERENCES `courses` (`courseMeta`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (3,'Zain Ul Abideen','ITC603_21603_Spring_2021',7),(4,'Zain Ul Abideen','ITC604_21604_Spring_2021',7),(5,'Zain Ul Abideen','ITC604_21605_Spring_2021',7),(6,'saad','ITC603_21603_Spring_2021',5),(7,'saad','ITC604_21604_Spring_2021',5),(8,'saad','ITC604_21605_Spring_2021',5),(9,'ayesha','ITC603_21603_Spring_2021',1),(10,'ayesha','ITC604_21604_Spring_2021',1),(11,'ayesha','ITC604_21605_Spring_2021',1),(12,'imran','ITC603_21603_Spring_2021',8),(13,'imran','ITC604_21604_Spring_2021',8),(14,'imran','ITC604_21605_Spring_2021',8);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('student','instructor') DEFAULT NULL,
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'ayesha','$2b$08$G7aQGBECL67LXBumsA8pL.alBeyHSkwgShc26FJOTGWk3rmxZAqSi','student'),(6,'Dr Ali','$2b$08$uY63Pjk6oNqbi8ErzYQJQO8qvdqWmxb.cXIFTCvyjhv6FzzJt4Jhm','instructor'),(8,'imran','$2b$08$brLukepacEQqUajrtwYNx.27sdCVEvjhRzt8TpiJoGceUuQ2Wv2Kq','student'),(5,'saad','$2b$08$Yu8CP6I29PiU6.08o9s1qugEJcZqVApvvTF4K./H7BHFz/VPaIL56','student'),(7,'Zain Ul Abideen','$2b$08$1za17uug0Ahv6czn9UrWHeNoRscPFWd5ytvGuJjJ5f9trn2Fh4.z6','student');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-12  1:00:15
