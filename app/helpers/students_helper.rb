module StudentsHelper
  def classrooms_students_id_from_classroom(classroom, student)
    classroom.classrooms_students.select { |cs| cs.student_id.eql?(student.id) }.first
  end

  def show_left_deposit(left_deposits, classroom, student)
    left_deposits[classrooms_students_id_from_classroom(classroom, student).id]
  end

  def sufficient_deposit?(left_deposits, classroom, student, classroom_wage)
    return true if show_left_deposit(left_deposits, classroom, student) >= classroom_wage

    false
  end

  def classroom_student_decorator(left_deposits, classroom, student, classroom_wage)
    'text-red-500'.html_safe unless sufficient_deposit?(left_deposits, classroom, student, classroom_wage)
  end
end
