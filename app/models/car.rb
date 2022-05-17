class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings

  has_one_attached :photo

  validates :price_per_day, numericality: { only_integer: true }
  validates :capacity, numericality: { only_integer: true }
  validates :car_model, presence: true
end
