from csv import DictReader
from cs50 import SQL


def main():
    while True:
        try:
            database_name = input('New database name: ')
            open(database_name, 'x')
        except:
            print('File already exist')
            continue
        break

    students = []
    houses = []
    heads = []
    with open('students.csv') as students_file:
        students_dict = DictReader(students_file)
        for student in students_dict:
            students.append(student['student_name'])
            if student['house'] not in houses:
                houses.append(student['house'])
                heads.append(student['head'])

        database = SQL(f'sqlite:///{database_name}')

        with open('schema.sql') as schema:
            schemas = schema.read().split(';')
            for i in range(len(schemas)):
                print(schemas[i])
                database.execute(schemas[i] + ';')

        for i in range(len(students)):
            id = i + 1
            database.execute('INSERT INTO students(id, name) VALUES (?, ?)', id, students[i])

        for i in range(len(houses)):
            id = i + 1
            database.execute('INSERT INTO houses (id, house, head) VALUES (?, ?, ?)', id, houses[i], heads[i])

        students_file.seek(0)
        houses_table = database.execute('SELECT id, house FROM houses')
        for student in students_dict:
            for house in houses_table:
                if student.get('house') == house.get('house'):
                    database.execute('INSERT INTO assign (student_id, house_id) VALUES (?, ?)', student.get('id'), house.get('id'))


if __name__ == '__main__':
    main()
