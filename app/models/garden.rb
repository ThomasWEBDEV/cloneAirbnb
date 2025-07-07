class Garden < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  validates :title, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :price_per_day, presence: true, numericality: { greater_than: 0 }

  # geolocation
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # garden results in search bar
  include PgSearch::Model
  pg_search_scope :garden_search,
    against: [:title, :description, :address],
    using: {
      tsearch: { prefix: true }
    }
end
