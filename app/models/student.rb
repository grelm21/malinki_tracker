class Student < ApplicationRecord
  belongs_to :user, optional: true
  has_many :classrooms_students
  has_many :classrooms, through: :classrooms_students

  has_and_belongs_to_many :teachers

  attribute :classroom_id, type: :string, default: nil
  attribute :wage_cents, default: 0
  attribute :length, default: 0
  attribute :payment_type, default: 'regular'
  attribute :schedule, default: []

  monetize :wage_cents

  validates :name, presence: true

  after_create :create_classroom, if: -> { classroom_id.eql?('') }
  after_create_commit :create_user

  private

  def create_classroom
    classroom = Classroom.create!(name:, wage_cents:, length:, schedule:,
                                  teacher_id: teachers.first.id)
    ClassroomsStudent.create!(student: self, classroom:, payment_type:)
  end

  def create_user
    password = rand(1000..9999).to_s
    User.create!(login: "student#{id}", password:, role: 'student')
    update!(saved_password: password)
  end
end
