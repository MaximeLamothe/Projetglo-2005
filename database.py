import os

import pymysql
from dotenv import load_dotenv

# from sql_utils import run_sql_file

class Database:
    def __init__(self):
        load_dotenv()

        # Charger les variables d'environnement pour la connexion Oracle
        self.host = os.getenv("HOST")
        self.port = int(os.getenv("PORT"))
        self.database = os.getenv("DATABASE")
        self.user =os.getenv("DB_USER")
        self.password =os.getenv("PASSWORD")

        self._open_sql_connection()

    def _open_sql_connection(self):
        self.connection = pymysql.connect(
            host=self.host,
            port=self.port,
            user=self.user,
            password=self.password,
            db=self.database,
            autocommit=True
        )

        self.cursor = self.connection.cursor()

    # Fonction pour récupérer les informations d'un livre
    def get_book_details(self, lid):
        try:
            request = f"""
                    SELECT titre, genre, annee, maison_edition, nombre_de_pages, livres.note, auteurs.prenom, auteurs.nom, auteurs.aid, livres.lid
                    FROM livres, auteurs, ecrire
                    WHERE livres.lid = ecrire.idlivre AND auteurs.aid = ecrire.idauteur AND livres.lid =%s"""
            self.cursor.execute(request, (lid,))
            book = self.cursor.fetchone()  # Récupère la première ligne

            if book:
                # Si la note est NULL, affecter 0 par défaut
                return {
                    'titre': book[0],
                    'genre': book[1],
                    'annee': book[2],
                    'maison_edition': book[3],
                    'nombre_de_pages': book[4],
                    'note': book[5] if book[5] is not None else 0,  # Correction ici
                    'prenom': book[6],
                    'nom' : book[7],
                    'aid': book[8],
                    'lid': book[9],
                }
            else:
                print(f"Erreur: Aucun livre trouvé avec l'ID {lid}")
                return None
        except Exception as e:
            print(f"Error while getting book details: {e}")
            return None

    # Fonction pour récupérer les commentaires d'un livre
    def get_comments_for_book(self, lid):
        try:
            query = """
                        SELECT c.contenu, l.prenom, l.nom, c.réponsecid
                        FROM commentaires c
                        JOIN lecteurs l ON c.idlecteur = l.id
                        WHERE c.idlivre = %s
                    """
            self.cursor.execute(query, (lid,))
            comments = self.cursor.fetchall()  # Récupère toutes les lignes

            if not comments:
                return []  # Retourner une liste vide si aucun commentaire

            # Transformer les résultats en liste de dictionnaires
            return [
                {
                    'contenu': comment[0],
                    'prenom': comment[1],
                    'nom': comment[2],
                    'reponse': comment[3]  # Peut être NULL
                }
                for comment in comments
            ]
        except Exception as e:
            print(f"Error while getting comments for book: {e}")
            return []

    def search_books(self, auteur=None, annee=None, titre=None, maison=None, filtre=None):
        try:
            # Construction de la requête dynamique
            query = ("SELECT * FROM livres, ecrire, auteurs "
                     "WHERE livres.lid = ecrire.idlivre AND auteurs.aid = ecrire.idauteur")
            params = []

            if auteur:
                query += " AND (auteurs.nom LIKE %s OR auteurs.prenom LIKE %s OR CONCAT(auteurs.prenom, ' ', auteurs.nom) LIKE %s)"
                params.append(f"%{auteur}%")  # Recherche par prenom
                params.append(f"%{auteur}%")  # Recherche par nom
                params.append(f"%{auteur}%")  # Recherche par concaténation nom + prénom
            if annee:
                query += " AND annee = %s"
                params.append(annee)
            if titre:
                query += " AND titre LIKE %s"
                params.append(f"%{titre}%")
            if maison:
                query += " AND maison_edition LIKE %s"
                params.append(f"%{maison}%")

            if filtre:
                if filtre == "annee_croissant":
                    query += " ORDER BY annee ASC"
                elif filtre == "annee_decroissant":
                    query += " ORDER BY annee DESC"
                elif filtre == "alpha":
                    query += " ORDER BY titre ASC"
                elif filtre == "alpha_inverse":
                    query += " ORDER BY titre DESC"

            self.cursor.execute(query, tuple(params))
            result = self.cursor.fetchall()
            return result

        except Exception as e:
            print(f"Error while searching books: {e}")
            return None

    def get_user_info(self, id):
        try:
            request = f"""
                SELECT prenom, nom, email, surnom, age, sexe
                FROM lecteurs
                WHERE lecteurs.id = %s
            """
            self.cursor.execute(request, (id,))
            user_info = self.cursor.fetchone()

            if user_info:
                return {
                    'prenom': user_info[0],
                    'nom': user_info[1],
                    'email': user_info[2],
                    'surnom': user_info[3],
                    'age': user_info[4],
                    'sexe': user_info[5],
                }
            else:
                return None
        except Exception as e:
            print(f"Error while fetching user info: {e}")
            return None

    def get_books_by_status(self, user_id, statut):
        try:
            request = f"""
                SELECT l.lid, l.titre, l.genre, l.annee 
                FROM livres l, lire
                WHERE lire.idlecteur = %s AND lire.statut = %s AND l.lid = lire.idlivre
            """
            # Exécuter la requête
            self.cursor.execute(request, (user_id, statut))
            result = self.cursor.fetchall()
            return result
        except Exception as e:
            print(f"Error while fetching books by status: {e}")
            return None

    # Fonction pour récupérer les informations d'un auteur
    def get_author_details(self, aid, lid):
        try:
            request = """SELECT A.prenom, A.nom, A.surnom, A.specialite, A.photo, A.note, A.aid,
                (SELECT COUNT(*) FROM auteurpreferer AP WHERE AP.idauteur = A.aid AND AP.idlecteur = %s) AS favori
                FROM auteurs A
                WHERE A.aid = %s;
            """

            self.cursor.execute(request, (lid, aid))
            auteur = self.cursor.fetchone()  # Récupère la première ligne

            if auteur:
            # Si la note est NULL, affecter 0 par défaut
                return {
                    'prenom': auteur[0],
                    'nom': auteur[1],
                    'surnom': auteur[2],
                    'specialite': auteur[3],
                    'photo': auteur[4],
                    'note': auteur[5] if auteur[5] is not None else 0,  # Correction ici
                    'id': auteur[6],
                    'favori':auteur[7]
                    }
            else:
                print(f"Erreur: Aucun auteur trouvé avec l'ID {aid}")
                return None
        except Exception as e:
            print(f"Erreur en recherchant les informations de l'auteur: {e}")
            return None

    def add_favorite_author(self, aid, lid):
        try:
            request = """INSERT INTO auteurpreferer VALUES (%s, %s);"""
            self.cursor.execute(request, (lid, aid))
            self.connection.commit()
            return True

        except Exception as e:
            print(f"Erreur en ajoutant l'auteur {aid} aux favoris: {e}")
            return False

    def remove_favorite_author(self, aid, lid):
        try:
            request = """DELETE FROM auteurpreferer WHERE idauteur=%s AND idlecteur=%s ;"""
            self.cursor.execute(request, (aid, lid))
            self.connection.commit()
            return True

        except Exception as e:
            print(f"Erreur en retirant l'auteur {aid} des favoris: {e}")
            return False

    def connexion(self, email):
        try:
            request = """
                            SELECT *
                            FROM lecteurs
                            WHERE lecteurs.email = %s
                        """
            self.cursor.execute(request, (email,))
            user_info = self.cursor.fetchone()

            user_data = {
                'lid': user_info[0],
                'prenom': user_info[1],
                'nom': user_info[2],
                'surnom': user_info[3],
                'age': user_info[4],
                'email': user_info[5],
                'motdepasse': user_info[6],
                'nombrelivreslus': user_info[7],
                'sexe': user_info[8],
            }
            return user_data

        except Exception as e:
            print(f"Erreur lors de la connexion avec le courriel {email}: {e}")
            return False

    def get_password(self, email):
        try:
            request = 'SELECT motdepasse FROM lecteurs WHERE email = %s;'
            self.cursor.execute(request, (email,))
            result = self.cursor.fetchone()
            return result

        except Exception as e:
            print(f"Erreur en recherchant le courriel {email} : {e}")
            return False

    def get_email(self, email):
        try:
            request = f"""SELECT email FROM lecteurs WHERE email = %s;"""
            self.cursor.execute(request, (email,))
            result = self.cursor.fetchone()
            return result

        except Exception as e:
            print(f"Erreur en recherchant le courriel {email} : {e}")
            return False

    def add_user(self, prenom, nom, surnom, age, courriel, sexe, motpasse):
        try:
            # Déterminer le dernier id
            request_id = """
                SELECT MAX(id) AS max_id
                FROM lecteurs       
                """
            self.cursor.execute(request_id)
            max_id = self.cursor.fetchone()
            print(max_id)
            new_id = max_id[0] + 1

            request = """INSERT INTO lecteurs (id, prenom, nom, surnom, age, email, motdepasse, nombrelivreslus, sexe) 
                VALUES (%s, %s, %s, %s, %s, %s, %s,  %s, %s);"""



            self.cursor.execute(request, (new_id, prenom, nom, surnom, age, courriel, motpasse, 0, sexe))
            self.connection.commit()
            return True

        except Exception as e:
            print(f"Erreur en ajoutant l'utilisateur {surnom} : {e}")
            return False

    def get_books_by_author(self, aid):
        try:
            request = f"""
                SELECT L.lid, L.titre, L.genre, L.annee, L.couverture
                FROM livres L, ecrire E
                WHERE L.lid = E.idlivre AND E.idauteur = %s 
            """
            # Exécuter la requête
            self.cursor.execute(request, aid)
            livres = self.cursor.fetchall()
            return livres

        except Exception as e:
            print(f"Error while fetching books by author: {e}")
            return None

    def get_favorite_author_ids(self, lid):
        try:
            query = "SELECT idauteur FROM auteurpreferer WHERE idlecteur = %s"
            self.cursor.execute(query, (lid,))
            return [row[0] for row in self.cursor.fetchall()]
        except Exception as e:
            print(f"Erreur en récupérant les auteurs favoris : {e}")
            return []

    def is_book_in_library(self, lid, book_id):
        try:
            request = "SELECT COUNT(*) FROM lire WHERE idlecteur = %s AND idlivre = %s"
            self.cursor.execute(request, (lid, book_id))
            return self.cursor.fetchone()[0] > 0
        except Exception as e:
            print(f"Erreur en vérifiant si le livre {book_id} est dans la bibliothèque de {lid}: {e}")
            return False

    def get_book_status(self, lid, book_id):
        try:
            request = """SELECT statut FROM lire WHERE idlecteur = %s AND idlivre = %s"""
            self.cursor.execute(request, (lid, book_id))
            result = self.cursor.fetchone()
            return result[0] if result else None
        except Exception as e:
            print(f"Erreur en récupérant le statut du livre {book_id} pour {lid}: {e}")
            return None

    def add_book_to_library(self, lid, book_id, statut):
        try:
            request = """INSERT INTO lire (idlecteur, idlivre, statut) VALUES (%s, %s, %s);"""
            self.cursor.execute(request, (lid, book_id, statut))
            self.connection.commit()
            return True
        except Exception as e:
            print(f"Erreur en ajoutant le livre {book_id} à la bibliothèque de {lid}: {e}")
            return False

    def remove_book_from_library(self, lid, book_id):
        try:
            request = """DELETE FROM lire WHERE idlecteur=%s AND idlivre=%s;"""
            self.cursor.execute(request, (lid, book_id))
            self.connection.commit()
            return True
        except Exception as e:
            print(f"Erreur en retirant le livre {book_id} de la bibliothèque de {lid}: {e}")
            return False

    def ajouter_ou_mettre_a_jour_note(self, lid, utilisateur_id, note):
        try:
            # Vérifier si l'utilisateur a déjà noté ce livre
            requete = """
                SELECT idlecteur FROM noter WHERE idlivre = %s AND idlecteur = %s
            """
            self.cursor.execute(requete, (lid, utilisateur_id))
            note_existante = self.cursor.fetchone()

            if note_existante:
                # Si la note existe déjà, mettre à jour
                requete_update = """
                    UPDATE noter SET note = %s WHERE idlivre = %s AND idlecteur = %s
                """
                self.cursor.execute(requete_update, (note, lid, utilisateur_id))
            else:
                # Si la note n'existe pas, insérer une nouvelle note
                requete_insert = """
                    INSERT INTO noter (idlivre, idlecteur, note) VALUES (%s, %s, %s)
                """
                self.cursor.execute(requete_insert, (lid, utilisateur_id, note))

            self.connection.commit()
            return True
        except Exception as e:
            print(f"Erreur lors de l'ajout ou de la mise à jour de la note: {e}")
            return False

    def recuperer_note_utilisateur_pour_livre(self, lid, utilisateur_id):
        try:
            requete = """
                SELECT note FROM noter WHERE idlivre = %s AND idlecteur = %s
            """
            self.cursor.execute(requete, (lid, utilisateur_id))
            note = self.cursor.fetchone()

            if note:
                return note[0]  # Retourne la note de l'utilisateur
            return 0  # Si l'utilisateur n'a pas encore noté ce livre
        except Exception as e:
            print(f"Erreur lors de la récupération de la note pour le livre {lid}: {e}")
            return None
