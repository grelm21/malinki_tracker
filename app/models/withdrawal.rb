class Withdrawal < ApplicationRecord
  belongs_to :classrooms_student
  belongs_to :teacher

  monetize :amount_cents

  after_create :create_deposit, if: -> { classrooms_student.regular? }

  scope :total_withdrawals_for_classrooms_student, lambda { |cs_ids|
    ClassroomsStudent.where(id: cs_ids)
                     .left_outer_joins(:withdrawals)
                     .group(:id)
                     .sum(:amount_cents)
                     .transform_values do |cents|
      Money.new(cents, 'RUB')
    end
  }

  private def create_deposit
    Deposit.create!(amount_cents: amount_cents, classrooms_student:, issued_at: issued_at)
  end
end
