
from database import (
    create_table,
    add_student,
    view_students,
    search_student,
    update_student,
    delete_student,
    get_grade
)

from reports import export_report, create_marks_chart


def add_new_student():
    print("\n--- Add Student ---")

    student_id = int(input("Enter Student ID: "))
    name = input("Enter Name: ")
    age = int(input("Enter Age: "))
    course = input("Enter Course: ")
    marks = float(input("Enter Marks: "))

    add_student(student_id, name, age, course, marks)
    print("Student added successfully!")


def show_students():
    print("\n--- Student Records ---")

    students = view_students()

    if not students:
        print("No student records found.")
        return

    for student in students:
        print(student, "Grade:", get_grade(student[4]))


def find_student():
    student_id = int(input("Enter Student ID: "))
    student = search_student(student_id)

    if student:
        print("Student Found:", student)
        print("Grade:", get_grade(student[4]))
    else:
        print("Student not found.")


def edit_student():
    student_id = int(input("Enter Student ID to update: "))

    student = search_student(student_id)

    if not student:
        print("Student not found.")
        return

    name = input("Enter New Name: ")
    age = int(input("Enter New Age: "))
    course = input("Enter New Course: ")
    marks = float(input("Enter New Marks: "))

    updated = update_student(
        student_id, name, age, course, marks
    )

    if updated:
        print("Student updated successfully!")
    else:
        print("Student not found.")


def remove_student():
    student_id = int(input("Enter Student ID to delete: "))

    deleted = delete_student(student_id)

    if deleted:
        print("Student deleted successfully!")
    else:
        print("Student not found.")


def main():
    create_table()

    while True:
        print("\n===== STUDENT MANAGEMENT SYSTEM =====")
        print("1. Add Student")
        print("2. View Students")
        print("3. Search Student")
        print("4. Update Student")
        print("5. Delete Student")
        print("6. Export CSV Report")
        print("7. Create Marks Chart")
        print("8. Exit")

        choice = input("Enter your choice (1-8): ")

        try:
            if choice == "1":
                add_new_student()
            elif choice == "2":
                show_students()
            elif choice == "3":
                find_student()
            elif choice == "4":
                edit_student()
            elif choice == "5":
                remove_student()
            elif choice == "6":
                export_report()
            elif choice == "7":
                create_marks_chart()
            elif choice == "8":
                print("Thank you for using Student Management System!")
                break
            else:
                print("Invalid choice. Please try again.")

        except ValueError:
            print("Please enter valid numbers.")
        except Exception as error:
            print("An error occurred:", error)


if __name__ == "__main__":
    main()
