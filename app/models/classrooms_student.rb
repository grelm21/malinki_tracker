class ClassroomsStudent < ApplicationRecord
  belongs_to :classroom
  belongs_to :student
  
  enum :payment_type, %i[regular pass], default: :regular
end
