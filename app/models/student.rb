class Student < ApplicationRecord
  belongs_to :user
  has_many :classrooms_students
  has_many :classrooms, through: :classrooms_students

  attribute :classroom_id, type: :string, default: nil
  attribute :wage, default: 0
  attribute :length, default: 0
  attribute :payment_type, default: 'regular'
  attribute :schedule, default: []

  validates :name, presence: true

  after_create_commit :create_classroom, if: -> { classroom_id.eql?('') }

  private

  def create_classroom
    p '_---___---___---___---'
    classroom = Classroom.create!(name:, wage:, length:, schedule:, user: user)
    ClassroomsStudent.create!(student: self, classroom:, payment_type:)
  end
end
