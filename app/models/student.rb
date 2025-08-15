class Student < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :classrooms_students
  has_many :classrooms, through: :classrooms_students
end
