class Withdrawal < ApplicationRecord
  belongs_to :classrooms_student
  belongs_to :teacher

  monetize :amount_cents

  scope :total_withdrawals_for_classrooms_student, ->(cs_ids) {
    ClassroomsStudent.where(id: cs_ids)
                     .left_outer_joins(:withdrawals)
                     .group(:id)
                     .sum(:amount_cents)
                     .transform_values do |cents|
      Money.new(cents, 'RUB')
    end
  }
end
