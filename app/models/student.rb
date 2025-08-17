class Student < ApplicationRecord
  belongs_to :user, optional: true
  has_many :classrooms_students
  has_many :classrooms, through: :classrooms_students

  has_and_belongs_to_many :teachers

  attribute :classroom_id, type: :string, default: nil
  attribute :wage, default: 0
  attribute :length, default: 0
  attribute :payment_type, default: 'regular'
  attribute :schedule, default: []

  validates :name, presence: true

  before_create :create_user
  after_create_commit :create_classroom, if: -> { classroom_id.eql?('') }

  private

  def create_classroom
    p teachers.first.inspect
    classroom = Classroom.create!(name:, wage:, length:, schedule:,
                                  teacher_id: teachers.first.id)
    ClassroomsStudent.create!(student: self, classroom:, payment_type:)
  end

  def create_user
    User.create!(login: name, password: '123456')
  end

  def add_teacher
    p teacher
  end
end
