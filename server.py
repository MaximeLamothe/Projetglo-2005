import re
from flask import Flask, render_template, Response, request, redirect, url_for, session, flash

from setuptools.command.easy_install import sys_executable

from database import Database

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
        passe = request.form.get("motpasse")

        # REGEX pour le courriel
        email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'

        # si le courriel est dans le bon format
        if re.match(email_pattern, courriel):
            # Aller chercher le mot de passe associé au courriel
            passeVrai = database.get_password(courriel)

            if (passeVrai!=None) and (passe==passeVrai[0]):
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
            valide = database.add_user(prenom, nom, surnom, age, courriel, sexe, motpasse)
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
    # Vérifier si l'utilisateur est connecté
    # if 'user_id' not in session:
       #  return redirect(url_for('login'))  # Rediriger vers la page de connexion si non connecté

    id = 1  # Récupérer l'ID de l'utilisateur connecté

    try:
        # Récupérer les livres pour chaque statut
        livres_lus = database.get_books_by_status(id, 'lu')
        livres_lus_count = len(livres_lus)

        livres_a_lire = database.get_books_by_status(id, 'a_lire')
        livres_a_lire_count = len(livres_a_lire)

        livres_a_acheter = database.get_books_by_status(id, 'a_acheter')
        livres_a_acheter_count = len(livres_a_acheter)

        # Rendre la page avec les livres par statut
        return render_template('mabiblio.html',
                               livres_lus=livres_lus, livres_lus_count=livres_lus_count,
                               livres_a_lire=livres_a_lire, livres_a_lire_count=livres_a_lire_count,
                               livres_a_acheter=livres_a_acheter, livres_a_acheter_count=livres_a_acheter_count)

    except Exception as e:
        print(f"Error while fetching user's books: {e}")
        return render_template('mabiblio.html', error="Erreur lors du chargement des livres.")


@app.route("/profil/")
def profil():
    # TODO: Recuperer le vrai ID de l'utilisateur connecté
    id = 1  # Récupérer l'ID de l'utilisateur connecté

    # Récupérer les informations de l'utilisateur
    user_info = database.get_user_info(id)

    # Si l'utilisateur n'existe pas, retourner une erreur
    if not user_info:
        return "Utilisateur non trouvé", 404

    # Rendre la page de profil avec les informations récupérées
    return render_template('profil.html', **user_info)
@app.route('/recherche/', methods=['GET', 'POST'])
def recherche():
    if request.method == 'POST':
        auteur = request.form.get('auteur', '')
        annee = request.form.get('annee', '')
        titre = request.form.get('titre', '')
        maison = request.form.get('maison', '')
        filtre = request.form.get('filtre', '')

        livres_trouves = database.search_books(auteur, annee, titre, maison, filtre)
    else:
        livres_trouves = []

    return render_template('recherche.html', livres=livres_trouves)
@app.route('/livre/<int:lid>')
def livre_details(lid):
    # Récupérer les détails du livre
    book = database.get_book_details(lid)

    # Si le livre n'existe pas, retourner une erreur
    if not book:
        return "Livre non trouvé", 404

    # Récupérer les commentaires du livre
    comments = database.get_comments_for_book(lid)

    # Rendre la page livre.html avec les informations
    return render_template('livre.html', livre=book, commentaires=comments)

if __name__ == "__main__":
    app.run(debug=True)