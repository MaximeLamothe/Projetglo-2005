from flask import Flask, render_template, Response

from database import Database

app = Flask(__name__)

database = Database()


@app.route("/")
def main():
    return render_template('login.html')

@app.route("/login")
def login():
    # if
        # return render_template('bienvenu.html', profile=ProfileUtilisateur)
    return render_template('login.html')

@app.route("/inscription/")
def inscription():
    return render_template('inscription.html')

if __name__ == "__main__":
    app.run()