-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: twitter
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.20.04.1

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
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chats` (
  `chats_id` int NOT NULL AUTO_INCREMENT,
  `chat_content` varchar(255) NOT NULL,
  `chat_socket_id` varchar(255) NOT NULL,
  `chat_sender` varchar(45) NOT NULL,
  PRIMARY KEY (`chats_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES (1,'hey','admin@gmail.com-abhi@gmail.com','admin@gmail.com'),(2,'hey','admin@gmail.com-abhi@gmail.com','admin@gmail.com'),(3,'hello','admin@gmail.com-abhi@gmail.com','admin@gmail.com'),(4,'hello','admin@gmail.com-ravi@gmail.com','admin@gmail.com'),(5,'hey','admin@gmail.com-ravi@gmail.com','ravi@gmail.com'),(6,'how are you doing','admin@gmail.com-ravi@gmail.com','admin@gmail.com'),(7,'i m fine','admin@gmail.com-ravi@gmail.com','ravi@gmail.com'),(8,'tell me about you','admin@gmail.com-ravi@gmail.com','ravi@gmail.com'),(9,'how is your going on','admin@gmail.com-ravi@gmail.com','ravi@gmail.com'),(10,'everything is fine','admin@gmail.com-ravi@gmail.com','admin@gmail.com'),(11,'hey','admin@gmail.com-1747144696604-admin@gmail.com','admin@gmail.com'),(12,'hello','admin@gmail.com-1747143901587','ravi@gmail.com'),(13,'hey','admin@gmail.com-1747143901587','admin@gmail.com'),(14,'kem cho','admin@gmail.com-1747143901587','ravi@gmail.com'),(15,'su chale','admin@gmail.com-1747143901587','ravi@gmail.com'),(16,'man','admin@gmail.com-1747143901587','ravi@gmail.com'),(17,'hello abhi','admin@gmail.com-1747143901587','abhi@gmail.com'),(18,'how are you ?','admin@gmail.com-1747143901587','abhi@gmail.com'),(19,'hii','admin@gmail.com-1747143901587','admin@gmail.com'),(20,'hii','admin@gmail.com-1747143901587','admin@gmail.com'),(21,'hiii','admin@gmail.com-1747143901587','ravi@gmail.com'),(22,'hello','admin@gmail.com-1747143901587','admin@gmail.com'),(23,'heyyyy','admin@gmail.com-1747143901587','abhi@gmail.com'),(24,'hgfds','admin@gmail.com-1747143901587','admin@gmail.com'),(25,'cfgss','admin@gmail.com-1747143901587','admin@gmail.com'),(26,'asfdag','admin@gmail.com-1747143901587','ravi@gmail.com'),(27,'hello','admin@gmail.com-ravi@gmail.com','admin@gmail.com'),(28,'wait','admin@gmail.com-ravi@gmail.com','ravi@gmail.com'),(29,'Marmik here','admin@gmail.com-1747143901587','abhi@gmail.com'),(30,'su chale','admin@gmail.com-1747143901587','abhi@gmail.com');
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `followers`
--

DROP TABLE IF EXISTS `followers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `followers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(100) NOT NULL,
  `following_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `follower_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active_follower` int DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `follower_id` (`following_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `followers_ibfk_1` FOREIGN KEY (`following_id`) REFERENCES `user_detail` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `followers_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_detail` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `followers`
--

LOCK TABLES `followers` WRITE;
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` VALUES (51,'ravi@gmail.com','abhi@gmail.com','2025-03-19 12:59:33',1),(52,'ravi@gmail.com','admin@gmail.com','2025-03-19 12:59:35',1),(53,'ravi@gmail.com','marmik@gmail.com','2025-03-19 12:59:37',1),(54,'ravi@gmail.com','swapnil@gmail.com','2025-03-19 12:59:40',1),(55,'arun@gmail.com','abhi@gmail.com','2025-03-19 13:00:34',1),(56,'arun@gmail.com','marmik@gmail.com','2025-03-19 13:00:37',1),(57,'arun@gmail.com','admin@gmail.com','2025-03-19 13:00:39',1),(58,'arun@gmail.com','swapnil@gmail.com','2025-03-19 13:00:41',1),(59,'arun@gmail.com','ravi@gmail.com','2025-03-19 13:00:43',1),(60,'akshay@gmail.com','admin@gmail.com','2025-03-19 13:08:42',0),(61,'akshay@gmail.com','marmik@gmail.com','2025-03-19 13:08:45',0),(62,'akshay@gmail.com','abhi@gmail.com','2025-03-19 13:08:46',0),(63,'akshay@gmail.com','parth@gmail.com','2025-03-19 13:08:48',0),(64,'akshay@gmail.com','ravi@gmail.com','2025-03-19 13:10:36',0),(65,'akshay@gmail.com','arun@gmail.com','2025-03-19 13:10:37',1),(66,'swapnil@gmail.com','akshay@gmail.com','2025-03-19 13:11:43',1),(67,'swapnil@gmail.com','arun@gmail.com','2025-03-19 13:11:44',1),(68,'swapnil@gmail.com','dhruv@gmail.com','2025-03-19 13:11:45',1),(69,'swapnil@gmail.com','marmik@gmail.com','2025-03-19 13:11:46',1),(70,'swapnil@gmail.com','abhi@gmail.com','2025-03-19 13:11:47',1),(71,'swapnil@gmail.com','ravi@gmail.com','2025-03-19 13:11:47',1),(72,'parth@gmail.com','admin@gmail.com','2025-03-19 13:14:20',1),(73,'parth@gmail.com','abhi@gmail.com','2025-03-19 13:14:20',1),(74,'parth@gmail.com','marmik@gmail.com','2025-03-19 13:14:21',1),(75,'parth@gmail.com','ravi@gmail.com','2025-03-19 13:14:21',1),(76,'parth@gmail.com','arun@gmail.com','2025-03-19 13:14:21',1),(77,'parth@gmail.com','swapnil@gmail.com','2025-03-19 13:14:21',1),(78,'parth@gmail.com','dhruv@gmail.com','2025-03-19 13:14:21',1),(79,'parth@gmail.com','akshay@gmail.com','2025-03-19 13:14:23',1),(80,'abhi@gmail.com','ravi@gmail.com','2025-03-19 13:15:27',1),(81,'abhi@gmail.com','parth@gmail.com','2025-03-19 13:15:28',1),(82,'abhi@gmail.com','marmik@gmail.com','2025-03-19 13:15:29',0),(83,'abhi@gmail.com','admin@gmail.com','2025-03-19 13:15:29',1),(84,'abhi@gmail.com','akshay@gmail.com','2025-03-19 13:15:30',1),(85,'abhi@gmail.com','dhruv@gmail.com','2025-03-19 13:15:31',1),(86,'ravi@gmail.com','parth@gmail.com','2025-03-20 08:12:31',1),(87,'ravi@gmail.com','arun@gmail.com','2025-03-20 08:12:32',1),(88,'abhi@gmail.com','arun@gmail.com','2025-03-20 12:15:55',1),(89,'jd@gmail.com','admin@gmail.com','2025-03-21 05:28:27',0),(90,'jd@gmail.com','abhi@gmail.com','2025-03-21 05:28:28',0),(91,'jd@gmail.com','marmik@gmail.com','2025-03-21 05:28:29',1),(92,'abhi@gmail.com','abcd@gmail.com','2025-03-21 11:06:56',1),(93,'abhi@gmail.com','abcde@gmail.com','2025-03-21 11:07:23',1),(94,'marmikshah@gmail.com','admin@gmail.com','2025-03-21 13:02:19',1),(95,'marmikshah@gmail.com','abhi@gmail.com','2025-03-21 13:02:20',1),(96,'marmikshah@gmail.com','marmik@gmail.com','2025-03-21 13:02:21',1),(97,'marmikshah@gmail.com','parth@gmail.com','2025-03-21 13:02:24',1),(98,'marmikshah@gmail.com','ravi@gmail.com','2025-03-21 13:02:27',1),(99,'marmikshah@gmail.com','swapnil@gmail.com','2025-03-21 13:06:43',1),(100,'marmikshah@gmail.com','arun@gmail.com','2025-03-21 13:06:44',1),(101,'marmikshah@gmail.com','akshay@gmail.com','2025-03-21 13:06:44',1),(102,'marmikshah@gmail.com','dhruv@gmail.com','2025-03-21 13:06:45',1),(103,'abhi@gmail.com','swapnil@gmail.com','2025-03-24 10:23:56',1),(104,'abhi@gmail.com','jd@gmail.com','2025-03-24 10:23:57',1),(105,'abhi@gmail.com','anjali@gmail.com','2025-03-24 10:23:57',1),(106,'abhi@gmail.com','parthb@gmail.com','2025-03-24 10:23:57',1),(107,'abhi@gmail.com','vihar@gmail.com','2025-03-24 10:23:58',1),(108,'abhi@gmail.com','karan@gmail.com','2025-03-24 10:23:58',0),(109,'abhi@gmail.com','abhishek@gmail.com','2025-03-24 10:23:58',1),(110,'abhi@gmail.com','jd2@gmail.com','2025-03-24 10:23:58',1),(111,'abhi@gmail.com','yash@gmail.com','2025-03-24 10:23:58',1),(112,'abhi@gmail.com','l@gmail.com','2025-03-24 10:23:59',1),(113,'abhi@gmail.com','aa@gmail.com','2025-03-24 10:23:59',0),(114,'abhi@gmail.com','keshav@gmail.com','2025-03-24 10:23:59',0),(115,'abhi@gmail.com','aaaaa@gmail.com','2025-03-24 10:24:00',1),(116,'abhi@gmail.com','akhilesh@gmail.com','2025-03-24 10:24:02',1),(117,'admin@gmail.com','abhi@gmail.com','2025-05-12 11:04:44',1),(118,'admin@gmail.com','ravi@gmail.com','2025-05-13 10:25:42',1);
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_details`
--

DROP TABLE IF EXISTS `group_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_details` (
  `group_id` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(45) NOT NULL,
  `group_member_name` varchar(45) NOT NULL,
  `group_socket_id` varchar(45) NOT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_details`
--

LOCK TABLES `group_details` WRITE;
/*!40000 ALTER TABLE `group_details` DISABLE KEYS */;
INSERT INTO `group_details` VALUES (1,'admin@gmail.com-1747143901587','abhi@gmail.com','admin@gmail.com-1747143901587'),(2,'admin@gmail.com-1747143901587','ravi@gmail.com','admin@gmail.com-1747143901587'),(3,'admin@gmail.com-1747143901587','admin@gmail.com','admin@gmail.com-1747143901587'),(4,'admin@gmail.com-1747144696604','abhi@gmail.com','admin@gmail.com-1747144696604'),(5,'admin@gmail.com-1747144696604','abhi@gmail.com','admin@gmail.com-1747144696604'),(6,'admin@gmail.com-1747144696604','ravi@gmail.com','admin@gmail.com-1747144696604'),(7,'admin@gmail.com-1747144696604','admin@gmail.com','admin@gmail.com-1747144696604');
/*!40000 ALTER TABLE `group_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_tweets`
--

DROP TABLE IF EXISTS `like_tweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `like_tweets` (
  `like_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `post_id` int NOT NULL,
  `like_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_liked` tinyint DEFAULT '1',
  PRIMARY KEY (`like_id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_tweets`
--

LOCK TABLES `like_tweets` WRITE;
/*!40000 ALTER TABLE `like_tweets` DISABLE KEYS */;
INSERT INTO `like_tweets` VALUES (86,'akshay@gmail.com',7335,'2025-03-19 13:10:59',1),(87,'akshay@gmail.com',7334,'2025-03-19 13:11:00',1),(88,'akshay@gmail.com',7333,'2025-03-19 13:11:02',1),(89,'akshay@gmail.com',7332,'2025-03-19 13:11:03',1),(90,'swapnil@gmail.com',7340,'2025-03-19 13:12:28',1),(91,'swapnil@gmail.com',7339,'2025-03-19 13:12:29',1),(92,'swapnil@gmail.com',7338,'2025-03-19 13:12:30',1),(93,'swapnil@gmail.com',7337,'2025-03-19 13:12:31',1),(94,'swapnil@gmail.com',7335,'2025-03-19 13:12:32',1),(95,'swapnil@gmail.com',7336,'2025-03-19 13:12:33',1),(96,'swapnil@gmail.com',7334,'2025-03-19 13:12:35',1),(97,'abhi@gmail.com',7334,'2025-03-19 13:15:08',1),(98,'abhi@gmail.com',7335,'2025-03-19 13:15:09',1),(99,'abhi@gmail.com',7336,'2025-03-19 13:15:10',0),(100,'abhi@gmail.com',7333,'2025-03-19 13:15:11',1),(101,'abhi@gmail.com',7332,'2025-03-19 13:15:12',1),(102,'abhi@gmail.com',7339,'2025-03-19 13:15:13',1),(103,'abhi@gmail.com',7338,'2025-03-19 13:15:14',1),(104,'abhi@gmail.com',7337,'2025-03-19 13:15:15',1),(105,'abhi@gmail.com',7340,'2025-03-19 13:15:17',1),(106,'abhi@gmail.com',7342,'2025-03-19 13:15:18',1),(107,'abhi@gmail.com',7341,'2025-03-19 13:15:19',1),(108,'abhi@gmail.com',7343,'2025-03-19 13:15:20',1),(109,'abhi@gmail.com',7348,'2025-03-19 13:15:22',1),(110,'abhi@gmail.com',7349,'2025-03-19 13:15:22',1),(111,'abhi@gmail.com',7347,'2025-03-19 13:15:25',1),(112,'abhi@gmail.com',7346,'2025-03-19 13:15:26',1),(113,'arun@gmail.com',7354,'2025-03-20 13:21:16',1),(114,'akshay@gmail.com',7337,'2025-03-21 05:21:40',0),(115,'jd@gmail.com',7356,'2025-03-21 05:28:50',1),(116,'jd@gmail.com',7355,'2025-03-21 05:28:51',0),(117,'akshay@gmail.com',7356,'2025-03-21 05:29:05',0),(118,'akshay@gmail.com',7357,'2025-03-21 05:29:10',0),(119,'jd@gmail.com',7357,'2025-03-21 05:30:38',1),(120,'jd@gmail.com',7358,'2025-03-21 05:30:45',1),(121,'abhi@gmail.com',7352,'2025-03-21 06:46:05',1),(122,'abhi@gmail.com',7353,'2025-03-21 06:46:07',1),(123,'abhi@gmail.com',7351,'2025-03-21 06:46:10',1),(124,'abhi@gmail.com',7350,'2025-03-21 06:46:16',1),(125,'abhi@gmail.com',7345,'2025-03-21 06:46:18',1),(126,'abcde@gmail.com',7358,'2025-03-21 10:28:55',1),(127,'marmikshah@gmail.com',7359,'2025-03-21 13:02:47',1),(128,'marmikshah@gmail.com',7360,'2025-03-21 13:02:48',1),(129,'marmikshah@gmail.com',7358,'2025-03-21 13:02:50',1),(130,'marmikshah@gmail.com',7357,'2025-03-21 13:02:52',1),(131,'marmikshah@gmail.com',7356,'2025-03-21 13:02:53',1),(132,'marmikshah@gmail.com',7355,'2025-03-21 13:02:54',1),(133,'marmikshah@gmail.com',7354,'2025-03-21 13:02:54',1),(134,'marmikshah@gmail.com',7350,'2025-03-21 13:02:56',1),(135,'marmikshah@gmail.com',7349,'2025-03-21 13:02:57',1),(136,'marmikshah@gmail.com',7348,'2025-03-21 13:02:58',1),(137,'marmikshah@gmail.com',7347,'2025-03-21 13:02:59',1),(138,'marmikshah@gmail.com',7346,'2025-03-21 13:02:59',1),(139,'marmikshah@gmail.com',7361,'2025-03-21 13:03:21',1),(140,'marmikshah@gmail.com',7364,'2025-03-21 13:06:41',1),(141,'marmikshah@gmail.com',7363,'2025-03-21 13:06:42',1),(142,'abhi@gmail.com',7368,'2025-03-24 10:30:06',1),(143,'abhi@gmail.com',7367,'2025-03-24 10:30:57',1),(144,'abhi@gmail.com',7359,'2025-03-24 10:30:58',1),(145,'abhi@gmail.com',7370,'2025-03-24 10:49:56',1),(146,'abhi@gmail.com',7372,'2025-03-24 11:03:38',1),(147,'abhi@gmail.com',7371,'2025-03-24 11:03:39',1),(148,'abhi@gmail.com',7376,'2025-03-24 12:07:41',1),(149,'abhi@gmail.com',7377,'2025-03-24 12:07:51',1),(150,'abhi@gmail.com',7378,'2025-03-25 05:09:31',1),(151,'abhi@gmail.com',7379,'2025-04-25 05:14:57',1),(152,'abhi@gmail.com',7380,'2025-04-25 05:15:00',1);
/*!40000 ALTER TABLE `like_tweets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tweets`
--

DROP TABLE IF EXISTS `tweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tweets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tweet_created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `like_count` int DEFAULT '0',
  `is_deleted` tinyint DEFAULT '0',
  `is_retweeted` tinyint DEFAULT '0',
  `main_tweet_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7381 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tweets`
--

LOCK TABLES `tweets` WRITE;
/*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
INSERT INTO `tweets` VALUES (7376,'abhi@gmail.com','hey','2025-03-24 12:07:37',1,0,0,NULL),(7377,'abhi@gmail.com','hello','2025-03-24 12:07:48',1,0,1,7376),(7378,'abhi@gmail.com','hello from abhi!','2025-03-25 05:06:05',1,0,1,7376),(7379,'abhi@gmail.com','HII','2025-03-25 09:11:15',1,0,0,NULL),(7380,'abhi@gmail.com','hello','2025-03-25 09:18:32',1,0,0,NULL);
/*!40000 ALTER TABLE `tweets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_detail`
--

DROP TABLE IF EXISTS `user_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_detail` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `contact_no` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `user_time_zone` varchar(50) NOT NULL,
  `password` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_image` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_deleted` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_detail`
--

LOCK TABLES `user_detail` WRITE;
/*!40000 ALTER TABLE `user_detail` DISABLE KEYS */;
INSERT INTO `user_detail` VALUES (36,'admin','admin','0123456789','admin@gmail.com','Asia/Kolkata','$2b$10$62CQryleYVLuBXC0DRiEWeZhMa..P5lmY9barjkO2LQNHbVkCMsL.','2025-03-19 12:25:45','','0'),(37,'Abhishek','Mishra','9876543210','abhi@gmail.com','Asia/Kolkata','$2b$10$dd/GvaiUU1bH04RJe1ONTe7crzN28lurFBtYghJi27YqC49/XHLeq','2025-03-19 12:26:23','public/uploads/1742879156010-Untitled.png','0'),(38,'Marmik','Shah','9876543210','marmik@gmail.com','Asia/Kolkata','$2b$10$NaPP.3C57EyOOFXfhV8CV.aizUJr1cKGbaxEarLpiJj9lYj0AdFLq','2025-03-19 12:27:05','public/uploads/1742801185460-profile.png','0'),(39,'parth','rajyaguru','0123456789','parth@gmail.com','Asia/Kolkata','$2b$10$bapsn3FK6AJpX70bTCr8/e8oZJwxXJ.IMNm5RFS7xd/6PLTTPGNGS','2025-03-19 12:28:00','','0'),(40,'ravi','gosai','0123456789','ravi@gmail.com','Asia/Kolkata','$2b$10$AOfCSuWat2eNrMEl4U1ytemzk9hFJAesP8ixxLBlqKnnWGVrwmUqm','2025-03-19 12:28:36','','0'),(42,'arun','kavad','0123456789','arun@gmail.com','Asia/Kolkata','$2b$10$g6zsgaShFrrsXo/nZjYbiOS7XGdhmLxXZzGYzPZ9kSOZNDkwqHl..','2025-03-19 12:36:47','','0'),(43,'swapnil','singh','0123456789','swapnil@gmail.com','Asia/Kolkata','$2b$10$HaRaBmsJVwz1hhTzmyOCqeD3.kr9WZJ7JVwai5B3JUpb/gE25Zkjy','2025-03-19 12:50:20','','0'),(44,'dhruv','dhruv','0123456789','dhruv@gmail.com','Asia/Kolkata','$2b$10$J/J97e9LlfVrkvD7p7B06uFtzhrZHPaYjA42L.yNDstv3PHUiXwc2','2025-03-19 13:03:19','','0'),(45,'akshay','akshay','0123456789','akshay@gmail.com','Asia/Kolkata','$2b$10$xBUTSlaqTYJNx0YincloR.4xDxBhsitbUrwUkBgG1hKnAf/G1mn3S','2025-03-19 13:07:32','','0'),(46,'jaydip','khasiya','8141414895','jd@gmail.com','Pacific/Kiritimati','$2b$10$r2uUw3jgK5pVuxLrojcbxeYLB3sAgJVqwVArxE6Tb4lq89JVG.RMC','2025-03-21 05:25:42','','0'),(47,'anjali','raii','0123456789','anjali@gmail.com','Asia/Kolkata','$2b$10$55PDFiUkhigyRuvT0jaoz.H8ofZtMK9yDpfdUfVNfgUs4XV04eqQC','2025-03-21 05:34:20','','0'),(48,'parth','bhavsar','0123456789','parthb@gmail.com','Asia/Kolkata','$2b$10$RDsnbDoYmm.Wi6YlOzZJo.M3cWDvICJzDm86quH9KTX9EqWrP/YMS','2025-03-21 05:37:54','','0'),(49,'vihar ','vihar','0123456789','vihar@gmail.com','Asia/Kolkata','$2b$10$l1ehK8fdIDsvP8hUMSKgY.1ZIZX6QIIZSA3GGLY7EZIQLls0knsuS','2025-03-21 05:39:22','','0'),(50,'karan','gohel','0123456789','karan@gmail.com','Asia/Kolkata','$2b$10$2c5ILfmNfv1GT.e1Y9M2OeoVmBifV4l6qHJcDXJbcpLZqBVU8DGeu','2025-03-21 05:43:05','','0'),(51,'abhishek','abhishek','0123456789','abhishek@gmail.com','Asia/Kolkata','$2b$10$9cZgiiIHUmMJVnwSrjQrveuA1MdkboPQZlIT2LKNaF0XVT8zhH/IK','2025-03-21 05:43:56','','0'),(52,'jaydip','khasiya','8141414895','jd2@gmail.com','Asia/Calcutta','$2b$10$k54lSIajdG4iSGLauaF2hOLPMsopTLxM3K6Xb.bz9b37JzjBbXbo6','2025-03-21 05:48:52','','0'),(53,'yash','singh','0123456789','yash@gmail.com','Asia/Calcutta','$2b$10$e1eHv2Xf2FBrwA2LJoSpaerFF0VRapSpBw90TxXI9wFteGP.tUhPW','2025-03-21 05:52:55','','0'),(54,'abcd','abcd','0123456789','abcd@gmail.com','Asia/Kolkata','$2b$10$2KUPdT2f3uFPfv5cOSPRVebw9h2CribYt2FmORrILx1OejwkklidS','2025-03-21 09:51:08','public/uploads/1742550668639-user.jpg','0'),(55,'abcd','abcd','0123456789','abcde@gmail.com','Asia/Kolkata','$2b$10$EVFiLasC86dc.Sk6MGPuJOW3FtvNr3waAV0YLrUEZ2se4rIC6lZAW','2025-03-21 10:15:14','public/uploads/1742552114681-profile.jpeg','0'),(56,'abcd','abcd','0123456789','l@gmail.com','Asia/Kolkata','$2b$10$Let21L.tQ.7ehq.N5JMKLOJF58b6bzYZlQ5NNCFbXY4ySKhSCTDO2','2025-03-21 11:26:36',NULL,'0'),(58,'a','a','a','aa@gmail.com','Asia/Kolkata','$2b$10$MwTfdQAT1lRiKiBa.nyIGearogpraoVXYCDDn1FjS94eeYb2XqEg6','2025-03-21 11:38:20',NULL,'0'),(59,'keshav','sharma','0123456789','keshav@gmail.com','Asia/Kolkata','$2b$10$huRIfqA4vMNFhx1Qym53..p5ynaC3/31W39b9n.pttgixLzZ/32eG','2025-03-21 11:50:30','public/uploads/1742557830879-images.jpeg','0'),(60,'abcd','abcd','0123456789','k@gmail.com','Asia/Kolkata',NULL,'2025-03-21 11:54:34','public/uploads/1742558074817-image.png','1'),(61,'dhruv','dhruv','0123456789','dhruv1@gmail.com','Asia/Kolkata',NULL,'2025-03-21 12:02:00','public/uploads/1742558520935-images.jpeg','1'),(62,'keshav','keshav','0123456789','keshav1@gmail.com','Asia/Kolkata',NULL,'2025-03-21 12:03:17','public/uploads/1742558597147-images.jpeg','1'),(63,'aklmn','klmnb','0123456789','ak@gmail.com','Asia/Kolkata',NULL,'2025-03-21 12:05:34','public/uploads/1742558734706-image (1).png','1'),(64,'aaaa','aaaa','0123456789','aaaaa@gmail.com','Asia/Kolkata','$2b$10$/tpzVB2bDIz0TkakSgb5P.HHPrAdjetLfPqT1tOjCqoQYgU3qjytC','2025-03-21 12:22:09',NULL,'0'),(65,'kkkk','kkkk','0123456789','kkkk@gmail.com','Asia/Kolkata',NULL,'2025-03-21 12:25:40',NULL,'1'),(66,'llll','llll','0123456789','llll@gmail.com','Asia/Kolkata','$2b$10$g5IAxqihFGYMC86wwS7iMu/Q4Pmwybn3E4HfaW9Vf8KhsXbYpwtQm','2025-03-21 12:26:24','public/uploads/1742559984867-profile3.png','0'),(67,'nnnn','nnnn','0123456789','nnnn@gmail.com','Asia/Kolkata','$2b$10$P1ZjKnAnj9bc491og5kaJeck1XZq4OXTzwxjTGzC1NIdYPmV9Qefy','2025-03-21 12:28:39','public/uploads/1742560119934-profile.png','0'),(68,'akhilesh','yadav','0123456789','akhilesh@gmail.com','Asia/Kolkata','$2b$10$89m66sldqeGJao0KvwGlz.HvWlBZOHS8Wz6lYIVFsKlh6XRX90Tka','2025-03-21 12:58:00','public/uploads/1742561880578-profile.png','0'),(69,'marmik','shah','1234567890','marmikshah@gmail.com','Asia/Kolkata','$2b$10$BaWjrWVTm7WqjTdf1Iryv.i483W3HIy81AFM7h5WvzSEpKsjHq3wW','2025-03-21 13:01:54',NULL,'0');
/*!40000 ALTER TABLE `user_detail` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-14 18:23:56
