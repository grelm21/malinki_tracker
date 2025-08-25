class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable

  attribute :role, default: 'teacher'

  validates :login, presence: true
  validates :login, uniqueness: true
  validates :email, uniqueness: true, allow_blank: true

  has_one :student
  has_one :teacher

  def email_changed?
    false
  end

  after_create_commit :create_teacher, if: -> { role.eql?('teacher') }

  private

  def create_teacher
    create_teacher!(name: login)
  end
end
