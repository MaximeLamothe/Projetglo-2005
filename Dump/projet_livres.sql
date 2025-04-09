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
-- Table structure for table `livres`
--

DROP TABLE IF EXISTS `livres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livres` (
  `lid` int NOT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `genre` varchar(50) NOT NULL,
  `annee` int DEFAULT NULL,
  `maison_edition` varchar(255) DEFAULT NULL,
  `couverture` varchar(50) DEFAULT NULL,
  `nombre_de_pages` int DEFAULT NULL,
  `note` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`lid`),
  KEY `Titre` (`titre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livres`
--

LOCK TABLES `livres` WRITE;
/*!40000 ALTER TABLE `livres` DISABLE KEYS */;
INSERT INTO `livres` VALUES (1,'Les Misérables','Roman',1862,'Gallimard','l1.jpg',1232,4.00),(2,'Le Tour du monde en 80 jours','Aventure',1873,'Hachette','l2.jpg',320,1.00),(3,'1984','Dystopie',1949,'Secker & Warburg','l3.jpg',328,NULL),(4,'Pride and Prejudice','Romance',1813,'T. Egerton','l4.jpg',432,NULL),(5,'Notre-Dame de Paris','Roman',1831,'Librairie Gosselin','l5.jpg',940,NULL),(6,'Vingt Mille Lieues sous les mers','Science-fiction',1870,'Pierre-Jules Hetzel','l6.jpg',672,NULL),(7,'L\'Étranger','Philosophique',1942,'Gallimard','l7.jpg',185,NULL),(8,'La Peste','Philosophique',1947,'Gallimard','l8.jpg',320,NULL),(9,'Du côté de chez Swann','Roman',1913,'Grasset','l9.jpg',468,NULL),(10,'À l\'ombre des jeunes filles en fleurs','Roman',1919,'Gallimard','l10.jpg',523,NULL),(11,'Germinal','Roman',1885,'Charpentier','l11.jpg',592,NULL),(12,'L\'Assommoir','Roman',1877,'Charpentier','l12.jpg',480,NULL),(13,'Nana','Roman',1880,'Charpentier','l13.jpg',452,NULL),(14,'Le Deuxième Sexe','Essai',1949,'Gallimard','l14.jpg',1012,NULL),(15,'Mémoires d\'une jeune fille rangée','Autobiographie',1958,'Gallimard','l15.jpg',384,4.00),(16,'La Nausée','Roman',1938,'Gallimard','l16.jpg',253,NULL),(17,'Les Mots','Autobiographie',1964,'Gallimard','l17.jpg',160,NULL),(18,'Le Petit Prince','Conte',1943,'Gallimard','l18.jpg',96,NULL),(19,'Vol de nuit','Roman',1931,'Gallimard','l19.jpg',180,NULL),(20,'Crime et Châtiment','Psychologique',1866,'Gallimard','l20.jpg',430,NULL),(21,'Les Frères Karamazov','Philosophique',1880,'Gallimard','l21.jpg',766,NULL),(22,'Guerre et Paix','Historique',1869,'Penguin','l22.jpg',1225,NULL),(23,'Anna Karénine','Historique',1877,'Penguin','l23.jpg',864,NULL),(24,'Le Procès','Roman',1914,'Gallimard','l24.jpg',250,NULL),(25,'La Métamorphose','Roman',1915,'Gallimard','l25.jpg',103,NULL),(26,'Moby Dick','Aventure',1851,'Penguin','l26.jpg',585,NULL),(27,'Oliver Twist','Historique',1837,'Penguin','l27.jpg',296,NULL),(28,'Mrs. Dalloway','Roman',1925,'Harcourt','l28.jpg',240,NULL),(29,'Les Machine à Explorer le Temps','Science-fiction',1895,'Heinemann','l29.jpg',96,NULL),(30,'Bilbo le Hobbit','Fantasy',1937,'HarperCollins','l30.jpg',310,NULL),(31,'Les Aventures de Huckleberry Finn','Aventure',1885,'Chatto & Windus','l31.jpg',366,NULL),(32,'Le Portrait de Dorian Gray','Roman',1890,'Penguin','l32.jpg',200,NULL),(33,'Le Bossu de Notre-Dame','Roman',1831,'Librairie Gosselin','l33.jpg',940,NULL),(34,'La Maison aux Esprits','Magie Réaliste',1982,'Penguin','l34.jpg',500,NULL),(35,'Le Maître et Marguerite','Roman',1967,'Penguin','l35.jpg',496,NULL),(36,'Relativity','Essai',1916,'Princeton','l36.jpg',160,NULL),(37,'Les Raisins de la Colère','Roman',1939,'Penguin','l37.jpg',464,NULL),(38,'Le Vieil Homme et la Mer','Roman',1952,'Scribner','l38.jpg',127,NULL),(39,'Absalom, Absalom!','Roman',1936,'Penguin','l39.jpg',315,NULL),(40,'Le Docteur Jivago','Poésie',1957,'Penguin','l40.jpg',704,NULL),(41,'Les Aventures de Sherlock Holmes','Policier',1892,'Penguin','l41.jpg',302,NULL),(42,'Fahrenheit 451','Science-fiction',1953,'Ballantine','l42.jpg',158,NULL),(43,'Brave New World','Dystopie',1932,'Chatto & Windus','l43.jpg',311,NULL),(44,'Middlemarch','Roman',1871,'Penguin','l44.jpg',800,NULL),(45,'Le Meurtre de Roger Ackroyd','Polar',1926,'William Collins & Sons','l45.jpg',300,NULL),(46,'American Gods','Fantasy',2001,'Morrow','l46.jpg',635,NULL),(47,'Le Crime de l’Orient-Express','Policier',1934,'Collins Crime','l47.jpg',250,NULL),(48,'Les Vacances d\'Hercule Poirot','Polar',1928,'Collins Crime Club','l48.jpg',320,NULL),(49,'Le Meilleur des Mondes','Dystopie',1932,'Chatto & Windus','l49.jpg',311,NULL),(50,'Silas Marner','Roman',1861,'Blackwood','l50.jpg',304,NULL),(51,'Hamlet','Théâtre',1600,'Penguin Classics','l51.jpg',200,NULL),(52,'Macbeth','Théâtre',1606,'Penguin Classics','l52.jpg',250,NULL),(53,'Divine Comédie','Poésie',1320,'Le Livre de Poche','l53.jpg',800,NULL),(54,'Cent ans de solitude','Roman',1967,'Editions Grasset','l54.jpg',417,NULL),(55,'L’Appel de la forêt','Aventure',1903,'Macmillan','l55.jpg',300,NULL),(56,'Croc-Blanc','Aventure',1906,'Macmillan','l56.jpg',250,NULL),(57,'Tess d’Urberville','Drame',1891,'HarperCollins','l57.jpg',380,NULL),(58,'Beloved','Roman',1987,'Alfred A. Knopf','l58.jpg',275,NULL),(59,'Sons and Lovers','Roman',1913,'Gerald Duckworth & Co.','l59.jpg',380,NULL),(60,'Invisible Man','Roman',1952,'Random House','l60.jpg',581,NULL),(61,'Madame Bovary','Roman',1857,'Garnier','l61.jpg',500,NULL),(62,'Les Brigands','Théâtre',1781,'Reclam Verlag','l62.jpg',192,NULL),(63,'The Crucible','Théâtre',1953,'Viking Press','l63.jpg',150,NULL),(64,'L’Étranger','Roman',1942,'Gallimard','l64.jpg',150,NULL),(65,'Portnoy’s Complaint','Roman',1969,'Random House','l65.jpg',275,NULL),(66,'La Servante écarlate','Science-fiction',1985,'McClelland and Stewart','l66.jpg',311,NULL),(67,'Pride and Prejudice','Romance',1813,'T. Egerton','l67.jpg',432,NULL),(68,'Sense and Sensibility','Romance',1811,'T. Egerton','l68.jpg',380,NULL),(69,'Ulysses','Roman',1922,'Sylvia Beach','l69.jpg',732,NULL),(70,'Slaughterhouse-Five','Science-fiction',1969,'Delacorte Press','l70.jpg',275,NULL),(71,'A Streetcar Named Desire','Théâtre',1947,'New Directions','l71.jpg',125,NULL),(72,'La Nausée','Philosophique',1938,'Gallimard','l72.jpg',260,NULL),(73,'Les Mots','Autobiographie',1964,'Gallimard','l73.jpg',400,NULL),(74,'Les Chemins de la Liberté','Philosophique',1945,'Gallimard','l74.jpg',500,NULL),(75,'Tropic of Cancer','Roman',1934,'Obelisk Press','l75.jpg',315,NULL),(76,'La République','Philosophie',-380,'Athènes Classiques','l76.jpg',480,NULL),(77,'Le Banquet','Philosophie',-385,'Athènes Classiques','l77.jpg',240,NULL),(78,'Mémoires d\'Hadrien','Historique',1951,'Plon','l78.jpg',370,NULL),(79,'Sur la route','Roman',1957,'Viking Press','l79.jpg',320,NULL),(80,'Kafka sur le rivage','Fantastique',2002,'Shinchosha','l80.jpg',505,NULL),(81,'The Bell Jar','Roman',1963,'Heinemann','l81.jpg',288,NULL),(82,'Harry Potter à l\'école des sorciers','Fantasy',1997,'Bloomsbury','l82.jpg',352,NULL),(83,'The Golden Notebook','Roman',1962,'Michael Joseph','l83.jpg',576,NULL),(84,'A Passage to India','Historique',1924,'Edward Arnold','l84.jpg',368,NULL),(85,'Fondation','Science-fiction',1951,'Gnome Press','l85.jpg',255,NULL),(86,'Ubik','Science-fiction',1969,'Doubleday','l86.jpg',216,NULL),(87,'Americanah','Roman',2013,'Knopf','l87.jpg',588,NULL),(88,'The Waste Land','Poésie',1922,'Faber & Faber','l88.jpg',64,NULL),(89,'Lord of the Flies','Dystopie',1954,'Faber & Faber','l89.jpg',224,NULL),(90,'The Garden Party','Nouvelles',1922,'Constable & Co.','l90.jpg',192,NULL),(91,'Atonement','Roman',2001,'Jonathan Cape','l91.jpg',371,NULL),(92,'Fight Club','Satire',1996,'W. W. Norton','l92.jpg',208,NULL),(93,'Blonde','Biographique',2000,'Ecco','l93.jpg',752,NULL),(94,'The Amazing Adventures of Kavalier & Clay','Roman',2000,'Random House','l94.jpg',639,NULL),(95,'The Underground Railroad','Historique',2016,'Doubleday','l95.jpg',320,NULL),(96,'Cloud Atlas','Roman',2004,'Sceptre','l96.jpg',528,NULL),(97,'But What If We’re Wrong?','Essai',2016,'Blue Rider Press','l97.jpg',288,NULL),(98,'The Lightning Thief','Fantasy jeunesse',2005,'Disney Hyperion','l98.jpg',377,NULL),(99,'Normal People','Roman contemporain',2018,'Faber & Faber','l99.jpg',273,NULL),(100,'The Year of Magical Thinking','Mémoires',2005,'Knopf','l100.jpg',227,NULL),(101,'Big Little Lies','Roman policier',2014,'Penguin','l101.jpg',460,NULL),(102,'The Shining','Horreur',1977,'Doubleday','l102.jpg',447,NULL),(103,'It','Horreur',1986,'Viking','l103.jpg',1138,NULL),(104,'Misery','Thriller psychologique',1987,'Viking','l104.jpg',320,NULL),(105,'The Woman in Cabin 10','Thriller',2016,'Gallery Books','l105.jpg',340,NULL),(106,'Casino Royale','Espionnage',1953,'Jonathan Cape','l106.jpg',213,NULL),(107,'Killing Floor','Thriller',1997,'Putnam','l107.jpg',524,NULL),(108,'To Kill a Mockingbird','Roman',1960,'J.B. Lippincott & Co.','l108.jpg',281,NULL),(109,'The Stranger','Thriller',2015,'Dutton','l109.jpg',400,NULL),(110,'Postmortem','Policier',1990,'Charles Scribner\'s Sons','l110.jpg',342,NULL),(111,'My Sister\'s Keeper','Roman',2004,'Atria Books','l111.jpg',432,NULL),(112,'The Da Vinci Code','Thriller ésotérique',2003,'Doubleday','l112.jpg',689,NULL),(113,'The Exorcist','Horreur',1971,'Harper & Row','l113.jpg',340,NULL),(114,'Lolita','Roman',1955,'Olympia Press','l114.jpg',336,NULL),(115,'Rebecca','Roman gothique',1938,'Gollancz','l115.jpg',448,NULL),(116,'Climate and Culture','Philosophie',1935,'Iwanami Shoten','l116.jpg',250,NULL),(117,'Ethics','Philosophie',1937,'Iwanami Shoten','l117.jpg',320,NULL),(118,'Beautiful Losers','Poésie',1966,'McClelland and Stewart','l118.jpg',243,NULL),(119,'Nègres blancs d\'Amérique','Essai',1968,'Parti pris','l119.jpg',310,NULL),(125,'A Doll\'s House','Philosophie',1920,'Actes Sud','l125.jpg',491,NULL),(126,'Hedda Gabler','Essai',1979,'Flammarion','l126.jpg',123,NULL),(127,'Ficciones','Théâtre',1954,'Penguin Books','l127.jpg',539,NULL),(128,'Le Chemin montant','Poésie',1990,'Gallimard','l128.jpg',320,NULL),(129,'Les Écrits (Poèmes)','Poésie',1980,'Seuil','l129.jpg',180,NULL),(130,'Léo et les presqu’îles','Roman',1995,'Flammarion','l130.jpg',250,NULL),(131,'Philosophy as Metanoetics','Philosophie',1960,'Actes Sud','l131.jpg',343,NULL),(132,'Les Belles-Soeurs','Théâtre',1972,'Seuil','l132.jpg',224,NULL),(133,'Zen no Kenkyū','Philosophie',1935,'Penguin Books','l133.jpg',347,NULL),(134,'Maria Chapdelaine','Roman',1940,'Gallimard','l134.jpg',402,NULL),(135,'Atlas Shrugged','Roman',1957,'Flammarion','l135.jpg',598,NULL),(136,'En attendant Godot','Théâtre',1961,'Seuil','l136.jpg',222,NULL),(137,'Juliette Pomerleau','Roman',1987,'Actes Sud','l137.jpg',489,NULL),(138,'Charles le Téméraire','Roman',1990,'Gallimard','l138.jpg',583,NULL);
/*!40000 ALTER TABLE `livres` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_auteur_note` AFTER UPDATE ON `livres` FOR EACH ROW UPDATE auteurs A
SET A.note = (
    SELECT IFNULL(AVG(L.note), 0)
    FROM livres L
    JOIN ecrire E ON L.lid = E.idlivre
    WHERE E.idauteur = A.aid
)
WHERE A.aid IN (
    SELECT E.idauteur
    FROM ecrire E
    WHERE E.idlivre = NEW.lid
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-08 22:42:32
