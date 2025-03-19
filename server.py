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

@app.route("/auteur/")
def auteur():
    #if "user" in session:
    return render_template('auteur.html', prenom='', nom='', style='', note='')
    # else:
        # return redirect(url_for('login'))

@app.route("/mabiblio/")
def mabiblio():

    return render_template(mabiblio.html)

if __name__ == "__main__":
    app.run(debug=True)