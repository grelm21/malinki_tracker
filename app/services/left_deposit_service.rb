class LeftDepositService < ApplicationService
  def initialize(classrooms)
    @classrooms = classrooms
  end

  def call
    Deposit.total_deposits_for_classrooms_student(classrooms_students)
  end

  private

  def classrooms_students
    @classrooms_students = @classrooms.flat_map { |classroom| classroom.classrooms_students.ids }
  end
end
