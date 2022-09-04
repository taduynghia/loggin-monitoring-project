from flask import Flask, render_template, request, jsonify
from dotenv import load_dotenv, find_dotenv
# import pymysql
from flask_mysqldb import MySQL
import os

app = Flask(__name__)
load_dotenv(find_dotenv())
# conect db
# connection = pymysql.connect(host=os.environ.get("HOST"),
#                              user=os.environ.get("USER"),
#                              password=os.environ.get("PASSWORD"),
#                              database=os.environ.get("DATABASE"),
#                              port=3306)

app.config["MYSQL_HOST"] = os.environ.get("HOST")
app.config["MYSQL_USER"] = os.environ.get("USER")
app.config["MYSQL_PASSWORD"] = os.environ.get("PASSWORD")
app.config["MYSQL_DB"] = os.environ.get("DATABASE")
mysql = MySQL(app)


@app.route("/")
def hello_world():
    return render_template('index.html')


@app.route("/<room>")
def get_message(room):
    return render_template('index.html')


@app.route("/api/chat/<room>", methods=['GET', 'POST'])
def chat_api(room):
    result = ''
    if request.method == 'POST':
        name = request.form['name']
        msg = request.form['msg']
        cur = mysql.connection.cursor()
        cur.execute(
            "INSERT INTO chat (name,message,room) VALUES(%s,%s,%s)", (name, msg, room))
        mysql.connection.commit()
        cur.close()
    else:
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM chat WHERE room=%s", (room,))
        result = cur.fetchall()
        cur.close()
    return jsonify(result)


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
