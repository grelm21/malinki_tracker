module StudentsHelper
  def classrooms_students_id_from_classroom(classroom, student)
    classroom.classrooms_students.select { |cs| cs.student_id.eql?(student.id) }.flat_map(&:id).first
  end
end
