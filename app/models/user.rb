class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable

  attribute :role, default: 'teacher'
  attribute :approved, default: false

  validates :login, presence: true
  validates :login, uniqueness: true
  validates :email, uniqueness: true, allow_blank: true

  has_one :student
  has_one :teacher

  after_create :add_global_role, if: -> { role.eql?('teacher') }
  after_create_commit :create_teacher, if: -> { role.eql?('teacher') }

  scope :with_teachers, -> { where.associated(:teacher) }
  scope :with_new_teachers_count, -> { with_teachers.where(approved: false).count }

  def email_changed?
    false
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end

  def admin?
    has_role?(:admin)
  end

  def self.new_teachers?
    User.with_new_teachers_count > 1
  end

  private

  def create_teacher
    create_teacher!(name: login)
  end

  def add_global_role
    add_role role
  end
end
