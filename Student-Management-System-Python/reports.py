
import pandas as pd
import matplotlib.pyplot as plt

from database import view_students, get_grade


def export_report():
    students = view_students()

    if not students:
        print("No student records found.")
        return

    columns = ["Student ID", "Name", "Age", "Course", "Marks"]

    df = pd.DataFrame(students, columns=columns)
    df["Grade"] = df["Marks"].apply(get_grade)

    df.to_csv("student_report.csv", index=False)

    print("Report exported successfully!")


def create_marks_chart():
    students = view_students()

    if not students:
        print("No student records found.")
        return

    names = [student[1] for student in students]
    marks = [student[4] for student in students]

    plt.bar(names, marks)
    plt.xlabel("Student Name")
    plt.ylabel("Marks")
    plt.title("Student Marks Report")
    plt.xticks(rotation=45)
    plt.tight_layout()

    plt.savefig("student_marks_chart.png")
    plt.show()

    print("Chart created successfully!")
