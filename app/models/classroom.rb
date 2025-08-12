class Classroom < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_and_belongs_to_many :students

  enum :status, %i[active inactive], default: :active
  enum :class_format, %i[multi single], default: :single
end
