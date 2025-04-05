DELIMITER //

CREATE PROCEDURE Recherchelivre(IN motCle VARCHAR(100))
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
END //

DELIMITER ;



DELIMITER //
CREATE PROCEDURE Recherchepargenre(
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
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE Recherchenote(
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
    
END //
DELIMITER ;

CREATE INDEX ecrire ON ecrire (idauteur, idlivre);
CREATE INDEX lire ON lire (idlecteur, idlivre);
CREATE INDEX nomAuteur ON Auteurs (nom, prenom);
CREATE INDEX Titre ON Livres (titre);
CREATE INDEX commentaires ON Commenter (idlivre, idlecteur);
CREATE INDEX lirearbre USING BTREE ON Lire (idlecteur, idlivre, statut);

