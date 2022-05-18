class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user
  has_many :users, through: :cars

  enum status: { pending: 0, confirmed: 1, rejected: 2 }

  validates :start_date, presence: true
  validates :end_date, presence: true
  # validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
