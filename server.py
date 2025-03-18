from flask import Flask, render_template, Response, request, redirect, url_for, session, flash

from setuptools.command.easy_install import sys_executable

from database import Database

app = Flask(__name__)
app.secret_key = '9588203'

database = Database()

@app.route("/")
def main():
    return render_template('login.html')

@app.route("/login", methods=['GET', 'POST'])
def login():
    if request.method == "POST":
        courriel = request.form.get("courriel")
        passe = request.form.get("motpasse")

        # TODO: valider format du courriel

        # TODO: corriger la requête dans la BD
        cmd = 'SELECT motpasse FROM Utilisateurs WHERE courriel = %s;'
        database.cursor.execute(cmd, (courriel,))
        passeVrai = database.cursor.fetchone()

        # TODO: ajuster la validation selon la bd
        if (passeVrai!=None) and (passe==passeVrai[0]):
            cmd = 'SELECT * FROM Utilisateurs WHERE courriel = %s;'
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
            # return redirect(url_for('mabiblio'))

        return render_template('login.html', message="Informations invalides!")

    # si method = GET
    else:
        if "user" in session:
            return redirect(url_for('mabiblio'))
        return render_template('login.html')

# Fonction pour afficher la page de création d'un nouveau compte
@app.route("/creation-compte/", methods=['GET'])
def creationcompte():
    return render_template('creationcompte.html')

# Fonction pour gérer la soumission du formulaire de nouveau compte
@app.route('/inscription', methods=['POST'])
def inscription():
    prenom = request.form.get("prenom")
    nom = request.form.get("nom")
    courriel = request.form.get("courriel")
    surnom = request.form.get("surname")
    age = request.form.get("age")
    sexe = request.form.get("sexe")
    motpasse = request.form.get("motpass")

    # TODO: validation de l'entrée de l'utilisateur
    # TODO: ajouter l'utilisateur à la base de données
    return redirect(url_for('login'))  # Rediriger l'utilisateur vers la page login

@app.route("/logout")
def logout():
    if 'user' in session:
        flash("Vous avez été déconnecté!", "info")
        session.pop("user", None)
    return redirect(url_for('login'))

@app.route("/auteur/")
def auteur():
    return render_template('auteur.html', prenom='', nom='', style='', note='')

@app.route("/mabiblio/")
def mabiblio():

    return render_template(mabiblio.html)

if __name__ == "__main__":
    app.run(debug=True)