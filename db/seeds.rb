user = User.create(login: 'Grigorii', email: 'ex@ya.ru', password: '123456', approved: true)
teacher = user.teacher

# classroom = teacher.classrooms.create!(name: 'Егор', wage_cents: 120000, length: 60, schedule: %w[1 3])
egor = teacher.students.new(name: 'Егор', contact_details: 'Егор', classroom_id: '', wage_cents: 120000, length: 60, schedule: %w[1 3])
egor.teachers << user.teacher
egor.save!
# ClassroomsStudent.create(classroom: classroom, student: egor, payment_type: :pass)

# classroom = teacher.classrooms.create(name: 'Миша', wage_cents: 130000, length: 60, schedule: %w[2 4])
student = teacher.students.new(name: 'Миша', contact_details: 'мама Татьяна, +7 876 765 45 45', classroom_id: '', wage_cents: 130000, length: 60, schedule: %w[2 4])
student.teachers << user.teacher
student.save!
# ClassroomsStudent.create(classroom: classroom, student: student, payment_type: :regular)

# classroom = teacher.classrooms.create!(name: 'Upper-Intermediate', wage_cents: 140000, length: 90,
#                                     schedule: %w[5 6 0], class_format: :multi)
# student_one = teacher.students.create!(name: 'Татьяна', contact_details: 'номер +7 898 98 98')
# ClassroomsStudent.create(classroom: classroom, student: student_one, payment_type: :pass)
# student_two = teacher.students.create!(name: 'Анна', contact_details: 'только мэйл')
# ClassroomsStudent.create(classroom: classroom, student: student_two, payment_type: :regular)
# ClassroomsStudent.create(classroom: classroom, student: egor, payment_type: :regular)
#
# classroom.update!(students: [student_one, student_two, egor])
