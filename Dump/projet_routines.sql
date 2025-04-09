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
-- Dumping routines for database 'projet'
--
/*!50003 DROP PROCEDURE IF EXISTS `Recherchelivre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Recherchelivre`(IN motCle VARCHAR(100))
BEGIN
  SELECT 
	CONCAT(a.prenom, ' ', a.nom) AS Nomauteur,
    l.titre,
    l.note
  FROM Auteurs a
  JOIN ecrire e ON a.aid = e.idauteur
  JOIN Livres l ON e.idlivre = l.lid
     WHERE CONCAT(a.prenom, ' ', a.nom) LIKE CONCAT('%', motCle, '%')
	 OR a.surnom LIKE CONCAT('%', motCle, '%')
     OR l.titre LIKE CONCAT('%', motCle, '%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Recherchenote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Recherchenote`(
    IN notemin DECIMAL(3, 2)
)
BEGIN

    SELECT 
        CONCAT(a.prenom, ' ', a.nom) AS Nom, 
        a.note AS Note_auteur, 
        NULL AS Note_livre
    FROM Auteurs a
    WHERE a.note >= notemin
    UNION ALL
    SELECT 
        l.titre AS Titre, 
        NULL AS Note_auteur, 
        l.note AS Note_livre
    FROM Livres l
    WHERE l.note > notemin;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Recherchepargenre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Recherchepargenre`(
    IN critere VARCHAR(100)
)
BEGIN
    IF EXISTS (SELECT 1 FROM Livres WHERE genre LIKE CONCAT('%', critere, '%')) THEN
        SELECT 
            l.titre AS Titre,
            l.genre AS Genre
        FROM Livres l
        WHERE l.genre LIKE CONCAT('%', critere, '%');
    END IF;

    IF EXISTS (SELECT 1 FROM Auteurs WHERE specialite LIKE CONCAT('%', critere, '%')) THEN
        SELECT 
            NULL AS Titre,
            NULL AS Genre,
            CONCAT(a.prenom, ' ', a.nom) AS auteur_nom_complet
        FROM Auteurs a
        WHERE a.specialite LIKE CONCAT('%', critere, '%');
    END IF;

    IF EXISTS (SELECT 1 FROM Livres l JOIN ecrire e ON l.lid = e.idlivre JOIN Auteurs a ON e.idauteur = a.aid WHERE l.genre LIKE CONCAT('%', critere, '%') AND a.specialite LIKE CONCAT('%', critere, '%')) THEN
        SELECT 
            l.titre AS Titre,
            l.genre AS Genre,
            CONCAT(a.prenom, ' ', a.nom) AS Nomauteur
        FROM Livres l
        JOIN ecrire e ON l.lid = e.idlivre
        JOIN Auteurs a ON e.idauteur = a.aid
        WHERE l.genre LIKE CONCAT('%', critere, '%')
          AND a.specialite LIKE CONCAT('%', critere, '%');
    END IF;
END ;;
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
