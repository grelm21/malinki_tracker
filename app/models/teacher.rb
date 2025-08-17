class Teacher < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :students
  has_many :classrooms
end
