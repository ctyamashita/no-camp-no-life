class Car < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :bookings

  validates :price_per_day, numericality: { only_integer: true }
  validates :capacity, numericality: { only_integer: true }
  validates :car_model, presence: true
end
