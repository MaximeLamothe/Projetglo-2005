import re
from flask import Flask, render_template, Response, request, redirect, url_for, session, flash
import password_hash

from setuptools.command.easy_install import sys_executable


from database import Database
from password_hash import verify_password

app = Flask(__name__)
app.secret_key = '9588203'

database = Database()

@app.route("/")
def main():
    return render_template('login.html')

@app.route('/base/', methods=['GET', 'POST'])
def base():
    return render_template('base.html')

@app.route("/login", methods=['GET', 'POST'])
def login():
    if request.method == "POST":
        courriel = request.form.get("courriel")
        mdp = request.form.get("motpasse")

        # REGEX pour le courriel
        email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'

        # si le courriel est dans le bon format
        if re.match(email_pattern, courriel):
            # Aller chercher le mot de passe chiffré (dans la BD) associé au courriel
            mdp_BD = database.get_password(courriel)

            if (mdp_BD is not None) and (password_hash.verify_password(mdp, mdp_BD)):
                info = database.connexion(courriel)

                # Initialisation de la session
                session['id'] = info['lid']
                session['prenom'] = info['prenom']
                session['nom'] = info['nom']
                session['surnom'] = info['surnom']
                session['age'] = info['age']
                session['sexe'] = info['sexe']
                session['email'] = info['email']
                session['nombrelivreslus'] = info['nombrelivreslus']

                return redirect(url_for('mabiblio'))

        return render_template('login.html', message="Informations invalides!")

    # si method = GET
    else:
        if "user" in session:
            return redirect(url_for('mabiblio'))
        return render_template('login.html')

# Fonction pour afficher la page de création d'un nouveau compte
@app.route("/creation-compte/", methods=['GET', 'POST'])
def creationcompte():
    return render_template('creationcompte.html')

# Fonction pour gérer la soumission du formulaire de nouveau compte
@app.route('/creation-compte/inscription/', methods=['POST'])
def inscription():
    # Récupérer les informations entrées par l'utilisateur
    prenom = request.form.get("prenom")
    nom = request.form.get("nom")
    courriel = request.form.get("courriel")
    surnom = request.form.get("surnom")
    age = request.form.get("age")
    sexe = request.form.get("sexe")
    motpasse = request.form.get("motpasse")

    # REGEX pour le courriel
    email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'

    # si le courriel est conforme
    if re.match(email_pattern, courriel):
        # vérifier que le courriel n'est pas déjà dans la BD
        info = database.get_email(courriel)

        if info: # si le courriel est déjà dans la BD
            flash("Ce courriel est déjà utilisé !", "info")
            return redirect(url_for('creationcompte'))

        else:
            motpasse_chiffre = password_hash.hash_password(motpasse)
            valide = database.add_user(prenom, nom, surnom, age, courriel, sexe, motpasse_chiffre)
            if valide:
                flash("Votre compte a été créé!", "info")
                return redirect(url_for('login'))  # Rediriger l'utilisateur vers la page login
            else:
                flash("ERREUR !", "info")
                return redirect(url_for('creationcompte'))

    # si le courriel n'est pas dans le bon format
    else:
        flash("Le courriel est invalide !", "info")
        return redirect(url_for('creationcompte'))

@app.route("/logout/", methods=['GET', 'POST'])
def logout():
    if 'user' in session:
        flash("Vous avez été déconnecté!", "info")
        session.pop("user", None)
    return redirect(url_for('login'))

## Afficher une page d'auteur
@app.route("/auteur/<int:auteur_id>", methods=['GET', 'POST'])
def auteur(auteur_id):
    if "prenom" in session:

        lid = session['id']
        auteur = database.get_author_details(auteur_id, lid)

        if not auteur:
            return "Auteur non trouvé", 404

        livres = database.get_books_by_author(auteur_id)

    # Vérifier si on a déjà l'info via l'URL
    # est_favori = request.args.get("favori")

    # if est_favori is None:  # Si l'info n'est pas passée, on fait la requête
    #     cur.execute("SELECT COUNT(*) FROM auteurs_favoris WHERE auteur_id = %s", (auteur_id,))
    #     est_favori = cur.fetchone()[0] > 0
    # else:
    #     est_favori = bool(int(est_favori))  # Convertir en booléen

        return render_template("auteur.html", auteur=auteur, livres=livres)
    # si aucun utilisateur connecté
    else:
        return redirect(url_for('login'))

@app.route("/auteur_favori/<int:auteur_id>", methods=["POST"])
def auteur_favori (auteur_id):
    action = request.form.get("favori")
    lid = session['id']

    if action == "ajouter":
        # Ajouter l'auteur aux favoris du lecteur
        auteur = database.add_favorite_author(auteur_id, lid)
        if not auteur:
            return "Auteur non trouvé", 404

    else:
        # Retirer l'auteur des favoris du lecteur
        auteur = database.remove_favorite_author(auteur_id, lid)
        if not auteur:
            return "Auteur non trouvé", 404

    return redirect(url_for("auteur", auteur_id=auteur_id))

@app.route("/noter-auteur/<int:auteur_id>/", methods=["POST"])
def noter_auteur(auteur_id):
    """ Ajoute ou modifie la note de l'auteur avec un bouton radio et passe la valeur via l'URL """
    note = int(request.form.get("note"))
    note = int(request.form.get("note"))
    user_id = session["user_id"]
    cur = database.cursor()
    existe = cur.fetchone()[0] > 0

    if existe:
        # Si l'utilisateur a déjà noté, on met à jour sa note
        cur.execute("UPDATE notes_auteurs SET note = %s WHERE auteur_id = %s AND user_id = %s",
                    (note, auteur_id, user_id))
    else:
        # Si l'utilisateur n'a pas encore noté, on insère une nouvelle ligne
        cur.execute("INSERT INTO notes_auteurs (auteur_id, note, user_id) VALUES (%s, %s, %s)",
                    (auteur_id, note, user_id))

    database.connection.commit()
    cur.close()

    # On récupère aussi est_favori pour éviter la requête SQL dans afficher_auteur
    # est_favori = request.args.get("favori", 0)
    return redirect(url_for("auteur", auteur_id=auteur_id, favori=est_favori, note=note))

@app.route("/mabiblio/")
def mabiblio():
    if "prenom" in session:
        lid = session['id'] # Récupérer l'ID de l'utilisateur connecté

        try:
            # Récupérer les livres pour chaque statut
            livres_lus = database.get_books_by_status(lid, 'lu')
            livres_lus_count = len(livres_lus)

            livres_a_lire = database.get_books_by_status(lid, 'a lire')
            livres_a_lire_count = len(livres_a_lire)

            livres_a_acheter = database.get_books_by_status(lid, 'en cours')
            livres_a_acheter_count = len(livres_a_acheter)

            # Récupérer les auteurs favoris
            auteurs_favoris_ids = database.get_favorite_author_ids(lid)
            auteurs_favoris = [database.get_author_details(aid, lid) for aid in auteurs_favoris_ids]

            # Rendre la page avec les livres par statut
            return render_template('mabiblio.html',
                                   livres_lus=livres_lus, livres_lus_count=livres_lus_count,
                                   livres_a_lire=livres_a_lire, livres_a_lire_count=livres_a_lire_count,
                                   livres_a_acheter=livres_a_acheter, livres_a_acheter_count=livres_a_acheter_count,
                                   auteurs_favoris=auteurs_favoris)

        except Exception as e:
            print(f"Error while fetching user's books: {e}")
            return render_template('mabiblio.html', error="Erreur lors du chargement des livres.")
    else:
        return redirect(url_for('login'))


@app.route("/profil/")
def profil():
    if "prenom" in session:

        lid = session['id']  # Récupérer l'ID de l'utilisateur connecté

        # Récupérer les informations de l'utilisateur
        user_info = database.get_user_info(lid)

        # Rendre la page de profil avec les informations récupérées
        return render_template('profil.html', **user_info)

    else:
        return redirect(url_for('login'))
@app.route('/recherche/', methods=['GET', 'POST'])
def recherche():
    if "prenom" in session:
        genres = database.get_all_genres()

        if request.method == 'POST':
            auteur = request.form.get('auteur', '')
            annee = request.form.get('annee', '')
            titre = request.form.get('titre', '')
            maison = request.form.get('maison', '')
            genre = request.form.get('genre', '')
            filtre = request.form.get('filtre', '')

            livres_trouves = database.search_books(auteur, annee, titre, maison, genre, filtre)
        else:
            livres_trouves = []

        return render_template('recherche.html', livres=livres_trouves, genres=genres)
    else:
        return redirect(url_for('login'))
@app.route('/livre/<int:lid>', methods=['GET', 'POST'])
def livre_details(lid):
    if "prenom" in session:
        uid = session['id']  # Récupérer l'ID de l'utilisateur connecté

        # Récupérer les détails du livre
        session["livre_id_actuel"] = lid
        book = database.get_book_details(lid)

        # Si le livre n'existe pas, retourner une erreur
        if not book:
            return "Livre non trouvé", 404

        # Vérifier si le livre est déjà dans la bibliothèque de l'utilisateur
        est_dans_biblio = database.is_book_in_library(uid, lid)

        if est_dans_biblio:
            # Récupérer le statut du livre dans la bibliothèque
            statut = database.get_book_status(uid, lid)
        else:
            statut = None

        # Récupérer les commentaires du livre
        comments = database.get_comments_for_book(lid)

        # Récupérer la note actuelle de l'utilisateur pour ce livre
        note_actuelle = database.recuperer_note_utilisateur_pour_livre(lid, uid)

        if request.method == 'POST':
            note = int(request.form['rating'])
            # Ajouter ou mettre à jour la note dans la base de données
            database.ajouter_ou_mettre_a_jour_note(lid, uid, note)
            return redirect(url_for('livre_details', lid=lid))  # Recharger la page après modification

        # Rendre la page livre.html avec les informations
        return render_template('livre.html', livre=book, est_dans_biblio=est_dans_biblio, statut=statut, commentaires=comments, note_actuelle=note_actuelle)
    else:
        return redirect(url_for('login'))

@app.route("/ajouter_commentaire", methods=["POST"])
def ajouter_commentaire():
    if "prenom" not in session:
        return redirect(url_for("login"))

    contenu = request.form["contenu"]
    reponsecid = request.form.get("reponsecid")
    if reponsecid == "":
        reponsecid = None

    utilisateur_id = session["id"]
    livre_id = session.get("livre_id_actuel")  # À définir temporairement dans session

    database.ajouter_commentaire(utilisateur_id, livre_id, contenu, reponsecid)
    return redirect(url_for("livre_details", lid=livre_id))


@app.route("/modifier_bibliotheque/<int:lid>", methods=["POST"])
def modifier_bibliotheque(lid):
    if "prenom" not in session:
        return redirect(url_for("login"))

    uid = session["id"]
    action = request.form.get("action")

    if action == "ajouter":
        statut = request.form.get("statut")  # Récupérer le statut choisi
        database.add_book_to_library(uid, lid, statut)
    elif action == "retirer":
        database.remove_book_from_library(uid, lid)

    return redirect(url_for("livre_details", lid=lid))


if __name__ == "__main__":
    app.run(debug=True)