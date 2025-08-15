user = User.create(name: 'Grigorii', email: 'ex@ya.ru', password: '123456')

student = user.students.create!(name: 'Егор', contact_details: 'Егор')
student.classrooms.create!(name: 'Егор', user:, wage: 1200, length: 60, schedule: %w[Monday Wednesday])

student = user.students.create!(name: 'Миша', contact_details: 'мама Татьяна, +7 876 765 45 45')
student.classrooms.create(name: 'Миша', user:, wage: 1300, length: 60, schedule: %w[Tuesday Friday], status: 'inactive')

classroom = user.classrooms.create!(name: 'Upper-Intermediate', user:, wage: 1400, length: 90, schedule: %w[Monday Wednesday Friday], class_format: :multi)
student_one = user.students.create!(name: 'Татьяна', contact_details: 'номер +7 898 98 98')
student_two = user.students.create!(name: 'Анна', contact_details: 'только мэйл')

classroom.update!(students: [student_one, student_two])
