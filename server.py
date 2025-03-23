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

        # si le courriel est conforme
        if re.match(email_pattern, courriel):

            # TODO: corriger la requête dans la BD
            cmd = 'SELECT motdepasse FROM lecteurs WHERE email = %s;'
            database.cursor.execute(cmd, (courriel,))
            passeVrai = database.cursor.fetchone()

            # TODO: ajuster la validation selon la bd
            if (passeVrai!=None) and (passe==passeVrai[0]):
                cmd = 'SELECT * FROM lecteurs WHERE email = %s;'
                database.cursor.execute(cmd, (courriel,))
                info = database.cursor.fetchone()

                # user = surnom
                # session["prenom"] = info[]
                # session['nom'] = info[]
                # session["surnom"] = info[]
                # session['age'] = info[]
                # session['sexe'] = info[]
                # session['courriel'] = courriel
                #
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
@app.route('/inscription/', methods=['POST'])
def inscription():

    # Récupérer les informations entrées par l'utilisateur
    prenom = request.form.get("prenom")
    nom = request.form.get("nom")
    courriel = request.form.get("courriel")
    surnom = request.form.get("surname")
    age = request.form.get("age")
    sexe = request.form.get("sexe")
    motpasse = request.form.get("motpass")

    # REGEX pour le courriel
    email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'

    # si le courriel est conforme
    if re.match(email_pattern, courriel):
        # vérifier que le courriel n'est pas déjà dans la BD
        cmd = 'SELECT email FROM lecteurs WHERE email = %s;'
        database.cursor.execute(cmd, (courriel,))
        info = database.cursor.fetchone()

        if info: # si le courriel est déjà dans la BD
            flash("Ce courriel est déjà utilisé !", "info")
            return redirect(url_for('creationcompte'))
        else:
            # TODO: ajouter l'utilisateur à la base de données

            flash("Votre compte a été créé!", "info")
            return redirect(url_for('login'))  # Rediriger l'utilisateur vers la page login

    # si le courriel n'est pas dans le bon format
    else:
        flash("Le courriel est invalide !", "info")
        return redirect(url_for('creation-compte'))

@app.route("/logout")
def logout():
    if 'user' in session:
        flash("Vous avez été déconnecté!", "info")
        session.pop("user", None)
    return redirect(url_for('login'))

## Afficher une page d'auteur
@app.route("/auteur/<int:auteur_id>")
def auteur(auteur_id):
    # if "user" in session:
    """ Affiche la page de l'auteur et récupère son statut favori """
    cur = database.cursor

    # Récupérer les infos de l'auteur
    #cur.execute("SELECT nom FROM auteurs WHERE id = %s", (auteur_id,))
    result = cur.fetchone()

    if not result:
        return "Auteur non trouvé", 404

    auteur_nom = result[0]

    # Vérifier si on a déjà l'info via l'URL
    est_favori = request.args.get("favori")

    if est_favori is None:  # Si l'info n'est pas passée, on fait la requête
        cur.execute("SELECT COUNT(*) FROM auteurs_favoris WHERE auteur_id = %s", (auteur_id,))
        est_favori = cur.fetchone()[0] > 0
    else:
        est_favori = bool(int(est_favori))  # Convertir en booléen

    cur.close()

    return render_template("auteur.html", auteur_nom=auteur_nom,
                           auteur_id=auteur_id, est_favori=est_favori)
    # else:
        # return redirect(url_for('login'))

@app.route("/ajouter_auteur/<int:auteur_id>", methods=["POST"])
def ajouter_auteur(auteur_id):
    """ Ajoute ou retire l’auteur des favoris et transmet directement le nouvel état """
    cur = database.cursor

    # Vérifier si l’auteur est déjà en favoris
    cur.execute("SELECT COUNT(*) FROM auteurs_favoris WHERE auteur_id = %s", (auteur_id,))
    est_favori = cur.fetchone()[0] > 0

    if est_favori:
        cur.execute("DELETE FROM auteurs_favoris WHERE auteur_id = %s", (auteur_id,))
        est_favori = 0  # Nouveau statut
    else:
        cur.execute("INSERT INTO auteurs_favoris (auteur_id) VALUES (%s)", (auteur_id,))
        est_favori = 1  # Nouveau statut

    cur.close()

    # Rediriger avec l'information en paramètre GET pour éviter une nouvelle requête SQL
    return redirect(url_for("afficher_auteur", auteur_id=auteur_id, favori=est_favori))

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
    est_favori = request.args.get("favori", 0)
    return redirect(url_for("afficher_auteur", auteur_id=auteur_id, favori=est_favori, note=note))

@app.route("/test")
def test():
    list = [1, 2, 3, 4, 5]
    return render_template("test.html", list=list)

@app.route("/mabiblio/")
def mabiblio():

    return render_template(mabiblio.html)

if __name__ == "__main__":
    app.run(debug=True)