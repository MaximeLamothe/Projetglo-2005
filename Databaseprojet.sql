show tables;
show triggers;
SHOW PROCEDURE STATUS
WHERE Db = 'Projet';

CALL Recherchelivre('Vhugo');
CALL Recherchepargenre('Roman');
Call Recherchenote(0);

select * from commenter;
select * from livres;
select * from lire;
select * from auteurs;
select * from lecteurs;
show create table commenter;
select * from repondre;
select * from ecrire;

use projet;
