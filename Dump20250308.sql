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
-- Table structure for table `auteurs`
--

DROP TABLE IF EXISTS `auteurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auteurs` (
  `aid` int NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `surnom` varchar(50) NOT NULL,
  `specialite` varchar(50) NOT NULL,
  `note` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auteurs`
--

LOCK TABLES `auteurs` WRITE;
/*!40000 ALTER TABLE `auteurs` DISABLE KEYS */;
/*!40000 ALTER TABLE `auteurs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commentaires`
--

DROP TABLE IF EXISTS `commentaires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commentaires` (
  `cid` int NOT NULL,
  `idlecteur` int DEFAULT NULL,
  `idlivre` int DEFAULT NULL,
  `contenu` varchar(200) NOT NULL,
  PRIMARY KEY (`cid`),
  KEY `idlecteur` (`idlecteur`),
  KEY `idlivre` (`idlivre`),
  CONSTRAINT `commentaires_ibfk_1` FOREIGN KEY (`idlecteur`) REFERENCES `lecteurs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commentaires_ibfk_2` FOREIGN KEY (`idlivre`) REFERENCES `livres` (`lid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentaires`
--

LOCK TABLES `commentaires` WRITE;
/*!40000 ALTER TABLE `commentaires` DISABLE KEYS */;
/*!40000 ALTER TABLE `commentaires` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commenter`
--

DROP TABLE IF EXISTS `commenter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commenter` (
  `idlecteur` int NOT NULL,
  `idlivre` int NOT NULL,
  `idcommentaire` int NOT NULL,
  PRIMARY KEY (`idlecteur`,`idlivre`,`idcommentaire`),
  KEY `idlivre` (`idlivre`),
  KEY `idcommentaire` (`idcommentaire`),
  CONSTRAINT `commenter_ibfk_1` FOREIGN KEY (`idlecteur`) REFERENCES `lecteurs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commenter_ibfk_2` FOREIGN KEY (`idlivre`) REFERENCES `livres` (`lid`) ON DELETE CASCADE,
  CONSTRAINT `commenter_ibfk_3` FOREIGN KEY (`idcommentaire`) REFERENCES `commentaires` (`cid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commenter`
--

LOCK TABLES `commenter` WRITE;
/*!40000 ALTER TABLE `commenter` DISABLE KEYS */;
/*!40000 ALTER TABLE `commenter` ENABLE KEYS */;
UNLOCK TABLES;

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
  CONSTRAINT `ecrire_ibfk_1` FOREIGN KEY (`idauteur`) REFERENCES `auteurs` (`aid`) ON DELETE CASCADE,
  CONSTRAINT `ecrire_ibfk_2` FOREIGN KEY (`idlivre`) REFERENCES `livres` (`lid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ecrire`
--

LOCK TABLES `ecrire` WRITE;
/*!40000 ALTER TABLE `ecrire` DISABLE KEYS */;
/*!40000 ALTER TABLE `ecrire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecteurs`
--

DROP TABLE IF EXISTS `lecteurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecteurs` (
  `id` int NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `surnom` varchar(50) NOT NULL,
  `age` int DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `motdepasse` varchar(50) NOT NULL,
  `nombrelivreslus` int DEFAULT NULL,
  `sexe` enum('homme','femme','autre') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecteurs`
--

LOCK TABLES `lecteurs` WRITE;
/*!40000 ALTER TABLE `lecteurs` DISABLE KEYS */;
/*!40000 ALTER TABLE `lecteurs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lire`
--

DROP TABLE IF EXISTS `lire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lire` (
  `idlecteur` int NOT NULL,
  `idlivre` int NOT NULL,
  `statut` enum('à lire','en cours','lu') NOT NULL DEFAULT 'à lire',
  PRIMARY KEY (`idlecteur`,`idlivre`),
  KEY `idlivre` (`idlivre`),
  CONSTRAINT `lire_ibfk_1` FOREIGN KEY (`idlecteur`) REFERENCES `lecteurs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lire_ibfk_2` FOREIGN KEY (`idlivre`) REFERENCES `livres` (`lid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lire`
--

LOCK TABLES `lire` WRITE;
/*!40000 ALTER TABLE `lire` DISABLE KEYS */;
/*!40000 ALTER TABLE `lire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livres`
--

DROP TABLE IF EXISTS `livres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livres` (
  `lid` int NOT NULL,
  `titre` varchar(50) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `annee` int DEFAULT NULL,
  `maison_edition` varchar(50) DEFAULT NULL,
  `nombre_de_pages` int DEFAULT NULL,
  `note` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livres`
--

LOCK TABLES `livres` WRITE;
/*!40000 ALTER TABLE `livres` DISABLE KEYS */;
/*!40000 ALTER TABLE `livres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `noter`
--

DROP TABLE IF EXISTS `noter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `noter` (
  `idlecteur` int NOT NULL,
  `idlivre` int NOT NULL,
  `note` int DEFAULT NULL,
  PRIMARY KEY (`idlecteur`,`idlivre`),
  KEY `idlivre` (`idlivre`),
  CONSTRAINT `noter_ibfk_1` FOREIGN KEY (`idlecteur`) REFERENCES `lecteurs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `noter_ibfk_2` FOREIGN KEY (`idlivre`) REFERENCES `livres` (`lid`) ON DELETE CASCADE,
  CONSTRAINT `noter_chk_1` CHECK ((`note` between 1 and 10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `noter`
--

LOCK TABLES `noter` WRITE;
/*!40000 ALTER TABLE `noter` DISABLE KEYS */;
/*!40000 ALTER TABLE `noter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repondre`
--

DROP TABLE IF EXISTS `repondre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repondre` (
  `idcommentaireparent` int NOT NULL,
  `idcommentairereponse` int NOT NULL,
  PRIMARY KEY (`idcommentaireparent`,`idcommentairereponse`),
  KEY `idcommentairereponse` (`idcommentairereponse`),
  CONSTRAINT `repondre_ibfk_1` FOREIGN KEY (`idcommentaireparent`) REFERENCES `commentaires` (`cid`) ON DELETE CASCADE,
  CONSTRAINT `repondre_ibfk_2` FOREIGN KEY (`idcommentairereponse`) REFERENCES `commentaires` (`cid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repondre`
--

LOCK TABLES `repondre` WRITE;
/*!40000 ALTER TABLE `repondre` DISABLE KEYS */;
/*!40000 ALTER TABLE `repondre` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-08 23:57:46
