class Classroom < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :classrooms_students
  has_many :students, through: :classrooms_students

  enum :status, %i[active inactive], default: :active
  enum :class_format, %i[multi single], default: :single
end
