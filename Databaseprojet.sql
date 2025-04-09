show tables;
show triggers;
SHOW PROCEDURE STATUS
WHERE Db = 'Projet';

CALL Recherchelivre('Vhugo');
CALL Recherchepargenre('Roman');
Call Recherchenote(0);

select * from commenter;

select * from lire;

select * from lecteurs;
show create table commenter;
select * from repondre;
select * from noter;
select * from auteurs;
select * from livres;
select * from ecrire;

use projet;

DELIMITER ;;
CREATE TRIGGER update_livre_note_after_update
AFTER UPDATE ON noter
FOR EACH ROW
    UPDATE livres
    SET note = (
        SELECT IFNULL(AVG(note), 0)
        FROM noter
        WHERE idlivre = NEW.idlivre
    )
    WHERE lid = NEW.idlivre;
DELIMITER ;
