module ClassroomsStudentsHelper
  def can_change_payment_type?(classrooms_student, left_deposit)
    return true if classrooms_student.regular?
    return true if classrooms_student.pass? && left_deposit.zero?

    false
  end
end
