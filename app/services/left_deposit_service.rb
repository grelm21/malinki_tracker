class LeftDepositService < ApplicationService
  def initialize(classrooms, date = Date.today)
    @classrooms = classrooms
    @date = date
  end

  def call
    count_left_deposits
  end

  private

  def classrooms_students
    @classrooms_students = @classrooms.flat_map { |classroom| classroom.classrooms_students.ids }
  end

  def total_deposits
    @total_deposits ||= Deposit.total_deposits_for_classrooms_student(classrooms_students, @date)
    @total_deposits
  end

  def total_withdrawals
    @total_withdrawals ||= Withdrawal.total_withdrawals_for_classrooms_student(classrooms_students, @date)
  end

  def count_left_deposits
    deposits = total_deposits
    withdrawals = total_withdrawals
    classrooms_students.each.to_h do |cs_id|
      deposit = deposits[cs_id] || Money.new(0, 'RUB')
      withdrawal = withdrawals[cs_id] || Money.new(0, 'RUB')
      [cs_id, deposit - withdrawal]
    end
  end
end
