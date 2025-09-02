class Withdrawal < ApplicationRecord
  belongs_to :classrooms_student
  belongs_to :teacher

  has_and_belongs_to_many :deposits, dependent: :destroy

  monetize :amount_cents

  before_create -> { deposits << classrooms_student.deposits.by_date.first }, if: lambda {
    classrooms_student.pass?
  }
  after_create :add_deposit, if: -> { classrooms_student.regular? }
  before_destroy :delete_deposits, if: -> { classrooms_student.regular? }

  scope :total_withdrawals_for_classrooms_student, lambda { |cs_ids|
    ClassroomsStudent.where(id: cs_ids)
                     .left_outer_joins(:withdrawals)
                     .group(:id)
                     .sum(:amount_cents)
                     .transform_values do |cents|
      Money.new(cents, 'RUB')
    end
  }

  scope :by_date, -> { order(issued_at: :desc) }
  scope :sum_for_day, lambda { |date|
    sum = where(issued_at: date.beginning_of_day..date.end_of_day).sum(:amount_cents)
    Money.new(sum, 'RUB')
  }

  scope :sum_for_month, lambda { |date|
    sum = where(issued_at: date.beginning_of_month.beginning_of_day..date.end_of_month.end_of_day).sum(:amount_cents)
    Money.new(sum, 'RUB')
  }

  private

  def add_deposit
    deposits.create!(amount_cents: amount_cents, classrooms_student:, issued_at: issued_at)
  end

  def delete_deposits
    deposits.all.destroy_all
  end
end
