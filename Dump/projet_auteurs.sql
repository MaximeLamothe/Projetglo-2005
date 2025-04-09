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
  `photo` varchar(50) DEFAULT NULL,
  `note` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`aid`),
  KEY `nomAuteurs` (`nom`,`prenom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auteurs`
--

LOCK TABLES `auteurs` WRITE;
/*!40000 ALTER TABLE `auteurs` DISABLE KEYS */;
INSERT INTO `auteurs` VALUES (1,'Victor','Hugo','VHugo','Roman','a1.jpg',4.00),(2,'Jules','Verne','JVerne','Science-fiction','a2.jpg',1.00),(3,'George','Orwell','GOrwell','Dystopie','a3.jpg',0.00),(4,'Jane','Austen','JAusten','Romance','a4.jpg',0.00),(5,'Albert','Camus','ACamus','Philosophique','a5.jpg',NULL),(6,'Marcel','Proust','MProus','Roman','a6.jpg',NULL),(7,'Émile','Zola','EZola','Naturaliste','a7.jpg',NULL),(8,'Simone','de Beauvoir','SdeBea','Philosophie','a8.jpg',4.00),(9,'Jean-Paul','Sartre','JPSart','Philosophie','a9.jpg',NULL),(10,'Antoine','de Saint-Exupéry','AStExu','Aventure','a10.jpg',NULL),(11,'Fyodor','Dostoevsky','FDosto','Psychologique','a11.jpg',NULL),(12,'Leo','Tolstoy','LTolst','Historique','a12.jpg',NULL),(13,'Franz','Kafka','FKafka','Roman','a13.jpg',NULL),(14,'Herman','Melville','HMellv','Aventure','a14.jpg',NULL),(15,'Charles','Dickens','CDicke','Historique','a15.jpg',NULL),(16,'Virginia','Woolf','VWoolf','Roman','a16.jpg',NULL),(17,'H.G.','Wells','HGWells','Science-fiction','a17.jpg',NULL),(18,'J.R.R.','Tolkien','JRTolk','Fantasy','a18.jpg',NULL),(19,'Mark','Twain','MTwain','Aventure','a19.jpg',NULL),(20,'William','Shakespeare','WShakes','Théâtre','a20.jpg',NULL),(21,'Dante','Alighieri','DAligh','Poésie','a21.jpg',NULL),(22,'Gabriel','Garcia Marquez','GGMarq','Magie Réaliste','a22.jpg',NULL),(23,'Mikhail','Bulgakov','MBulga','Roman','a23.jpg',NULL),(24,'Albert','Einstein','AEinst','Essai','a24.jpg',NULL),(25,'John','Steinbeck','JStein','Roman','a25.jpg',NULL),(26,'Ernest','Hemingway','EHem','Roman','a26.jpg',NULL),(27,'William','Faulkner','WFaulkn','Roman','a27.jpg',NULL),(28,'Boris','Pasternak','BPaste','Poésie','a28.jpg',NULL),(29,'Jack','London','JLondon','Aventure','a29.jpg',NULL),(30,'Henry','Miller','HMille','Roman','a30.jpg',NULL),(31,'Thomas','Hardy','THardy','Historique','a31.jpg',NULL),(32,'Toni','Morrison','TMorri','Roman','a32.jpg',NULL),(33,'D.H.','Lawrence','DHLawr','Roman','a33.jpg',NULL),(34,'Ralph','Ellison','REllis','Roman','a34.jpg',NULL),(35,'Gustave','Flaubert','GFlaub','Roman','a35.jpg',NULL),(36,'Frédéric','Schiller','FSchill','Théâtre','a36.jpg',0.00),(37,'Arthur','Miller','AMille','Théâtre','a37.jpg',NULL),(38,'Oscar','Wilde','OWilde','Théâtre','a38.jpg',NULL),(39,'Platon','','Platon','Philosophie','a39.jpg',NULL),(40,'Philip','Roth','PRoth','Roman','a40.jpg',NULL),(41,'Margaret','Atwood','MAtwoo','Roman','a41.jpg',NULL),(42,'Marguerite','Yourcenar','MYourcenar','Roman','a42.jpg',NULL),(43,'James','Joyce','JJoyce','Roman','a43.jpg',NULL),(44,'Kurt','Vonnegut','KVonne','Satire','a44.jpg',NULL),(45,'Tennessee','Williams','TWillia','Théâtre','a45.jpg',NULL),(46,'Neil','Gaiman','NGaiman','Fantasy','a46.jpg',NULL),(47,'Agatha','Christie','AChris','Policier','a47.jpg',NULL),(48,'Ray','Bradbury','RBradb','Science-fiction','a48.jpg',NULL),(49,'Aldous','Huxley','AHuxle','Dystopie','a49.jpg',NULL),(50,'George','Eliot','GEliot','Roman','a50.jpg',NULL),(51,'Isabel','Allende','IAllende','Roman','a51.jpg',NULL),(52,'Arthur','Conan Doyle','AConanDoyle','Polar','a52.jpg',NULL),(53,'Jack','Kerouac','JKerouac','Roman','a53.jpg',NULL),(54,'Haruki','Murakami','HMurakami','Roman','a54.jpg',NULL),(55,'Sylvia','Plath','SPlath','Poésie','a55.jpg',NULL),(56,'J.K.','Rowling','JKRowling','Fantasy','a56.jpg',NULL),(57,'Doris','Lessing','DLessing','Roman','a57.jpg',NULL),(58,'E.M.','Forster','EMForster','Roman','a58.jpg',NULL),(59,'Isaac','Asimov','IAsimov','Science-fiction','a59.jpg',NULL),(60,'Philip','K. Dick','PKDick','Science-fiction','a60.jpg',NULL),(61,'Chimamanda','Ngozi Adichie','CAdichie','Roman','a61.jpg',NULL),(62,'T.S.','Eliot','TSEliot','Poésie','a62.jpg',NULL),(63,'William','Golding','WGolding','Roman','a63.jpg',NULL),(64,'Katherine','Mansfield','KMansfield','Roman','a64.jpg',NULL),(65,'Ian','McEwan','IMcEwan','Roman','a65.jpg',NULL),(66,'Chuck','Palahniuk','CPalahniuk','Roman','a66.jpg',NULL),(67,'Joyce','Carol Oates','JCOates','Roman','a67.jpg',NULL),(68,'Michael','Chabon','MChabon','Roman','a68.jpg',NULL),(69,'Colson','Whitehead','CWhitehead','Roman','a69.jpg',NULL),(70,'David','Mitchell','DMitchell','Roman','a70.jpg',NULL),(71,'Chuck','Klosterman','CKlosterman','Roman','a71.jpg',NULL),(72,'Rick','Riordan','RRiordan','Fantasy','a72.jpg',NULL),(73,'Sally','Rooney','SRooney','Roman','a73.jpg',NULL),(74,'Joan','Didion','JDidion','Roman','a74.jpg',NULL),(75,'Liane','Moriarty','LMoriarty','Roman','a75.jpg',NULL),(76,'Stephen','King','SKing','Horreur','a76.jpg',NULL),(77,'Ruth','Ware','RWare','Policier','a77.jpg',NULL),(78,'Ian','Fleming','IFleming','Polar','a78.jpg',NULL),(79,'Lee','Child','LChild','Polar','a79.jpg',NULL),(80,'Harper','Lee','HLee','Roman','a80.jpg',NULL),(81,'Harlan','Coben','HCoben','Polar','a81.jpg',NULL),(82,'Patricia','Cornwell','PCornwell','Policier','a82.jpg',NULL),(83,'Jodi','Picoult','JPicoult','Roman','a83.jpg',NULL),(84,'Dan','Brown','DBrown','Polar','a84.jpg',NULL),(85,'William','Peter Blatty','WPBlatty','Horreur','a85.jpg',NULL),(86,'Vladimir','Nabokov','VNabokov','Roman','a86.jpg',NULL),(87,'Daphne','Du Maurier','DDuMaurier','Roman','a87.jpg',NULL),(88,'Tetsuro','Watsuji','TWatsuji','Philosophie','a88.jpg',NULL),(89,'Leonard','Cohen','LCohen','Poésie','a89.jpg',NULL),(90,'Pierre','Vallière','PValliere','Poésie','a90.jpg',NULL),(91,'Henrik','Ibsen','HIbsen','Théâtre','a91.jpg',NULL),(92,'Jorge','Luis Borges','JLBorges','Littérature','a92.jpg',NULL),(93,'Gilles','Vigneault','GVigneault','Poésie','a93.jpg',0.00),(94,'Hajime','Tanabe','HTanabe','Philosophie','a94.jpg',0.00),(95,'Michel','Tremblay','MTremblay','Roman','a95.jpg',NULL),(96,'Kitaro','Nishida','KNishida','Philosophie','a96.jpg',NULL),(97,'Louis','Hémon','LHemon','Roman','a97.jpg',NULL),(98,'Ayn','Rand','ARand','Philosophie','a98.jpg',NULL),(99,'Samuel','Beckett','SBeckett','Théâtre','a99.jpg',NULL),(100,'Yves','Beauchemin','YBeauch','Roman','a100.jpg',NULL);
/*!40000 ALTER TABLE `auteurs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-09 18:57:59
