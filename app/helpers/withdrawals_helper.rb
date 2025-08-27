module WithdrawalsHelper
  def withdrawal_for_current_day?(classroom, student, date)
    classroom_student = classrooms_students_from_classroom(classroom, student)
    return true if classroom_student.withdrawals.select { |w| w.issued_at.to_date.eql? date }.any?

    false
  end
end
