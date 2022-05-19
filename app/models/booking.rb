class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user
  has_many :users, through: :cars

  enum status: { pending: 0, confirmed: 1, rejected: 2 }

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :check_dates

  def check_dates
    errors.add(:end_date, "should not be before start date") if end_date && start_date && end_date <= start_date
  end
end
