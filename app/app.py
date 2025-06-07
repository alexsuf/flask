from flask import Flask, render_template, request, redirect, url_for
import psycopg2
from pprint import pprint

app = Flask(__name__, template_folder='templates')

conn = psycopg2.connect(
    host="postgres",
    port='5432',
    database="postgres",
    user="postgres",
    password="secret"
)
cur = conn.cursor()

@app.route('/')
def index():
    cur.execute("SELECT id, CONCAT(' (', TO_CHAR(dtime, 'DD.MM.YYYY'), ') --> ', task) FROM public.app_tasks")
    rows = cur.fetchall()
    pprint(rows)
    return render_template('index.html', rows=rows)

@app.route('/delete', methods=['POST'])
def delete():
    task_id = request.form['task_id']
    cur.execute("DELETE FROM public.app_tasks WHERE id = %s", (task_id,))
    conn.commit()
    return redirect(url_for('index'))

@app.route('/add', methods=['POST'])
def add():
    task_text = request.form['task_text']
    cur.execute("INSERT INTO public.app_tasks (task) VALUES (%s)", (task_text,))
    conn.commit()
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)