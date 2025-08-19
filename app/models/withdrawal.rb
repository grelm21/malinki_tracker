class Withdrawal < ApplicationRecord
  belongs_to :classrooms_student
  belongs_to :teacher

  monetize :amount_cents
end
