from flask import Flask, request, jsonify
from flask_cors import CORS
import sqlite3

app = Flask(__name__)
CORS(app)  # Enable CORS for frontend-backend communication

DATABASE = 'gym_tracker.db'

def init_db():
    """Initialize the SQLite database with the required tables."""
    with sqlite3.connect(DATABASE) as conn:
        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS user_profile (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                gender TEXT NOT NULL,
                age INTEGER NOT NULL,
                address TEXT NOT NULL
            )
        """)
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS workout_progress (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                day TEXT NOT NULL UNIQUE,
                completed_workouts INTEGER DEFAULT 0
            )
        """)
        for day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']:
            cursor.execute('INSERT OR IGNORE INTO workout_progress (day) VALUES (?)', (day,))
        conn.commit()

init_db()

@app.route('/')
def home():
    return "Flask is working!"

@app.route('/profile', methods=['GET', 'POST'])
def profile():
    try:
        if request.method == 'POST':
            data = request.json
            name = data.get('name')
            gender = data.get('gender')
            age = data.get('age')
            address = data.get('address')

            with sqlite3.connect(DATABASE) as conn:
                cursor = conn.cursor()
                cursor.execute('DELETE FROM user_profile')  # Clear previous profile
                cursor.execute('INSERT INTO user_profile (name, gender, age, address) VALUES (?, ?, ?, ?)',
                               (name, gender, age, address))
                conn.commit()

            return jsonify({'message': 'Profile updated successfully'}), 200

        elif request.method == 'GET':
            with sqlite3.connect(DATABASE) as conn:
                cursor = conn.cursor()
                cursor.execute('SELECT * FROM user_profile LIMIT 1')
                row = cursor.fetchone()

            if row:
                return jsonify({
                    'name': row[1],
                    'gender': row[2],
                    'age': row[3],
                    'address': row[4]
                }), 200
            else:
                return jsonify({'message': 'No profile found'}), 404

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/workouts', methods=['GET', 'POST'])
def workouts():
    try:
        if request.method == 'POST':
            data = request.json
            day = data.get('day')

            with sqlite3.connect(DATABASE) as conn:
                cursor = conn.cursor()
                cursor.execute('UPDATE workout_progress SET completed_workouts = completed_workouts + 1 WHERE day = ?',
                               (day,))
                conn.commit()

            return jsonify({'message': f'Workout for {day} marked as done'}), 200

        elif request.method == 'GET':
            with sqlite3.connect(DATABASE) as conn:
                cursor = conn.cursor()
                cursor.execute('SELECT day, completed_workouts FROM workout_progress')
                rows = cursor.fetchall()

            return jsonify({row[0]: row[1] for row in rows}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
