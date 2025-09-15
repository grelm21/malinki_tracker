class Deposit < ApplicationRecord
  belongs_to :classrooms_student
  has_and_belongs_to_many :withdrawals, dependent: :destroy
  monetize :amount_cents

  scope :deposits_for_classroom_student, lambda { |student, classroom|
    joins(:classrooms_student).where(classrooms_students: { student:, classroom: })
  }

  scope :total_deposits_for_classrooms_student, lambda { |cs_ids, date|
    ClassroomsStudent.where(id: cs_ids)
                     .left_outer_joins(:deposits)
                     .where(deposits: { issued_at: ...date.end_of_day })
                     .group(:id)
                     .sum(:amount_cents)
                     .transform_values do |cents|
      Money.new(cents, 'RUB') || Money.new(0, 'RUB')
    end
  }

  scope :by_date, -> { order(issued_at: :desc) }

  before_destroy :delete_withdrawals, if: -> { classrooms_student.pass? }

  def self.get_deposit_amount_for_classroom_student(student, classroom)
    deposits_for_classroom_student(student, classroom).sum(&:amount)
  end

  def self.filter_classroom_students(classrooms_students, classroom)
    classrooms_students.select { |cs| cs.classroom_id.eql?(classroom.id) }
  end

  private

  def delete_withdrawals
    withdrawals.all.destroy_all
  end
end
