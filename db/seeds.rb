user = User.create(login: 'Grigorii', email: 'ex@ya.ru', password: '123456')
teacher = user.teacher

classroom = teacher.classrooms.create!(name: 'Егор', wage: 1200, length: 60, schedule: %w[Monday Wednesday])
student = teacher.students.create!(name: 'Егор', contact_details: 'Егор')
ClassroomsStudent.create(classroom: classroom, student: student, payment_type: :pass)

# classroom = user.classrooms.create(name: 'Миша', user:, wage: 1300, length: 60, schedule: %w[Tuesday Friday], status: 'inactive')
# student = Student.create!(name: 'Миша', contact_details: 'мама Татьяна, +7 876 765 45 45')
# ClassroomsStudent.create(classroom: classroom, student: student, payment_type: :regular)
#
# classroom = user.classrooms.create!(name: 'Upper-Intermediate', user:, wage: 1400, length: 90,
#                                     schedule: %w[Monday Wednesday Friday], class_format: :multi)
# student_one = user.students.create!(name: 'Татьяна', contact_details: 'номер +7 898 98 98')
# ClassroomsStudent.create(classroom: classroom, student: student_one, payment_type: :pass)
# student_two = user.students.create!(name: 'Анна', contact_details: 'только мэйл')
# ClassroomsStudent.create(classroom: classroom, student: student_two, payment_type: :regular)

# classroom.update!(students: [student_one, student_two])
