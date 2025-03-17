from flask import Flask, render_template, Response

from database import Database

app = Flask(__name__)

database = Database()


@app.route("/")
def main():
    return render_template('login.html')



if __name__ == "__main__":
    app.run()