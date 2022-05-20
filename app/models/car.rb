class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  include PgSearch::Model
  pg_search_scope :search_by_car_model_and_description_and_capacity,
                  against: [ :car_model, :description, :capacity ],
                  using: {
                    tsearch: { prefix: true }
                  }

  validates :price_per_day, numericality: { only_integer: true, greater_than: 0 }
  validates :capacity, numericality: { only_integer: true, greater_than: 1 }
  validates :car_model, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
