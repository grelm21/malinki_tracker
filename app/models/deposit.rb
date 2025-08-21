class Deposit < ApplicationRecord
  belongs_to :classrooms_student
  monetize :amount_cents

  scope :deposits_for_classroom_student, lambda { |student, classroom|
    joins(:classrooms_student).where(classrooms_students: { student:, classroom: })
  }

  scope :total_deposits_for_classrooms_student, ->(cs_ids) {
    ClassroomsStudent.where(id: cs_ids)
                     .left_outer_joins(:deposits)
                     .group(:id)
                     .sum(:amount_cents)
                     .transform_values do |cents|
      Money.new(cents, 'RUB')
    end
  }

  def self.get_deposit_amount_for_classroom_student(student, classroom)
    deposits_for_classroom_student(student, classroom).sum(&:amount)
  end

  def self.filter_classroom_students(classrooms_students, classroom)
    classrooms_students.select { |cs| cs.classroom_id.eql?(classroom.id) }
  end
end
