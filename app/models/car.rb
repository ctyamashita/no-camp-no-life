class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo
  include PgSearch::Model
  pg_search_scope :search_by_car_model_and_address_and_description_and_capacity,
                  against: [ :car_model, :address, :description, :capacity ],
                  using: {
                    tsearch: { prefix: true }
                  }

  validates :price_per_day, numericality: { only_integer: true }
  validates :capacity, numericality: { only_integer: true }
  validates :car_model, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
