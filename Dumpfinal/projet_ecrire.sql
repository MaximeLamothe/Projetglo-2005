-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: projet
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `ecrire`
--

DROP TABLE IF EXISTS `ecrire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ecrire` (
  `idauteur` int NOT NULL,
  `idlivre` int NOT NULL,
  PRIMARY KEY (`idauteur`,`idlivre`),
  KEY `idlivre` (`idlivre`),
  KEY `ecrire` (`idauteur`,`idlivre`),
  CONSTRAINT `ecrire_ibfk_1` FOREIGN KEY (`idauteur`) REFERENCES `auteurs` (`aid`) ON DELETE CASCADE,
  CONSTRAINT `ecrire_ibfk_2` FOREIGN KEY (`idlivre`) REFERENCES `livres` (`lid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ecrire`
--

LOCK TABLES `ecrire` WRITE;
/*!40000 ALTER TABLE `ecrire` DISABLE KEYS */;
INSERT INTO `ecrire` VALUES (1,1),(2,2),(3,3),(4,4),(1,5),(2,6),(5,7),(5,8),(6,9),(6,10),(7,11),(7,12),(7,13),(8,14),(8,15),(9,16),(9,17),(10,18),(10,19),(11,20),(11,21),(12,22),(12,23),(13,24),(13,25),(14,26),(15,27),(16,28),(17,29),(18,30),(19,31),(38,32),(1,33),(51,34),(23,35),(24,36),(25,37),(26,38),(27,39),(28,40),(52,41),(48,42),(49,43),(50,44),(47,45),(46,46),(47,47),(47,48),(49,49),(50,50),(20,51),(20,52),(21,53),(22,54),(29,55),(29,56),(31,57),(32,58),(33,59),(34,60),(35,61),(36,62),(37,63),(9,64),(40,65),(41,66),(4,67),(4,68),(43,69),(44,70),(45,71),(9,72),(9,73),(9,74),(30,75),(39,76),(39,77),(42,78),(53,79),(54,80),(55,81),(56,82),(57,83),(58,84),(59,85),(60,86),(61,87),(62,88),(63,89),(64,90),(65,91),(66,92),(67,93),(68,94),(69,95),(70,96),(71,97),(72,98),(73,99),(74,100),(75,101),(76,102),(76,103),(76,104),(77,105),(78,106),(79,107),(80,108),(81,109),(82,110),(83,111),(84,112),(85,113),(86,114),(87,115),(88,116),(88,117),(89,118),(90,119),(91,125),(91,126),(92,127),(93,128),(93,129),(94,130),(94,131),(95,132),(96,133),(97,134),(98,135),(99,136),(100,137),(100,138);
/*!40000 ALTER TABLE `ecrire` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-08  0:43:09
