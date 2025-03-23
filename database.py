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
                    SELECT titre, genre, annee, maison_edition, nombre_de_pages, livres.note, auteurs.prenom, auteurs.nom
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
            query = f"""
                SELECT c.contenu, l.prenom || ' ' || l.nom AS lecteur
                FROM commentaires c
                JOIN lecteurs l ON c.idlecteur = l.id
                WHERE c.idlivre = %s """
            self.cursor.execute(query, (lid,))
            comments = self.cursor.fetchall()  # Récupère toutes les lignes

            return comments
        except Exception as e:
            print(f"Error while getting comments for book: {e}")
            return None

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
