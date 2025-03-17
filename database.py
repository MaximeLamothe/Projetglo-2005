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