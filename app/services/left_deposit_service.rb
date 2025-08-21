class LeftDepositService < ApplicationService
  def initialize(classrooms)
    @classrooms = classrooms
  end

  def call
    count_left_deposits
  end

  private

  def classrooms_students
    @classrooms_students = @classrooms.flat_map { |classroom| classroom.classrooms_students.ids }
  end

  def total_deposits
    @total_deposits ||= Deposit.total_deposits_for_classrooms_student(classrooms_students)
  end

  def total_withdrawals
    @total_withdrawals ||= Withdrawal.total_withdrawals_for_classrooms_student(classrooms_students)
  end

  def count_left_deposits
    (total_deposits.keys | total_withdrawals.keys).to_h do |cs_id|
      deposit = total_deposits[cs_id] || Money.new(0, 'RUB')
      withdrawal = total_withdrawals[cs_id] || Money.new(0, 'RUB')

      [cs_id, deposit - withdrawal]
    end
  end
end
