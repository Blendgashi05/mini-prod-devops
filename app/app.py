from flask import Flask, request, jsonify
import os
import psycopg2
import time

app = Flask(__name__)

VERSION = os.getenv("APP_VERSION", "v1")

DB_HOST = os.getenv("DB_HOST", "postgres")
DB_NAME = os.getenv("POSTGRES_DB", "appdb")
DB_USER = os.getenv("POSTGRES_USER", "user")
DB_PASS = os.getenv("POSTGRES_PASSWORD", "pass")

def get_db_connection():
    return psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )

def init_db():
    for _ in range(10):
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute("""
                CREATE TABLE IF NOT EXISTS messages (
                    id SERIAL PRIMARY KEY,
                    text TEXT NOT NULL
                );
            """)
            conn.commit()
            cur.close()
            conn.close()
            print("Database ready")
            return
        except Exception as e:
            print("Waiting for database...", e)
            time.sleep(3)

@app.route("/")
def home():
    return f"Hello from {VERSION}"

@app.route("/health")
def health():
    return "OK", 200

@app.route("/messages", methods=["POST"])
def add_message():
    data = request.get_json()
    text = data.get("text")

    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("INSERT INTO messages (text) VALUES (%s) RETURNING id;", (text,))
    message_id = cur.fetchone()[0]
    conn.commit()
    cur.close()
    conn.close()

    return jsonify({"id": message_id, "text": text, "status": "saved"})

@app.route("/messages", methods=["GET"])
def get_messages():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("SELECT id, text FROM messages;")
    rows = cur.fetchall()

    print("ROWS FROM DB:", rows)   # 👈 KJO

    cur.close()
    conn.close()

    return jsonify([{"id": r[0], "text": r[1]} for r in rows])

if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=5000)
