class ClassroomsStudent < ApplicationRecord
  belongs_to :classroom
  belongs_to :student

  has_many :deposits
  has_many :withdrawals

  enum :payment_type, %i[regular pass], default: :regular
end
