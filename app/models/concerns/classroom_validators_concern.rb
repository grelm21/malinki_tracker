module ClassroomValidatorsConcern
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
    validates :wage_cents, numericality: { greater_than: 0 }
    validates :length, numericality: { greater_than: 0 }
    validate :schedule_validation
  end

  def schedule_validation
    return if schedule.any?

    errors.add(:schedule, 'не может быть пустым')
  end
end
