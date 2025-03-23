select * from auteurs;
SELECT titre, genre, annee, maison_edition, nombre_de_pages, livres.note, auteurs.surnom
                    FROM livres, auteurs, ecrire
                    WHERE livres.lid = ecrire.idlivre AND auteurs.aid = ecrire.idauteur AND livres.lid =1;