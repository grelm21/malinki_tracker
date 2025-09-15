class Classroom < ApplicationRecord
  resourcify
  include ClassroomValidatorsConcern

  belongs_to :teacher, dependent: :destroy
  has_many :classrooms_students
  has_many :students, through: :classrooms_students

  monetize :wage_cents

  enum :status, %i[active inactive], default: :active
  enum :class_format, %i[multi single], default: :single

  scope :with_lesson_on_date, ->(date) { where('schedule && ARRAY[?]::text[]', [date.wday.to_s]) }
  scope :active, -> { where(status: :active) }
end
