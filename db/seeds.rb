user = User.create(login: 'Grigorii', email: 'ex@ya.ru', password: '123456')
teacher = user.teacher

classroom = teacher.classrooms.create!(name: 'Егор', wage_cents: 120000, length: 60, schedule: %w[Monday Wednesday])
egor = teacher.students.create!(name: 'Егор', contact_details: 'Егор')
ClassroomsStudent.create(classroom: classroom, student: egor, payment_type: :pass)

classroom = teacher.classrooms.create(name: 'Миша', wage_cents: 130000, length: 60, schedule: %w[Tuesday Friday])
student = teacher.students.create!(name: 'Миша', contact_details: 'мама Татьяна, +7 876 765 45 45')
ClassroomsStudent.create(classroom: classroom, student: student, payment_type: :regular)

classroom = teacher.classrooms.create!(name: 'Upper-Intermediate', wage_cents: 140000, length: 90,
                                    schedule: %w[Monday Wednesday Friday], class_format: :multi)
student_one = teacher.students.create!(name: 'Татьяна', contact_details: 'номер +7 898 98 98')
ClassroomsStudent.create(classroom: classroom, student: student_one, payment_type: :pass)
student_two = teacher.students.create!(name: 'Анна', contact_details: 'только мэйл')
ClassroomsStudent.create(classroom: classroom, student: student_two, payment_type: :regular)
ClassroomsStudent.create(classroom: classroom, student: egor, payment_type: :regular)

classroom.update!(students: [student_one, student_two, egor])
