user = User.create(login: 'grelm', email: 'ex@ya.ru', password: '123456', approved: true)
user.add_role(:admin)
teacher = user.teacher

student = teacher.students.new(name: 'Иван', contact_details: '', classroom_id: '', wage_cents: 170_000, length: 60,
                            schedule: %w[1 4])
student.teachers << user.teacher
student.save!

student = teacher.students.new(name: 'Миша', contact_details: '', classroom_id: '',
                               wage_cents: 150_000, length: 60, schedule: %w[2 4])
student.teachers << user.teacher
student.save!

student = teacher.students.new(name: 'Егор', contact_details: 'Егор', classroom_id: '', wage_cents: 120_000, length: 60,
                            schedule: %w[1 3], payment_type: :pass)
student.teachers << user.teacher
student.save!

student = teacher.students.new(name: 'Алена', contact_details: '', classroom_id: '',
                               wage_cents: 190_000, length: 60, schedule: %w[2 4])
student.teachers << user.teacher
student.save!

student = teacher.students.new(name: 'Мария', contact_details: 'Егор', classroom_id: '', wage_cents: 170_000, length: 60,
                            schedule: %w[1 4])
student.teachers << user.teacher
student.save!

student = teacher.students.new(name: 'Сергей', contact_details: '', classroom_id: '',
                               wage_cents: 200_000, length: 60, schedule: %w[2 4], payment_type: :pass)
student.teachers << user.teacher
student.save!
#
# User.create(login: 'valeria', password: '123456')
# User.create(login: 'tatiyana', password: '123456')
# User.create(login: 'valentina', password: '123456')
# User.create(login: 'anna', password: '123456')

# classroom = teacher.classrooms.create!(name: 'Upper-Intermediate', wage_cents: 140000, length: 90,
#                                     schedule: %w[5 6 0], class_format: :multi)
# student_one = teacher.students.create!(name: 'Татьяна', contact_details: 'номер +7 898 98 98')
# ClassroomsStudent.create(classroom: classroom, student: student_one, payment_type: :pass)
# student_two = teacher.students.create!(name: 'Анна', contact_details: 'только мэйл')
# ClassroomsStudent.create(classroom: classroom, student: student_two, payment_type: :regular)
# ClassroomsStudent.create(classroom: classroom, student: egor, payment_type: :regular)
#
# classroom.update!(students: [student_one, student_two, egor])
