class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings

  has_one_attached :photo

  validates :price_per_day, numericality: { only_integer: true }
  validates :capacity, numericality: { only_integer: true }
  validates :car_model, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
