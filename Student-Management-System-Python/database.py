
import sqlite3

def connect_db():
    return sqlite3.connect("students.db")

def create_table():
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS students (
            student_id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            age INTEGER,
            course TEXT,
            marks REAL
        )
    """)

    conn.commit()
    conn.close()

def get_grade(marks):
    if marks >= 90:
        return "A"
    elif marks >= 80:
        return "B"
    elif marks >= 70:
        return "C"
    elif marks >= 60:
        return "D"
    else:
        return "Needs Improvement"

def add_student(student_id, name, age, course, marks):
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute(
        "INSERT INTO students VALUES (?, ?, ?, ?, ?)",
        (student_id, name, age, course, marks)
    )

    conn.commit()
    conn.close()

def view_students():
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM students")
    students = cursor.fetchall()

    conn.close()
    return students

def search_student(student_id):
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute(
        "SELECT * FROM students WHERE student_id = ?",
        (student_id,)
    )

    student = cursor.fetchone()
    conn.close()
    return student

def update_student(student_id, name, age, course, marks):
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute("""
        UPDATE students
        SET name = ?, age = ?, course = ?, marks = ?
        WHERE student_id = ?
    """, (name, age, course, marks, student_id))

    conn.commit()
    updated = cursor.rowcount
    conn.close()
    return updated

def delete_student(student_id):
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute(
        "DELETE FROM students WHERE student_id = ?",
        (student_id,)
    )

    conn.commit()
    deleted = cursor.rowcount
    conn.close()
    return deleted
